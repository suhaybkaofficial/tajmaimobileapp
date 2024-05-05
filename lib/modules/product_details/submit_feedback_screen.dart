import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../authentication/widgets/sign_up_form.dart';
import '../../widgets/capitalized_word.dart';
import '../../utils/language_string.dart';
import 'controller/review/review_cubit.dart';
import '../../utils/constants.dart';
import '../../utils/utils.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/rounded_app_bar.dart';
import '../order/model/product_order_model.dart';

class SubmitFeedBackScreen extends StatefulWidget {
  const SubmitFeedBackScreen({Key? key, required this.orderItem})
      : super(key: key);
  final OrderedProductModel orderItem;

  @override
  State<SubmitFeedBackScreen> createState() => _SubmitFeedBackScreenState();
}

class _SubmitFeedBackScreenState extends State<SubmitFeedBackScreen> {
  final _reviewTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _reviewTextController.dispose();
  }

  final _className = 'SubmitFeedBackScreen';
  double ratingValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SubmitReviewCubit, ReviewSubmitState>(
      listener: (context, state) {
        if (state is SubmitReviewStateLoading) {
          Utils.loadingDialog(context);
        } else {
          Utils.closeDialog(context);
          if (state is SubmitReviewStateError) {
            Utils.errorSnackBar(context, state.errorMessage);
          } else if (state is SubmitReviewStateLoaded) {
            // if (state.submitReviewResponseModel.status == 0) {
            //   Utils.showSnackBar(
            //       context, state.submitReviewResponseModel.message);
            // } else {
            //   Utils.showCustomDialog(context, child: const FeedbackSuccess());
            // }
            _reviewTextController.clear();
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: RoundedAppBar(
          bgColor: Colors.white,
          titleText: Language.backToShop.capitalizeByWord(),
          textColor: blackColor,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // FeedbackProductCard(product: populerProductList.first),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  // color: bgGreyColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CustomImage(
                    //   path: RemoteUrls.imageUrl(widget.orderItem.thumbImage),
                    //   height: 85,
                    //   width: 90,
                    //   fit: BoxFit.cover,
                    // ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.orderItem.productName,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                height: 1.3,
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'X ${widget.orderItem.qty}',
                            style: TextStyle(color: blackColor.withOpacity(.6)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 42),
              Text(
                Language.whatIsYourReview.capitalizeByWord(),
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 13),
              Text('${Language.whatIsYourRate.capitalizeByWord()} ?',
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 13),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 28,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: redColor,
                ),
                onRatingUpdate: (rating) {
                  ratingValue = rating;
                },
              ),
              const SizedBox(height: 45),
              Align(
                alignment: Alignment.topLeft,
                child: Text(Language.writeSomething.capitalizeByWord(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 7),

              BlocBuilder<SubmitReviewCubit, ReviewSubmitState>(
                builder: (context, state) {
                  // SubmitReviewStateFormValidate
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        maxLines: null,
                        minLines: 5,
                        controller: _reviewTextController,
                        decoration: InputDecoration(
                          hintText: Language.writeSomething.capitalizeByWord(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                const BorderSide(color: Color(0xffD9D9D9)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                const BorderSide(color: Color(0xffD9D9D9)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                const BorderSide(color: Color(0xffD9D9D9)),
                          ),
                        ),
                      ),
                      if (state is SubmitReviewStateFormValidate) ...[
                        if (state.errors.review.isNotEmpty)
                          ErrorText(text: state.errors.review.first),
                      ]
                    ],
                  );
                },
              ),

              const SizedBox(height: 55),

              BlocBuilder<SubmitReviewCubit, ReviewSubmitState>(
                builder: (context, state) {
                  if (state is SubmitLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return PrimaryButton(
                    text: Language.submitReview.capitalizeByWord(),
                    onPressed: submit,
                  );
                },
              ),

              const SizedBox(height: 8),

              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Text(
                  Language.notNow.capitalizeByWord(),
                  style: GoogleFonts.roboto(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit() async {
    late Map<String, dynamic> map = {};
    // if (_reviewTextController.text.isEmpty) {
    //   Utils.showSnackBar(context, Language.writeSomething.capitalizeByWord());
    // }
    Utils.closeKeyBoard(context);
    map['rating'] = ratingValue.toString();
    map['review'] = _reviewTextController.text;
    map['product_id'] = widget.orderItem.productId.toString();
    map['seller_id'] = widget.orderItem.sellerId.toString();
    log(map.toString(), name: _className);

    context.read<SubmitReviewCubit>().submitReview(map);
    // _reviewTextController.clear();
  }
}
