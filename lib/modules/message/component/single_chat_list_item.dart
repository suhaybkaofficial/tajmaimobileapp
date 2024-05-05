import 'package:flutter/material.dart';
import '../../../core/router_name.dart';
import '../model_dummy/chat_list_model.dart';

class SingleChatListItem extends StatelessWidget {
  const SingleChatListItem({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ChatListModel item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.messageScreen);
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 16, top: 16),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xffE8F4FF), width: 1),
          ),
        ),
        child: Row(
          children: [
            const CircleAvatar(radius: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.msg,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(fontSize: 14, color: Color(0xff85959E)),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildNumberOfMessage(item.numberOfMsg),
                const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: Text(
                    item.dateTime,
                    style: TextStyle(color: Colors.grey.shade400),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNumberOfMessage(String s) {
    if (s.isEmpty) {
      return Container(
        width: 20,
        margin: const EdgeInsets.only(left: 16),
        height: 20,
      );
    }
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xff18587A)),
      child: Center(
        child: Text(
          item.numberOfMsg,
          style: const TextStyle(
              color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
