import 'package:equatable/equatable.dart';

class TransactionResponse extends Equatable {
  final String? message;
  final String? stripeToken;
  final bool? success;
  const TransactionResponse({this.message, this.stripeToken, this.success});

  @override
  List<Object?> get props {
    return [message, stripeToken, success];
  }
}
