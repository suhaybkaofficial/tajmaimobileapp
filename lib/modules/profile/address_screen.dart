import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../core/router_name.dart';
import '../../dummy_data/all_dummy_data.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/rounded_app_bar.dart';
import '../cart/component/address_card_component.dart';
import 'controllers/address/address_cubit.dart';
import 'controllers/country_state_by_id/country_state_by_id_cubit.dart';
import 'model/billing_shipping_model.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    Future.microtask(() {
      context.read<CountryStateByIdCubit>().countryListLoaded();
      context.read<AddressCubit>().getAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addressCubit = context.read<AddressCubit>();

    print('address ${addressCubit.address}');
    if (addressCubit.address == null) {
      //print('re-call');
      addressCubit.getAddress();
    }
    return Scaffold(
      appBar: RoundedAppBar(titleText: Language.address.capitalizeByWord()),
      body: BlocConsumer<AddressCubit, AddressState>(
        listener: (context, state) {
          if (state is AddressStateUpdated) {
            context.read<AddressCubit>().getAddress();
          }
        },
        builder: (context, state) {
          log(state.toString(), name: 'address screen');
          if (state is AddressStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressStateError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: redColor),
              ),
            );
          } else if (state is AddressStateLoaded) {
            return _LoadedWidget(address: state.address);
          }
          return _LoadedWidget(address: addressCubit.address!);
          // return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Utils.dynamicPrimaryColor(context),
        onPressed: () {
          Navigator.pushNamed(
            context,
            RouteNames.addAddressScreen,
            arguments: {"type": "new"},
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _LoadedWidget extends StatefulWidget {
  const _LoadedWidget({
    Key? key,
    required this.address,
  }) : super(key: key);
  final AddressBook address;

  @override
  State<_LoadedWidget> createState() => _LoadedWidgetState();
}

class _LoadedWidgetState extends State<_LoadedWidget> {
  final _pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
  String addressTypeSelect = Language.billingAddress.capitalizeByWord();
  int billingAddressId = 0;
  int shippingAddressId = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ...addressType.asMap().entries.map(
                  (e) => InkWell(
                    onTap: () {
                      setState(
                        () {
                          addressTypeSelect = e.value;
                          _pageController.animateToPage(e.key,
                              duration: const Duration(microseconds: 500),
                              curve: Curves.ease);
                        },
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(microseconds: 300),
                      curve: Curves.ease,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: addressTypeSelect == e.value
                                ? Utils.dynamicPrimaryColor(context)
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        e.value,
                        style: TextStyle(
                          color: addressTypeSelect == e.value
                              ? Utils.dynamicPrimaryColor(context)
                              : grayColor,
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
        if (widget.address.addresses.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              Language.swipeToDelete.capitalizeByWord(),
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: textGreyColor),
            ),
          ),
        Expanded(
          // height: MediaQuery.of(context).size.height * 0.2,
          child: PageView.builder(
            itemCount: addressType.length,
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: widget.address.addresses.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: InkWell(
                      onTap: () {
                        if (addressTypeSelect ==
                            Language.billingAddress.capitalizeByWord()) {
                          billingAddressId = widget.address.addresses[index].id;
                        } else {
                          shippingAddressId =
                              widget.address.addresses[index].id;
                        }
                        setState(() {});
                      },
                      child: Dismissible(
                        key: Key(widget.address.addresses[index].toString()),
                        onDismissed: (direction) {
                          Utils.showSnackBar(
                              context, 'Address Delete Successfully');
                        },
                        confirmDismiss: (v) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                    Language.areYouSure.capitalizeByWord()),
                                content: Text(
                                    Language.wishToDelete.capitalizeByWord()),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(Language.cancel.toUpperCase()),
                                  ),
                                  TextButton(
                                      onPressed: () async {
                                        final item =
                                            widget.address.addresses[index];
                                        final result = await context
                                            .read<AddressCubit>()
                                            .deleteSingleAddress(
                                                item.id.toString());

                                        result.fold(
                                          (failure) {
                                            Utils.errorSnackBar(
                                                context, failure.message);
                                          },
                                          (success) {
                                            widget.address.addresses
                                                .removeAt(index);
                                            setState(() {});
                                            Utils.showSnackBar(
                                                context, success);
                                          },
                                        );
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text(
                                          Language.delete.capitalizeByWord())),
                                ],
                              );
                            },
                          );
                        },
                        child: AddressCardComponent(
                          selectAddress: addressTypeSelect ==
                                  Language.billingAddress.capitalizeByWord()
                              ? billingAddressId
                              : shippingAddressId,
                          addressModel: widget.address.addresses[index],
                          type: widget.address.addresses[index].type,
                          isEditButtonShow: false,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
