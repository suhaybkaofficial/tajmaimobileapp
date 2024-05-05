part of 'contact_us_form_bloc.dart';

abstract class ContactUsFormEvent extends Equatable {
  const ContactUsFormEvent();

  @override
  List<Object> get props => [];
}

class ContactUsFormNameChange extends ContactUsFormEvent {
  final String name;
  const ContactUsFormNameChange(this.name);
  @override
  List<Object> get props => [name];
}

class ContactUsFormEmailChange extends ContactUsFormEvent {
  final String email;
  const ContactUsFormEmailChange(this.email);
  @override
  List<Object> get props => [email];
}

class ContactUsFormPhoneChange extends ContactUsFormEvent {
  final String phone;
  const ContactUsFormPhoneChange(this.phone);
  @override
  List<Object> get props => [phone];
}

class ContactUsFormSubjectChange extends ContactUsFormEvent {
  final String subject;
  const ContactUsFormSubjectChange(this.subject);
  @override
  List<Object> get props => [subject];
}

class ContactUsFormMessageChange extends ContactUsFormEvent {
  final String message;
  const ContactUsFormMessageChange(this.message);
  @override
  List<Object> get props => [message];
}

class ContactUsFormSubmit extends ContactUsFormEvent {
  const ContactUsFormSubmit();
}
