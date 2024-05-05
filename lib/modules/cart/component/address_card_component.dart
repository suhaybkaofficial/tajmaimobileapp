import 'package:flutter/material.dart';

import '/utils/language_string.dart';
import '../../../core/router_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../profile/model/address_model.dart';

class AddressCardComponent extends StatelessWidget {
  const AddressCardComponent({
    super.key,
    required this.addressModel,
    required this.type,
    this.onTap,
    this.pWidth,
    this.selectAddress = 0,
    this.isEditButtonShow = true,
  });

  final AddressModel addressModel;
  final VoidCallback? onTap;
  final String type;
  final double? pWidth;
  final int selectAddress;
  final bool isEditButtonShow;

  @override
  Widget build(BuildContext context) {
    final width = pWidth ?? MediaQuery.of(context).size.width * 0.8;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      width: width,
      decoration: BoxDecoration(
        color: selectAddress == addressModel.id
            ? Utils.dynamicPrimaryColor(context).withOpacity(.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: selectAddress == addressModel.id
              ? Utils.dynamicPrimaryColor(context)
              : Utils.dynamicPrimaryColor(context).withOpacity(.05),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 10.0),
            child: Icon(Icons.location_on_outlined,
                color: Utils.dynamicPrimaryColor(context)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        addressModel.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    isEditButtonShow
                        ? const SizedBox()
                        : InkWell(
                            onTap: () async {
                              Navigator.pushNamed(
                                context,
                                RouteNames.editAddressScreen,
                                arguments: {"address_id": addressModel.id},
                              );
                            },
                            child: CircleAvatar(
                              radius: 13,
                              backgroundColor: paragraphColor.withOpacity(.24),
                              child: const Icon(Icons.edit,
                                  size: 16, color: blackColor),
                            ),
                          )
                  ],
                ),
                Text(
                  addressModel.email,
                  style: const TextStyle(color: iconGreyColor),
                ),
                Text(
                  addressModel.phone,
                  style: const TextStyle(color: iconGreyColor),
                ),
                const SizedBox(height: 6),
                Text(
                  addressModel.type == '1' ? 'Office' : "Home",
                  style: const TextStyle(
                      color: redColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
                // Text(
                //   addressModel.address,
                //   style: const TextStyle(color: iconGreyColor),
                // ),
                Text(
                  "${Language.address} : ${addressModel.address}",
                  style: const TextStyle(color: iconGreyColor),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
//
// import 'package:flutter/material.dart';
//
// import '/utils/language_string.dart';
// import '../../../core/router_name.dart';
// import '../../../utils/constants.dart';
// import '../../../utils/utils.dart';
// import '../../profile/model/address_model.dart';
//
// class AddressCardComponent extends StatelessWidget {
//   const AddressCardComponent({
//     super.key,
//     required this.addressModel,
//     //required this.type,
//     this.onTap,
//     this.pWidth,
//     this.isEditButtonShow = true,
//     required this.borderColor,
//     required this.color,
//   });
//
//   final AddressModel addressModel;
//   final VoidCallback? onTap;
//
//   //final String type;
//   final double? pWidth;
//
//   final bool isEditButtonShow;
//   final Color borderColor;
//   final Color color;
//
//   @override
//   Widget build(BuildContext context) {
//     final width = pWidth ?? MediaQuery.of(context).size.width * 0.8;
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
//       width: width,
//       decoration: BoxDecoration(
//         // color: selectAddress == addressModel.id
//         //     ? Utils.dynamicPrimaryColor(context).withOpacity(.05)
//         //     : Colors.white,
//         color: color,
//         borderRadius: BorderRadius.circular(4),
//         border: Border.all(
//           // color: selectAddress == addressModel.id
//           //     ? Utils.dynamicPrimaryColor(context)
//           //     : Colors.white,
//           color: borderColor,
//         ),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 4, bottom: 10.0),
//             child: Icon(Icons.location_on_outlined,
//                 color: Utils.dynamicPrimaryColor(context)),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         addressModel.name,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                             overflow: TextOverflow.ellipsis,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                     isEditButtonShow
//                         ? const SizedBox()
//                         : InkWell(
//                       onTap: () async {
//                         Navigator.pushNamed(
//                           context,
//                           RouteNames.editAddressScreen,
//                           arguments: {"address_id": addressModel.id},
//                         );
//                       },
//                       child: CircleAvatar(
//                         radius: 13,
//                         backgroundColor: paragraphColor.withOpacity(.24),
//                         child: const Icon(Icons.edit,
//                             size: 16, color: blackColor),
//                       ),
//                     )
//                   ],
//                 ),
//                 Text(
//                   addressModel.email,
//                   style: const TextStyle(color: iconGreyColor),
//                 ),
//                 Text(
//                   addressModel.phone,
//                   style: const TextStyle(color: iconGreyColor),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   addressModel.type == '1' ? 'Office' : "Home",
//                   style: const TextStyle(
//                       color: redColor,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 // Text(
//                 //   addressModel.address,
//                 //   style: const TextStyle(color: iconGreyColor),
//                 // ),
//                 Text(
//                   "${Language.address} : ${addressModel.address}",
//                   style: const TextStyle(color: iconGreyColor),
//                 ),
//                 const SizedBox(height: 10.0),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
