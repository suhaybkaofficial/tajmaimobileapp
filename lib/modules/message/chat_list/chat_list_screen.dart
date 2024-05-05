import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/router_name.dart';
import '../../../utils/laravel_echo/laravel_echo.dart';
import '../../../utils/utils.dart';
import '../../../widgets/blank_content.dart';
import '../../../widgets/rounded_app_bar.dart';
import '../../../widgets/startup_container.dart';
import '../../authentication/controller/login/login_bloc.dart';
import '../controller/bloc/bloc/chat_bloc.dart';
import '../models/inbox_seller.dart';
import 'chat_list_item.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  // static const routeName = "chat-list";

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(const ChatStarted());
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<LoginBloc>();
    final chatBloc = context.read<ChatBloc>();

    return StartUpContainer(
      onInit: () async {
        // userBloc.add(const UserStarted());
        LaravelEcho.init(token: authBloc.userInfo!.accessToken);
      },
      onDisposed: () {
        LaravelEcho.instance.disconnect();
      },
      child: Scaffold(
        appBar: RoundedAppBar(
          titleText: "Messages",
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            chatBloc.add(const ChatStarted());
            // userBloc.add(const UserStarted());
          },
          child: BlocBuilder<ChatBloc, ChatStateModel>(
            // listener: (_, __) {},
            builder: (context, state) {
              final s = state.state;
              if (s is ChatLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (s is ChatLoaded) {
                if (s.chatsData.isEmpty) {
                  return const BlankContent(
                    content: "No chat available",
                    icon: Icons.chat_rounded,
                  );
                } else {
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final item = s.chatsData[index];
                      return ChatListItem(
                        key: ValueKey(item.shopOwnerId),
                        item: item,
                        onPressed: (chat) {
                          chatBloc.add(SelectedSeller(
                            InboxSelectedSeller(
                              id: chat.shopOwnerId,
                              name: chat.shopName,
                              image: chat.shopLogo,
                            ),
                          ));
                          Navigator.of(context)
                              .pushNamed(RouteNames.chatScreen);
                        },
                      );
                    },
                    separatorBuilder: (_, __) => Divider(
                      height: 12,
                      color: Utils.dynamicPrimaryColor(context),
                    ),
                    itemCount: s.chatsData.length,
                  );
                }
              }
              if (s is ChatError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        s.message,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 16),
                      CircleAvatar(
                        backgroundColor: Utils.dynamicPrimaryColor(context),
                        child: IconButton(
                            onPressed: () {
                              chatBloc.add(const ChatStarted());
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.black,
                            )),
                      )
                    ],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
