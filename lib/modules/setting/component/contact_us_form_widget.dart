import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../authentication/widgets/sign_up_form.dart';
import '/widgets/capitalized_word.dart';
import '../../../utils/constants.dart';
import '../../../utils/language_string.dart';
import '../../../utils/utils.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/contact_us_form_bloc/contact_us_form_bloc.dart';

class ContactUsFormWidget extends StatelessWidget {
  const ContactUsFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return BlocListener<ContactUsFormBloc, ContactUsFormState>(
      listener: (context, state) {
        if (state.status is ContactUsFormStatusError) {
          final status = state.status as ContactUsFormStatusError;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                  content: Text(status.errorMessage,
                      style: const TextStyle(color: Colors.red))),
            );
        } else if (state.status is ContactUsFormStatusLoaded) {
          final status = state.status as ContactUsFormStatusLoaded;
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(status.message)));
        }
      },
      child: const _FormWidget(),
    );*/
    return const _FormWidget();
  }

}

class _FormWidget extends StatelessWidget {
  const _FormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactUsFormBloc = context.read<ContactUsFormBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Language.sendUsMessage.capitalizeByWord(),
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600, height: 1.5),
        ),
        const SizedBox(height: 8),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            // buildWhen: (previous, current) => false,
            builder: (context, state) {
          final editState = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.name,
                initialValue: state.name,
                // validator: (s) => state.isNameValide ? null : "*Name is Required",
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormNameChange(value)),
                decoration: InputDecoration(
                  hintText: Language.name.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
              ),
              if (editState is ContactUsFormValidateError) ...[
                if (editState.errors.name.isNotEmpty)
                  ErrorText(text: editState.errors.name.first),
              ]
            ],
          );
        }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            // buildWhen: (previous, current) => false,
            builder: (context, state) {
          final editState = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: state.email,
                // validator: (s) => state.isEmailValide ? null : "*Email is Required",
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormEmailChange(value)),
                decoration: InputDecoration(
                  hintText: Language.emailAddress.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
              ),
              if (editState is ContactUsFormValidateError) ...[
                if (editState.errors.email.isNotEmpty)
                  ErrorText(text: editState.errors.email.first),
              ]
            ],
          );
        }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            buildWhen: (previous, current) => previous.phone != current.phone,
            builder: (context, state) {
              return TextFormField(
                keyboardType: TextInputType.phone,
                initialValue: state.phone,
                // validator: (p) => state.phone.isNotEmpty
                //     ? null
                //     : '*Phone Number is Required',
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormPhoneChange(value)),
                decoration: InputDecoration(
                  hintText: Language.phoneNumber.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
              );
            }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            // buildWhen: (previous, current) =>
            //     previous.subject != current.subject,
            builder: (context, state) {
          final editState = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                initialValue: state.subject,
                // validator: (s) =>
                //     state.isSubjectValide ? null : "*Subject is Required",
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormSubjectChange(value)),
                decoration: InputDecoration(
                  hintText: Language.subject.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
              ),
              if (editState is ContactUsFormValidateError) ...[
                if (editState.errors.subject.isNotEmpty)
                  ErrorText(text: editState.errors.subject.first),
              ]
            ],
          );
        }),
        const SizedBox(height: 16),
        BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            // buildWhen: (previous, current) =>
            //     previous.message != current.message,
            builder: (context, state) {
          final message = state.status;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.multiline,
                initialValue: state.message,
                // validator: (s) =>
                //     state.isMessageValide ? null : "*Message is Required",
                onChanged: (value) =>
                    contactUsFormBloc.add(ContactUsFormMessageChange(value)),
                decoration: InputDecoration(
                  hintText: Language.message.capitalizeByWord(),
                  fillColor: borderColor.withOpacity(.10),
                ),
                minLines: 5,
                maxLines: null,
              ),
              if (message is ContactUsFormValidateError) ...[
                if (message.errors.message.isNotEmpty)
                  ErrorText(text: message.errors.message.first),
              ]
            ],
          );
        }),
        const SizedBox(height: 20),
        BlocListener<ContactUsFormBloc, ContactUsFormState>(
          listener: (context, state) {
            // final contact = state.status;
            // if (contact is ContactUsFormStatusLoading) {
            //   Utils.loadingDialog(context);
            // } else {
            //   Utils.closeDialog(context);
            //   if (contact is ContactUsFormStatusError) {
            //     Utils.closeDialog(context);
            //     Utils.errorSnackBar(context, contact.errorMessage);
            //   } else if (contact is ContactUsFormStatusLoaded) {
            //     Utils.closeDialog(context);
            //     Navigator.of(context).pop();
            //     Utils.showSnackBar(context, 'Form Submit Success');
            //   }
            // }
            final s = state.status;
            if (s is ContactUsFormStatusError) {
              Utils.errorSnackBar(context, state.message);
            }
            if (s is ContactUsFormStatusLoaded) {
              Utils.showSnackBar(context, 'Form Submit Successfully');
              Navigator.of(context).pop();
            }
          },
          child: BlocBuilder<ContactUsFormBloc, ContactUsFormState>(
            builder: (context, state) {
              return state.status is ContactLoading
                  ? const Center(child: CircularProgressIndicator())
                  : PrimaryButton(
                text: Language.sendNow.capitalizeByWord(),
                onPressed: () {
                  Utils.closeKeyBoard(context);
                  contactUsFormBloc.add(const ContactUsFormSubmit());
                },
              );
            },
          ),
      /*    child: PrimaryButton(
            text: Language.sendNow.capitalizeByWord(),
            onPressed: () {
              Utils.closeKeyBoard(context);
              contactUsFormBloc.add(const ContactUsFormSubmit());
            },
          ),*/
        ),
      ],
    );
  }
}
