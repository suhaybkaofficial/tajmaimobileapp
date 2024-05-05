// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

class ChatStateModel extends Equatable {
  final String sellerId;
  final String message;
  final String productId;  
  final ChatState state;

  const ChatStateModel({
     this.sellerId ="",
     this.message = "",
     this.productId="",
    this.state = const ChatInitial(),
  });
  

  ChatStateModel copyWith({
    String? sellerId,
    String? message,
    String? productId,
    ChatState? state,
  }) {
    return ChatStateModel(
      sellerId: sellerId ?? this.sellerId,
      message: message ?? this.message,
      productId: productId ?? this.productId,
      state: state ?? this.state,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'seller_id': sellerId,
      'message': message,
      'product_id': productId,
    };
  }

  factory ChatStateModel.fromMap(Map<String, dynamic> map) {
    return ChatStateModel(
      sellerId: map['seller_id'] as String,
      message: map['message'] as String,
      productId: map['product_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatStateModel.fromJson(String source) => ChatStateModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [sellerId, message, productId,state];
}


abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {
  const ChatInitial();
}

class ChatLoading extends ChatState {}

class ChatError extends ChatState {
  final String message;
  const ChatError(this.message);

  @override
  List<Object> get props => [message];
}


class ChatLoaded extends ChatState {
  final List<SellerDto> chatsData;
  const ChatLoaded(this.chatsData);

  @override
  List<Object> get props => [chatsData];
}
class InboxMessages extends ChatState {
  final List<MessagesDto> inboxMessages;
  const InboxMessages(this.inboxMessages);

  @override
  List<Object> get props => [inboxMessages];
}

class SignleChatLoaded extends ChatState {
  final SendMessageResponseDto chatsData;
  const SignleChatLoaded(this.chatsData);

  @override
  List<Object> get props => [chatsData];
}

