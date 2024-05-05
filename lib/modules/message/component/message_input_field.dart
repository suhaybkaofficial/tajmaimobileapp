import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../controller/bloc/bloc/chat_bloc.dart';
import '../models/send_message_model.dart';

class MessageInputField extends StatefulWidget {
  final String sellerId;
  final ValueChanged<bool> onChange;

  const MessageInputField(
      {Key? key, required this.sellerId, required this.onChange})
      : super(key: key);

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final editingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    editingController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatBloc = context.read<ChatBloc>();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0)
          .copyWith(bottom: 8),
      // decoration: BoxDecoration(
      //   color: const Color(0xff3b5998).withOpacity(0.06),
      //   borderRadius: BorderRadius.circular(32.0),
      // ),
      child: Row(
        children: [
          // Container(
          //   height: 34,
          //   width: 34,
          //   margin: const EdgeInsets.symmetric(horizontal: 5),
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //     color: Utils.dynamicPrimaryColor(context),
          //   ),
          //   child: const Icon(
          //     Icons.add,
          //     color: Colors.white,
          //     size: 22,
          //   ),
          // ),
          Flexible(
            child: TextField(
              focusNode: focusNode,
              textInputAction: TextInputAction.done,
              controller: editingController,
              decoration: inputDecorationTheme.copyWith(
                hintText: '${Language.typeHere}...',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    // widget.sellerDto
                    if (widget.sellerId != "0") {
                      chatBloc.add(
                        SendMsgData(
                          SendMsgModel(
                            sellerId: widget.sellerId,
                            message: editingController.text,
                            productId: '',
                          ),
                        ),
                      );
                    }
                    editingController.clear();
                    widget.onChange(true);
                  },
                  icon: Icon(Icons.send_rounded,
                      color: Utils.dynamicPrimaryColor(context), size: 30),
                ),
                fillColor: const Color(0xffE2E8EB),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
