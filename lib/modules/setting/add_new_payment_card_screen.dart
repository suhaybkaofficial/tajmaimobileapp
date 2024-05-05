import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import 'component/payment_card.dart';

class AddNewPaymentCardScreen extends StatefulWidget {
  const AddNewPaymentCardScreen({Key? key}) : super(key: key);

  @override
  State<AddNewPaymentCardScreen> createState() =>
      AddNewPaymentCardScreenState();
}

class AddNewPaymentCardScreenState extends State<AddNewPaymentCardScreen> {
  int currentCardIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RoundedAppBar(titleText: 'Add Payment Method'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Payment',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, height: 1.5),
              ),
            ),
            const SizedBox(height: 9),
            SizedBox(
              height: 66,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => const SizedBox(width: 18),
                itemBuilder: (context, index) => PaymentCard(
                  index: index,
                  isSelected: index == currentCardIndex,
                  onTap: (int i) {
                    setState(() {
                      currentCardIndex = i;
                    });
                  },
                ),
                itemCount: 6,
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
            const SizedBox(height: 22),
            _buildPaymentForm()
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add Card info',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, height: 1.5),
          ),
          const SizedBox(height: 12),
          TextFormField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              hintText: 'Card Number',
              fillColor: borderColor.withOpacity(.10),
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            keyboardType: TextInputType.streetAddress,
            decoration: InputDecoration(
              fillColor: borderColor.withOpacity(.10),
              hintText: 'Card holder Name',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: 'Expired Date',
                    fillColor: borderColor.withOpacity(.10),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: TextFormField(
                  keyboardType: TextInputType.streetAddress,
                  decoration: InputDecoration(
                    hintText: 'Cvv',
                    fillColor: borderColor.withOpacity(.10),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            value: true,
            activeColor: Utils.dynamicPrimaryColor(context),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            dense: true,
            title: Text(
              'Save my card Details',
              style: TextStyle(
                  fontSize: 14,
                  color: blackColor.withOpacity(0.5),
                  fontWeight: FontWeight.w400),
            ),
            onChanged: (v) {},
          ),
          const SizedBox(height: 30),
          PrimaryButton(text: 'Add New Address', onPressed: () {}),
        ],
      ),
    );
  }

  Widget playListField() {
    return DropdownButtonFormField<String>(
      value: 'Ok',
      hint: const Text('Playlist'),
      decoration: InputDecoration(
        isDense: true,
        fillColor: borderColor.withOpacity(.10),
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: borderColor),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      onChanged: (value) {},
      validator: (value) => value == null ? 'field required' : null,
      isDense: true,
      isExpanded: true,
      items: ['Ok', "Hello"].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
