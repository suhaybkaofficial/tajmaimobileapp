import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '/modules/cart/model/cart_response_model.dart';
import '/utils/language_string.dart';
import '/widgets/capitalized_word.dart';
import '../modules/animated_splash_screen/controller/app_setting_cubit/app_setting_cubit.dart';
import '../modules/cart/model/cart_product_model.dart';
import '../modules/home/model/product_model.dart';
import '../modules/product_details/model/details_product_reviews_model.dart';
import '../modules/setting/model/website_setup_model.dart';
import 'k_strings.dart';

class Utils {
  static final _selectedDate = DateTime.now();

  static final _initialTime = TimeOfDay.now();

  static String formatPrice(var price, BuildContext context) {
    final currency = context.read<AppSettingCubit>().settingModel!.setting;
    if (price is double) {
      return '${currency.currencyIcon}${price.toStringAsFixed(1)}';
    }
    if (price is String) {
      final p = double.tryParse(price) ?? 0.0;
      return '${currency.currencyIcon}${p.toStringAsFixed(1)}';
    }
    return price.toStringAsFixed(1);
  }

  // static String formatPrice(var price, BuildContext context) {
  //   final currency =
  //       context.read<AppSettingCubit>().settingModel!.setting.currencyIcon;
  //
  //   String formatNumber(int value) {
  //     if (value < 1000) {
  //       return value.toString();
  //     } else if (value < 1000000) {
  //       double result = value / 1000.0;
  //       return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
  //     } else if (value < 1000000000) {
  //       double result = value / 1000000.0;
  //       return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
  //     } else {
  //       double result = value / 1000000000.0;
  //       return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}B';
  //     }
  //   }
  //
  //   if (price is double) {
  //     int intValue = price.toInt();
  //     return '$currency ${formatNumber(intValue)}';
  //   }
  //   if (price is String) {
  //     final p = double.tryParse(price) ?? 0.0;
  //     int intValue = p.toInt();
  //     return '$currency ${formatNumber(intValue)}';
  //   }
  //   return '$currency ${price.toStringAsFixed(1)}';
  // }

  static String shippingType(String type) {
    switch (type) {
      case 'base_on_weight':
        return "Shipping Rule Based on weight";
      case 'base_on_price':
        return "Shipping Rule Based on Price";
      case 'base_on_qty':
        return "Shipping Rule Based on Qty";
      default:
        return "";
    }
  }

  static Widget verticalSpace(double space) {
    return SizedBox(height: space);
  }

  static Widget horizontalSpace(double space) {
    return SizedBox(width: space);
  }

  static Color dynamicPrimaryColor(BuildContext context) {
    final color = context
        .read<AppSettingCubit>()
        .settingModel!
        .setting
        .themeOne
        .replaceAll('#', '0xFF');
    return Color(int.parse(color));
  }

  static double productPrice(BuildContext context, ProductModel product) {
    final appSetting = context.read<AppSettingCubit>();
    double productPrice = 0.0;
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts
        .contains(FlashSaleProductsModel(productId: product.id));

    if (product.offerPrice != 0) {
      if (product.productVariants.isNotEmpty) {
        double p = 0.0;
        for (var i in product.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        offerPrice = p + product.offerPrice;
      } else {
        offerPrice = product.offerPrice;
      }
      productPrice = offerPrice;
    } else {
      if (product.productVariants.isNotEmpty) {
        double p = 0.0;
        for (var i in product.productVariants) {
          if (i.activeVariantsItems.isNotEmpty) {
            p += Utils.toDouble(i.activeVariantsItems.first.price.toString());
          }
        }
        mainPrice = p + product.price;
      } else {
        mainPrice = product.price;
      }
      productPrice = mainPrice;
    }

    if (isFlashSale) {
      if (product.offerPrice != 0) {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
      productPrice = flashPrice;
    }
    return productPrice;
  }

  static double cartProductPrice(
      BuildContext context, CartProductModel cartProductModel) {
    final appSetting = context.read<AppSettingCubit>();
    double productPrice = 0.0;
    double flashPrice = 0.0;
    double offerPrice = 0.0;
    double mainPrice = 0.0;
    final isFlashSale = appSetting.settingModel!.flashSaleProducts.contains(
        FlashSaleProductsModel(productId: cartProductModel.product.id));

    if (cartProductModel.product.offerPrice != 0) {
      if (cartProductModel.variants.isNotEmpty) {
        double p = 0.0;

        for (var i in cartProductModel.variants) {
          print("vItem1: $i");
          if (i.varientItem != null) {
            p += i.varientItem!.price;
          }
        }
        offerPrice = p + cartProductModel.product.offerPrice;
      } else {
        offerPrice = cartProductModel.product.offerPrice;
      }
      productPrice = offerPrice;
    } else {
      if (cartProductModel.variants.isNotEmpty) {
        double p = 0.0;
        for (var i in cartProductModel.variants) {
          print("vItem2: $i");
          if (i.varientItem != null) {
            p += i.varientItem!.price;
          }
        }
        mainPrice = p + cartProductModel.product.price;
      } else {
        mainPrice = cartProductModel.product.price;
      }
      productPrice = mainPrice;
    }

    if (isFlashSale) {
      if (cartProductModel.product.offerPrice != 0) {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * offerPrice;

        flashPrice = offerPrice - discount;
      } else {
        final discount =
            appSetting.settingModel!.flashSale.offer / 100 * mainPrice;

        flashPrice = mainPrice - discount;
      }
      productPrice = flashPrice;
    }
    return productPrice;
  }

  static String calculatePrice(CartResponseModel cartResponseModel) {
    double price = 0.0;
    for (var i = 0; i < cartResponseModel.cartProducts.length; i++) {
      if (cartResponseModel.cartProducts[i].product.offerPrice != 0) {
        final p = cartResponseModel.cartProducts[i].product.offerPrice;
        final q = cartResponseModel.cartProducts[i].product.qty;
        price = p * q;
      } else {
        final p = cartResponseModel.cartProducts[i].product.price;
        final q = cartResponseModel.cartProducts[i].product.qty;
        price = p * q;
      }
    }
    String _price = price.toStringAsPrecision(2);
    debugPrint("Price: $_price");

    return "\$$_price";
  }

  static String formatDate(var date) {
    late DateTime _dateTime;
    if (date is String) {
      _dateTime = DateTime.parse(date);
    } else {
      _dateTime = date;
    }

    return DateFormat.yMd().format(_dateTime.toLocal());
  }

  static String numberCompact(num number) =>
      NumberFormat.compact().format(number);

  static String timeAgo(String? time) {
    try {
      if (time == null) return '';
      return timeago.format(DateTime.parse(time));
    } catch (e) {
      return '';
    }
  }

  static double toDouble(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static String dorpPricePercentage(double priceS, double offerPriceS) {
    // double price = Utils.toDouble(priceS);
    // double offerPrice = Utils.toDouble(offerPriceS);
    double dropPrice = (priceS - offerPriceS) * 100;

    double percentage = dropPrice / priceS;
    return "-${percentage.toStringAsFixed(1)}%";
  }

  static double toInt(String? number) {
    try {
      if (number == null) return 0;
      return double.tryParse(number) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<DateTime?> selectDate(BuildContext context) => showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1990, 1),
        lastDate: DateTime(2050),
      );

  static Future<TimeOfDay?> selectTime(BuildContext context) =>
      showTimePicker(context: context, initialTime: _initialTime);

  static loadingDialog(
    BuildContext context, {
    bool barrierDismissible = false,
  }) {
    // closeDialog(context);
    showCustomDialog(
      context,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 15),
            Text(Language.pleaseWaitAMoment.capitalizeByWord())
          ],
        )),
      ),
      barrierDismissible: barrierDismissible,
    );
  }

  static Future showCustomDialog(
    BuildContext context, {
    Widget? child,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        );
      },
    );
  }

  static void appInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Language.appInfo.capitalizeByWord(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoLabel(
                  label: Language.name.capitalizeByWord(),
                  text: KStrings.appName),
              const SizedBox(height: 6),
              InfoLabel(
                  label: Language.version.capitalizeByWord(),
                  text: KStrings.appVersion),
              const SizedBox(height: 6),
              InfoLabel(
                  label: Language.developedBy.capitalizeByWord(),
                  text: "QuomodoSoft"),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(Language.dismiss.capitalizeByWord()))
          ],
        );
      },
    );
  }

  static int calCulateMaxDays(String startDate, String endDate) {
    final startDateTime = DateTime.parse(startDate);
    final endDateTime = DateTime.parse(endDate);
    final totalDays = endDateTime.difference(startDateTime).inDays;

    return totalDays >= 0 ? totalDays : 0;
  }

  static int calCulateRemainingHours(String startDate, String endDate) {
    final startDateTime =
        DateTime.now().toLocal().subtract(const Duration(days: 9));
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalHours = endDateTime.difference(startDateTime).inHours;

    if (totalHours < 0) return 24;

    return 24 - (totalHours % 24);
  }

  static int calCulateRemainingMinutes(String startDate, String endDate) {
    final startDateTime = DateTime.now().toLocal();
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalMinutes = endDateTime.difference(startDateTime).inMinutes;

    if (totalMinutes < 0) return 60;

    return 60 - (totalMinutes % (24 * 60));
  }

  static int calCulateRemainingDays(String startDate, String endDate) {
    final endDateTime = DateTime.parse(endDate).toLocal();
    final totalDaysGone =
        endDateTime.difference(DateTime.now().toLocal()).inDays;
    final totalDays = calCulateMaxDays(startDate, endDate);
    return totalDaysGone >= 0 ? totalDays - totalDaysGone : totalDays;
  }

  /// Checks if string is a valid username.
  static bool isUsername(String s) =>
      hasMatch(s, r'^[a-zA-Z0-9][a-zA-Z0-9_.]+[a-zA-Z0-9]$');

  /// Checks if string is Currency.
  static bool isCurrency(String s) => hasMatch(s,
      r'^(S?\$|\₩|Rp|\¥|\€|\₹|\₽|fr|R\$|R)?[ ]?[-]?([0-9]{1,3}[,.]([0-9]{3}[,.])*[0-9]{3}|[0-9]+)([,.][0-9]{1,2})?( ?(USD?|AUD|NZD|CAD|CHF|GBP|CNY|EUR|JPY|IDR|MXN|NOK|KRW|TRY|INR|RUB|BRL|ZAR|SGD|MYR))?$');

  /// Checks if string is phone number.
  static bool isPhoneNumber(String s) {
    if (s.length > 16 || s.length < 9) return false;
    return hasMatch(s, r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  }

  /// Checks if string is email.
  static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }

  static bool isEmpty(dynamic value) {
    if (value is String) {
      return value.toString().trim().isEmpty;
    }
    if (value is Iterable || value is Map) {
      return value.isEmpty ?? false;
    }
    return false;
  }

  static void errorSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(errorMsg, style: const TextStyle(color: Colors.red)),
        ),
      );
  }

  static void showSnackBar(BuildContext context, String msg,
      [Color textColor = Colors.white]) {
    final snackBar =
        SnackBar(content: Text(msg, style: TextStyle(color: textColor)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSnackBarWithAction(
      BuildContext context, String msg, VoidCallback onPress,
      [Color textColor = Colors.black]) {
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: Language.active.capitalizeByWord(),
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showSnackBarWithLogin(
      BuildContext context, String msg, VoidCallback onPress,
      [Color textColor = Colors.white]) {
    final snackBar = SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      action: SnackBarAction(
        label: Language.login,
        onPressed: onPress,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static double getRating(List<DetailsProductReviewModel> productReviews) {
    if (productReviews.isEmpty) return 0;

    double rating = productReviews.fold(
        0.0,
        (previousValue, element) =>
            previousValue + Utils.toDouble(element.rating.toString()));
    rating = rating / productReviews.length;
    return rating;
  }

  static bool _isDialogShowing(BuildContext context) =>
      ModalRoute.of(context)?.isCurrent != true;

  static void closeDialog(BuildContext context) {
    if (_isDialogShowing(context)) {
      Navigator.pop(context);
    }
  }

  static void closeKeyBoard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<String?> pickSingleImage() async {
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return image.path;
    }
    return null;
  }

  static String orderStatus(String orderStatus) {
    switch (orderStatus) {
      case '0':
        return Language.pending.capitalizeByWord();
      case '1':
        return Language.progress.capitalizeByWord();
      case '2':
        return Language.delivered.capitalizeByWord();
      case '3':
        return Language.completed.capitalizeByWord();
      // case '4':
      //   return 'Declined';
      default:
        return Language.declined.capitalizeByWord();
    }
  }
}

class InfoLabel extends StatelessWidget {
  const InfoLabel({
    Key? key,
    this.label,
    this.text,
  }) : super(key: key);
  final String? label;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(
        text: "${label!} : ",
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(
            text: text!,
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ]));
  }
}
