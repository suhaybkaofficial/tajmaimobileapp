part of 'contact_us_form_bloc.dart';

class ContactUsFormState extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String subject;
  final String message;
  final ContactUsFormStatus status;

  const ContactUsFormState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.subject = '',
    this.message = '',
    this.status = const ContactUsFormStatusInitial(),
  });

  @override
  List<Object> get props => [name, email, subject, status, message];

  ContactUsFormState copyWith({
    String? name,
    String? email,
    String? phone,
    String? subject,
    String? message,
    ContactUsFormStatus? status,
  }) {
    return ContactUsFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  ContactUsFormState clear() {
    return const ContactUsFormState(
      name: '',
      email: '',
      phone: '',
      subject: '',
      message: '',
      status: ContactUsFormStatusInitial(),
    );
  }

  bool get isNameValide => name.length > 3;
  bool get isEmailValide => Utils.isEmail(email);
  bool get isSubjectValide => !Utils.isEmpty(email);
  bool get isMessageValide => !Utils.isEmpty(message);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'name': name});
    result.addAll({'email': email});
    result.addAll({'phone': phone});
    result.addAll({'subject': subject});
    result.addAll({'message': message});

    return result;
  }
}

class ContactUsFormStatus extends Equatable {
  const ContactUsFormStatus();
  @override
  List<Object> get props => [];
}

class ContactUsFormStatusInitial extends ContactUsFormStatus {
  const ContactUsFormStatusInitial();
}

class ContactUsFormStatusLoading extends ContactUsFormStatus {
  const ContactUsFormStatusLoading();
}
class ContactLoading extends ContactUsFormStatus {
  const ContactLoading();
}

class ContactUsFormStatusLoaded extends ContactUsFormStatus {
  final String message;
  const ContactUsFormStatusLoaded(this.message);

  @override
  List<Object> get props => [message];
}

class ContactUsFormValidateError extends ContactUsFormStatus{
  final Errors errors;
  const ContactUsFormValidateError(this.errors);
  @override
  List<Object> get props => [errors];
}

class ContactUsFormStatusError extends ContactUsFormStatus {
  final String errorMessage;
  const ContactUsFormStatusError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
