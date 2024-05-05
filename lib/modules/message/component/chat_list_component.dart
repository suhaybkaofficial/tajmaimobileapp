import 'package:flutter/material.dart';

import '../model_dummy/chat_list_model.dart';
import 'single_chat_list_item.dart';

class ChatListComponent extends StatelessWidget {
  const ChatListComponent({
    Key? key,
    required this.chatList,
  }) : super(key: key);
  final List<ChatListModel> chatList;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              SingleChatListItem(item: chatList[index % chatList.length]),
          childCount: 15,
        ),
      ),
    );
    // return ListView.builder(
    //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    //   itemCount: 15,
    //   itemBuilder: (_, index) =>
    //       SingleChatListItem(item: chatList[index % chatList.length]),
    // );
  }
}
