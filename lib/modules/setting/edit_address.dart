import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../authentication/widgets/sign_up_form.dart';
import '../profile/controllers/address/address_cubit.dart';
import '../profile/controllers/address/cubit/edit_address_cubit.dart';
import '../profile/controllers/country_state_by_id/country_state_by_id_cubit.dart';
import '../profile/model/city_model.dart';
import '../profile/model/country_model.dart';
import '../profile/model/country_state_model.dart';
import '../profile/model/edit_address_model.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({
    Key? key,
    required this.map,
  }) : super(key: key);

  final Map<String, dynamic> map;

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  CountryModel? _countryModel;
  CountryStateModel? _countryStateModel;
  CityModel? _cityModel;

  // AddressModel? addressModel;
  List<CountryModel> countries = [];
  List<CountryStateModel> stateList = [];
  List<CityModel> cityList = [];

  final nameCtr = TextEditingController();
  final emailCtr = TextEditingController();
  final phoneCtr = TextEditingController();
  final addressCtr = TextEditingController();
  final zipCtr = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context
        .read<EditAddressCubit>()
        .fetchEditAddress(widget.map['address_id'].toString());
  }

  ifUpdateAddress(EditAddressModel editAddressModel) {
    for (var element in editAddressModel.countries) {
      if (element.id == editAddressModel.address.countryId) {
        _countryModel = element;
        break;
      }
    }

    _countryStateModel = context
        .read<EditAddressCubit>()
        .defaultState(editAddressModel.address.stateId);

    if (_countryStateModel != null) {
      log(_countryStateModel.toString(), name: "_stateModel");

      _cityModel = context
          .read<EditAddressCubit>()
          .defaultCity(editAddressModel.address.cityId);
      log(_cityModel.toString(), name: "_cityModel");
    }

    // for (var element in editAddressModel.states) {
    //   if (element.id.toString() == editAddressModel.address.stateId) {
    //     _countryStateModel = element;
    //     print("_state $_countryStateModel");
    //     break;
    //   }
    // }
    // for (var element in editAddressModel.cities) {
    //   if (element.id.toString() == editAddressModel.address.cityId) {
    //     _cityModel = element;
    //     print("_city $_cityModel");
    //     break;
    //   }
    // }
    // log("$_countryModel, ${editAddressModel.address.country}", name: 'add address');
    // _countryStateModel = editAddressModel.address.countryState;
    // log("$_countryStateModel, ${editAddressModel.address.countryState}", name: 'state1');
    // _cityModel = editAddressModel.address.city;
    // log("$_cityModel, ${editAddressModel.address.city}", name: 'city1');

    // countries = context.read<LoginBloc>().countries.toSet().toList();
    //
    // log(countries.toString(), name: "AAS");

    // if (_countryModel != null) {
    //   final stateLoadIdCountryId =
    //       context.read<CountryStateByIdCubit>().stateLoadIdCountryId;
    //   stateLoadIdCountryId(_countryModel!.id.toString());
    // }
    _setValueIntoController(editAddressModel);
  }

  void _loadState(CountryModel countryModel) {
    _countryModel = countryModel;
    _countryStateModel = null;
    _cityModel = null;

    final stateLoadIdCountryId =
        context.read<CountryStateByIdCubit>().stateLoadIdCountryId;

    stateLoadIdCountryId(countryModel.id.toString());
  }

  void _loadCity(CountryStateModel countryStateModel) {
    _countryStateModel = countryStateModel;
    _cityModel = null;

    final cityLoadIdStateId =
        context.read<CountryStateByIdCubit>().cityLoadIdStateId;

    cityLoadIdStateId(countryStateModel.id.toString());
  }

  void _setValueIntoController(EditAddressModel editAddressModel) {
    nameCtr.text = editAddressModel.address.name;
    emailCtr.text = editAddressModel.address.email;
    phoneCtr.text = editAddressModel.address.phone;
    addressCtr.text = editAddressModel.address.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RoundedAppBar(titleText: 'Edit Address'),
        body: BlocConsumer<AddressCubit, AddressState>(
          listener: (context, state) {
            if (state is AddressStateUpdating) {
              Utils.loadingDialog(context);
            } else {
              Utils.closeDialog(context);
              if (state is AddressStateUpdateError) {
                Utils.closeDialog(context);
                Utils.errorSnackBar(context, state.message);
              } else if (state is AddressStateUpdated) {
                Utils.closeDialog(context);
                Navigator.of(context).pop(true);
                print('called..');
              }
              // else if (state is AddressStateInvalidDataError) {
              //   context.read<AddressCubit>().getAddress();
              // }
            }
          },
          builder: (context, addressState) {
            return BlocBuilder<EditAddressCubit, EditAddressState>(
                builder: (context, editState) {
              if (editState is EditAddressLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (editState is EditAddressStateLoaded) {
                if (_countryModel == null) {
                  context.read<CountryStateByIdCubit>().countryList =
                      editState.editAddressModel.countries;
                  context.read<CountryStateByIdCubit>().stateList =
                      editState.editAddressModel.states;
                  context.read<CountryStateByIdCubit>().cities =
                      editState.editAddressModel.cities;
                  ifUpdateAddress(editState.editAddressModel);
                }

                return BlocBuilder<CountryStateByIdCubit,
                    CountryStateByIdState>(
                  builder: (context, countryState) {
                    if (countryState is CountryStateByIdStateLoadied) {
                      _countryStateModel = context
                          .read<CountryStateByIdCubit>()
                          .filterState(editState
                              .editAddressModel.address.stateId
                              .toString());
                      if (_countryStateModel != null) {
                        // context
                        //     .read<CountryStateByIdCubit>()
                        //     .cityStateChangeCityFilter(_countryStateModel!);

                        _cityModel = context
                            .read<CountryStateByIdCubit>()
                            .filterCity(editState
                                .editAddressModel.address.cityId
                                .toString());
                      }
                    }

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Edit Address',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.5),
                            ),
                            const SizedBox(height: 9),
                            TextFormField(
                              // initialValue:
                              //     editState.editAddressModel.address.name,
                              controller: nameCtr,
                              // validator: (s) {
                              //   if (s == null || s.isEmpty)
                              //     return '*Name Required';
                              //   return null;
                              // },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: Language.name.capitalizeByWord(),
                                fillColor: borderColor.withOpacity(.10),
                              ),
                            ),
                            if (addressState
                                is AddressStateInvalidDataError) ...[
                              if (addressState.errorMsg.name.isNotEmpty)
                                ErrorText(
                                    text: addressState.errorMsg.name.first),
                            ],

                            const SizedBox(height: 16),
                            TextFormField(
                              controller: emailCtr,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText:
                                    Language.emailAddress.capitalizeByWord(),
                                fillColor: borderColor.withOpacity(.10),
                              ),
                            ),
                            if (addressState
                                is AddressStateInvalidDataError) ...[
                              if (addressState.errorMsg.email.isNotEmpty)
                                ErrorText(
                                    text: addressState.errorMsg.email.first),
                            ],
                            const SizedBox(height: 16),
                            TextFormField(
                              // initialValue:
                              //     editState.editAddressModel.address.phone,
                              controller: phoneCtr,
                              // validator: (s) {
                              //   if (s == null || s.isEmpty) {
                              //     return '*Phone Number Required';
                              //   }
                              //   return null;
                              // },
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText:
                                    Language.phoneNumber.capitalizeByWord(),
                                fillColor: borderColor.withOpacity(.10),
                              ),
                            ),
                            if (addressState
                                is AddressStateInvalidDataError) ...[
                              if (addressState.errorMsg.phone.isNotEmpty)
                                ErrorText(
                                    text: addressState.errorMsg.phone.first),
                            ],
                            const SizedBox(height: 16),
                            _countryField(countries),
                            if (addressState
                                is AddressStateInvalidDataError) ...[
                              if (addressState.errorMsg.country.isNotEmpty)
                                ErrorText(
                                    text: addressState.errorMsg.country.first),
                            ],
                            const SizedBox(height: 16),
                            stateField(),
                            if (addressState
                                is AddressStateInvalidDataError) ...[
                              if (addressState.errorMsg.state.isNotEmpty)
                                ErrorText(
                                    text: addressState.errorMsg.state.first),
                            ],
                            const SizedBox(height: 16),
                            cityField(),
                            if (addressState
                                is AddressStateInvalidDataError) ...[
                              if (addressState.errorMsg.city.isNotEmpty)
                                ErrorText(
                                    text: addressState.errorMsg.city.first),
                            ],
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: addressCtr,
                              // initialValue:
                              //     editState.editAddressModel.address.address,
                              // validator: (s) {
                              //   if (s == null || s.isEmpty)
                              //     return '*Address Required';
                              //   return null;
                              // },
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                fillColor: borderColor.withOpacity(.10),
                                hintText: Language.address.capitalizeByWord(),
                              ),
                            ),
                            if (addressState
                                is AddressStateInvalidDataError) ...[
                              if (addressState.errorMsg.address.isNotEmpty)
                                ErrorText(
                                    text: addressState.errorMsg.address.first),
                            ],

                            const SizedBox(height: 16),
                            // TextFormField(
                            //   controller: zipCtr,
                            //   validator: (s) {
                            //     if (s == null || s.isEmpty) {
                            //       return '* Zip Code Required';
                            //     }
                            //     return null;
                            //   },
                            //   keyboardType: TextInputType.number,
                            //   decoration: InputDecoration(
                            //     fillColor: borderColor.withOpacity(.10),
                            //     hintText: 'ZipCode',
                            //   ),
                            // ),
                            const SizedBox(height: 30),
                            PrimaryButton(
                              text: Language.updateAddress.capitalizeByWord(),
                              onPressed: () {
                                //if (!_formkey.currentState!.validate()) return;

                                final dataMap = {
                                  'name': nameCtr.text.trim(),
                                  'email': emailCtr.text.trim(),
                                  'phone': phoneCtr.text.trim(),
                                  'country': _countryModel!.id.toString(),
                                  'state': _countryStateModel!.id.toString(),
                                  'type': 'home',
                                  'city': _cityModel!.id.toString(),
                                  // 'zip_code': zipCtr.text.trim(),
                                  'address': addressCtr.text.trim(),
                                };
                                // print("DataMap");
                                // print(dataMap.toString());
                                context.read<AddressCubit>().updateAddress(
                                    editState.editAddressModel.address.id
                                        .toString(),
                                    dataMap);
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            });
          },
        )

        // BlocConsumer<AddressCubit, AddressState>(
        //   listenWhen: (previous, current) => previous != current,
        //   listener: (context, state) {
        //     if (state is AddressStateUpdating) {
        //       Utils.loadingDialog(context);
        //     } else if (state is AddressStateUpdateError) {
        //       Utils.closeDialog(context);
        //       Utils.errorSnackBar(context, state.message);
        //     } else if (state is AddressStateUpdated) {
        //       Utils.closeDialog(context);
        //       Navigator.pop(context);
        //     }
        //   },
        //   builder: (context, editState) {
        //
        //   },

        );
  }

  Widget _countryField(List<CountryModel> countries) {
    final addressBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CountryModel>(
      value: _countryModel,
      hint: Text(Language.country.capitalizeByWord()),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        if (value == null) return;
        _loadState(value);
      },
      isDense: true,
      isExpanded: true,
      items: addressBl.countryList.isNotEmpty
          ? addressBl.countryList
              .map<DropdownMenuItem<CountryModel>>((CountryModel value) {
              return DropdownMenuItem<CountryModel>(
                  value: value, child: Text(value.name));
            }).toList()
          : null,
    );
  }

  Widget stateField() {
    final addressBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CountryStateModel>(
      value: _countryStateModel,
      hint: Text(Language.state.capitalizeByWord()),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () async {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        if (value == null) return;
        // _cityModel = null;
        _countryStateModel = value;
        _loadCity(value);
        addressBl.cityStateChangeCityFilter(value);
      },
      isDense: true,
      isExpanded: true,
      items: addressBl.stateList.isNotEmpty
          ? addressBl.stateList.map<DropdownMenuItem<CountryStateModel>>(
              (CountryStateModel value) {
              return DropdownMenuItem<CountryStateModel>(
                  value: value, child: Text(value.name));
            }).toList()
          : [],
    );
  }

  Widget cityField() {
    final addressBl = context.read<CountryStateByIdCubit>();
    return DropdownButtonFormField<CityModel>(
      value: _cityModel,
      hint: Text(Language.city.capitalizeByWord()),
      icon: const Icon(Icons.keyboard_arrow_down_outlined),
      decoration: const InputDecoration(
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onTap: () {
        Utils.closeKeyBoard(context);
      },
      onChanged: (value) {
        _cityModel = value;
        if (value == null) return;
      },
      isDense: true,
      isExpanded: true,
      items: addressBl.cities.isNotEmpty
          ? addressBl.cities
              .map<DropdownMenuItem<CityModel>>((CityModel value) {
              return DropdownMenuItem<CityModel>(
                  value: value, child: Text(value.name));
            }).toList()
          : [],
    );
  }
}
