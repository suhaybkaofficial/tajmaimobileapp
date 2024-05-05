part of 'edit_address_cubit.dart';

abstract class EditAddressState extends Equatable {
  const EditAddressState();

  @override
  List<Object> get props => [];
}

class EditAddressInitial extends EditAddressState {}


class EditAddressLoading extends EditAddressState {}

class EditAddressStateUpdateError extends EditAddressState {
  const EditAddressStateUpdateError(this.message, this.statusCode);

  final String message;
  final int statusCode;

  @override
  List<Object> get props => [message, statusCode];
}

class EditAddressStateLoaded extends EditAddressState {
  final EditAddressModel editAddressModel;
  const EditAddressStateLoaded(this.editAddressModel);

  @override
  List<Object> get props => [editAddressModel];
}
