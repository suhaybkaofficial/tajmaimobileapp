// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shop_o/widgets/capitalized_word.dart';
//
// import '../../../dummy_data/all_dummy_data.dart';
// import '../../../utils/constants.dart';
// import '../../../utils/language_string.dart';
// import '../../../utils/utils.dart';
// import '../../profile/controllers/address/address_cubit.dart';
// import '../../profile/model/address_model.dart';
//
// class CheckoutAddressComponent extends StatelessWidget {
//   const CheckoutAddressComponent({super.key});
//
//   //final List<AddressModel> addresses;
//
//   @override
//   Widget build(BuildContext context) {
//     final addressCubit = context.read<AddressCubit>();
//     addressCubit.getAddress();
//     return BlocConsumer<AddressCubit, AddressState>(
//       listener: (context, state) {
//         if (state is AddressStateError) {
//           if (state.statusCode == 503 || addressCubit.address == null) {
//             addressCubit.getAddress();
//           }
//         }
//       },
//       builder: (context, state) {
//         if (state is AddressStateLoading) {
//           return Text(Language.loading.capitalizeByWord());
//         } else if (state is AddressStateError) {
//           if (state.statusCode == 503 || addressCubit.address != null) {
//             return AddressLoadedComponent(
//                 addresses: addressCubit.address!.addresses);
//           } else {
//             return Text(Language.noAddress.capitalizeByWord());
//           }
//         } else if (state is AddressStateLoaded) {
//           return AddressLoadedComponent(addresses: state.address.addresses);
//         }
//
//         if (addressCubit.address != null) {
//           return AddressLoadedComponent(
//               addresses: addressCubit.address!.addresses);
//         } else {
//           return Text("${Language.somethingWentWrong}!");
//         }
//       },
//     );
//   }
// }
//
// class AddressLoadedComponent extends StatefulWidget {
//   const AddressLoadedComponent({super.key, required this.addresses});
//
//   final List<AddressModel> addresses;
//
//   @override
//   State<AddressLoadedComponent> createState() => _AddressLoadedComponentState();
// }
//
// class _AddressLoadedComponentState extends State<AddressLoadedComponent> {
//   PageController pageController =
//       PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
//   String addressTypeSelect = "Billing Address";
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Row(
//           children: [
//             ...addressType.asMap().entries.map(
//                   (e) => InkWell(
//                 onTap: () {
//                   setState(() {
//                     addressTypeSelect = e.value;
//                     pageController.animateToPage(e.key,
//                         duration: const Duration(microseconds: 500),
//                         curve: Curves.ease);
//                   });
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(microseconds: 300),
//                   curve: Curves.ease,
//                   decoration: BoxDecoration(
//                       border: Border(
//                           bottom: BorderSide(
//                             color: addressTypeSelect == e.value
//                                 ? Utils.dynamicPrimaryColor(context)
//                                 : Colors.transparent,
//                           ))),
//                   margin: const EdgeInsets.symmetric(
//                       horizontal: 20, vertical: 10),
//                   padding: const EdgeInsets.only(bottom: 6),
//                   child: Text(
//                     e.value,
//                     style: TextStyle(
//                       color: addressTypeSelect == e.value
//                           ? Utils.dynamicPrimaryColor(context)
//                           : blackColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.25,
//           child: PageView.builder(
//               itemCount: addressType.length,
//               controller: pageController,
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 //print('address-length ${addresses.length}');
//                 return SingleChildScrollView(
//                   padding: const EdgeInsets.only(left: 20),
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       ...List.generate(widget.addresses.length,
//                               (index) => shippingCharges(addresses, index)),
//                     ],
//                   ),
//                 );
//               }),
//         )
//       ],
//     );
//   }
// }
