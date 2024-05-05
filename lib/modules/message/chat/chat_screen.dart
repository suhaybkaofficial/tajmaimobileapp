import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:shop_o/modules/authentication/controller/login/login_bloc.dart';
import 'package:shop_o/modules/message/component/display_prodcut_card.dart';
import 'package:shop_o/modules/message/controller/cubit/inbox_cubit.dart';
import 'package:shop_o/modules/message/models/seller_messages_dto.dart';
import 'package:shop_o/utils/constants.dart';
import 'package:shop_o/widgets/rounded_app_bar.dart';

import '../../../utils/laravel_echo/laravel_echo.dart';
import '../../../utils/logger.dart';
import '../../../widgets/startup_container.dart';
import '../component/message_component.dart';
import '../component/message_input_field.dart';
import '../controller/bloc/bloc/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = ScrollController();
  late List<MessagesDto> allMessages = <MessagesDto>[];

  void listenChatChannel(SellerDto chat) {
    LaravelEcho.instance
        .private(
            'seller-to-user-message.${context.read<LoginBloc>().userInfo!.user.id}')
        .listen('SellerToUser', (e) {
      print("SellerTOUSer $e");
      if (e is PusherEvent) {
        if (e.data != null) {
          vLog(jsonDecode(e.data!));
          _handleNewMessage(jsonDecode(e.data!));
        }
      }
    }).error((err) {
      eLog(err);
    });
  }

  void leaveChatChannel(dynamic chat) {
    try {
      LaravelEcho.instance.leave('seller-to-user-message');
    } catch (err) {
      eLog(err);
    }
  }

  void _handleNewMessage(Map<String, dynamic> data) {
    final chatBloc = context.read<ChatBloc>();
    final selectedChat = chatBloc.messagesDto;
    if (selectedChat?.shopOwnerId.toString() == data['message']['seller_id']) {
      final chatMessage = MessagesDto.fromMap(data['message']);
      chatBloc.add(AddNewMessage(chatMessage));
      setState(() {});
      _scroller();
    }
  }

  _scroller() {
    // controller.animateTo(
    //   controller.position.maxScrollExtent,
    //   duration: const Duration(milliseconds: 500),
    //   curve: Curves.ease,
    // );
    controller.jumpTo(controller.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();
    allMessages = context.read<ChatBloc>().messagesDto != null
        ? context.read<ChatBloc>().messagesDto!.messages
        : [];
    // controller.addListener(_scroller);
  }

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    return StartUpContainer(
      onInit: () {
        /// create a chat and get chat messages
        // chatBloc.add(const GetChatMessage());
        // if (chatBloc.messagesDto != null) {
        listenChatChannel(chatBloc.messagesDto!);
        // }
        _scroller();
      },
      onDisposed: () {
        leaveChatChannel(chatBloc.messagesDto);
        // chatBloc.add(const ChatReset());
        chatBloc.add(const ChatStarted());
      },
      child: Scaffold(
        appBar: RoundedAppBar(
          titleText: chatBloc.seller.name,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatBloc, ChatStateModel>(
                    builder: (context, state) {
                      return GroupedListView<MessagesDto, DateTime>(
                        padding: const EdgeInsets.all(8).copyWith(bottom:60),
                        elements: chatBloc.messages,
                        controller: controller,
                        groupBy: (element) => DateTime(
                          DateTime.parse(element.createdAt).year,
                          DateTime.parse(element.createdAt).month,
                          DateTime.parse(element.createdAt).day,
                        ),
                        groupSeparatorBuilder: (DateTime groupByValue) =>
                            _MessageSeparator(groupByValue: groupByValue),

                        itemBuilder: (context, MessagesDto element) =>
                            MessageComponent(element: element),

                        itemComparator: (item1, item2) =>
                            DateTime.parse(item1.createdAt)
                                .compareTo(DateTime.parse(item2.createdAt)),
                        // optional
                        useStickyGroupSeparators: false,
                        // optional
                        floatingHeader: true,
                        // optional
                        order: GroupedListOrder.ASC, // optional
                      );
                    },
                  ),
                ),
                MessageInputField(
                  sellerId: chatBloc.seller.id.toString(),
                  onChange: (v) {
                    if (v) {
                      // setState(() {});
                      _scroller();
                    }
                  },
                ),
              ],
            ),
            BlocBuilder<InboxCubit, InboxState>(
              builder: (context, state) {
                if (state is InboxProductDataLoaded) {
                  return DisplayProductCard(
                    productDetailsModel: state.productModel,
                    onChange: (v) {
                      setState(() {});
                    },
                  );
                }
                return const SizedBox();
              },
            ),
          ],
        ),
        // body: ListView.builder(
        //     itemCount: chatBloc.messagesDto.messages.length,
        //     itemBuilder: (c,i){
        //       return Text(chatBloc.messagesDto.messages[i].message,textAlign: chatBloc.messagesDto.shopOwnerId == chatBloc.messagesDto.messages[i].sellerId ?  TextAlign.end : TextAlign.start,);
        //     }),
      ),
    );
  }
}

class _MessageSeparator extends StatelessWidget {
  const _MessageSeparator({
    Key? key,
    required this.groupByValue,
  }) : super(key: key);
  final DateTime groupByValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        DateFormat.yMMMMd("en_US").format(groupByValue),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: paragraphColor,
        ),
      ),
      // child: Center(
      //   child: DateChip(date: groupByValue, color: grayColor),
      // ),
    );
  }
}
