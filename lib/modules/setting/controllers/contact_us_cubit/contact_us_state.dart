part of 'contact_us_cubit.dart';

abstract class ContactUsState extends Equatable {
  const ContactUsState();

  @override
  List<Object> get props => [];
}

class ContactUsStateLoading extends ContactUsState {}

class ContactUsStateLoaded extends ContactUsState {
  final ContactUsModel contactUsModel;
  const ContactUsStateLoaded(this.contactUsModel);

  @override
  List<Object> get props => [contactUsModel];
}

class ContactUsStateError extends ContactUsState {
  final String errorMessage;
  const ContactUsStateError({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
