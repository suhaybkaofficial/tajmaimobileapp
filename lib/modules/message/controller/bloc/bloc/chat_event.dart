part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatStarted extends ChatEvent {
  const ChatStarted();

  @override
  List<Object> get props => [];
}

class SendMsgData extends ChatEvent {
  final SendMsgModel sendMsgModel;
  const SendMsgData(this.sendMsgModel);

  @override
  List<Object> get props => [sendMsgModel];
}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent();
}

class AddNewMessage extends ChatEvent {
  final MessagesDto newMessage;

  const AddNewMessage(this.newMessage);

  @override
  List<Object> get props => [newMessage];
}

class SelectedChat extends ChatEvent {
  final SellerDto selectChat;

  const SelectedChat(this.selectChat);

  @override
  List<Object> get props => [selectChat];
}

class SelectedSeller extends ChatEvent {
  final InboxSelectedSeller seller;

  const SelectedSeller(this.seller);

  @override
  List<Object> get props => [seller];
}


class SendProductToSeller extends ChatEvent {
  final ProductDetailsModel productModel;

  const SendProductToSeller(this.productModel);

  @override
  List<Object> get props => [productModel];
}