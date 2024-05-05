import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/remote_urls.dart';
import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/favorite_button.dart';
import '../../home/model/product_model.dart';
import '../model/active_variant_items_model.dart';
import '../model/active_variant_model.dart';
import '../model/product_details_product_model.dart';

class ProductHeaderComponent extends StatefulWidget {
  const ProductHeaderComponent(this.product, this.gallery, {super.key});

  final ProductDetailsProductModel product;
  final List<GalleryModel?> gallery;

  @override
  State<ProductHeaderComponent> createState() => _ProductHeaderComponentState();
}

class _ProductHeaderComponentState extends State<ProductHeaderComponent> {
  late String productThumb;
  int _currentIndex = 0;
  late double productPrice;

  @override
  void initState() {
    _imageInit();
    productThumb = widget.product.thumbImage;
    productPrice = widget.product.price;
    super.initState();
  }

  List<ActiveVariantItemModel> activeVariantsItems = [];

  void _imageInit() {
    if (widget.product.activeVariantModel.isNotEmpty) {
      print('active not-empty ${widget.product.activeVariantModel.length}');
      activeVariantsItems =
          widget.product.activeVariantModel.first.activeVariantsItems;
    } else {
      print('active empty ${widget.product.activeVariantModel.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('productPrice $productPrice');
    return Column(
      children: [
        SizedBox(
          height: 290,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                height: 255,
                decoration: BoxDecoration(
                  color: borderColor.withOpacity(.2),
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(20)),
                ),
              ),
              _buildThumbImage(),
              _buildFavBtn(widget.product.id),
              _buildGalleryImage()
            ],
          ),
        ),
        if (widget.product.activeVariantModel.isNotEmpty) ...[
          _variantWidget(),
        ],
      ],
    );
  }

  Widget _buildGalleryImage() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.gallery
            .take(4)
            .map(
              (e) => Container(
                padding: const EdgeInsets.all(8),
                height: 70,
                width: 70,
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.white)),
                child: InkWell(
                  onTap: () {
                    productThumb = e.image;
                    setState(() {});
                  },
                  child: CustomImage(
                    path: RemoteUrls.imageUrl(e!.image),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildFavBtn(int id) {
    return Positioned(
      right: 20,
      top: 0,
      child: FavoriteButton(productId: id),
    );
  }

  Widget _buildThumbImage() {
    return Positioned(
      top: 30,
      left: 20,
      right: 35,
      bottom: 60,
      child: CustomImage(
        path: RemoteUrls.imageUrl(productThumb),
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _variantWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Variant',
            style: GoogleFonts.inter(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: blackColor,
            ),
          ),
          const SizedBox(height: 10.0),
          DropdownButtonFormField<ActiveVariantModel>(
            value: widget.product.activeVariantModel.first,
            //hint: Text(Language.city.capitalizeByWord()),
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
            ),
            // onTap: () {
            //   Utils.closeKeyBoard(context);
            // },
            onChanged: (value) {
              print(value!.activeVariantsItems.length.toString());
              setState(() => activeVariantsItems = value.activeVariantsItems);
            },
            isDense: true,
            isExpanded: true,
            items: widget.product.activeVariantModel
                .map<DropdownMenuItem<ActiveVariantModel>>(
                    (ActiveVariantModel value) {
              return DropdownMenuItem<ActiveVariantModel>(
                  value: value, child: Text(value.name));
            }).toList(),
          ),
          const SizedBox(height: 10.0),
          if (activeVariantsItems.isNotEmpty) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(activeVariantsItems.length, (index) {
                  final item = activeVariantsItems[index];
                  print('priceeeeee ${item.price}');
                  return GestureDetector(
                      onTap: () => setState(() {
                            productThumb = item.image;
                            _currentIndex = index;
                            productPrice += item.price;
                          }),
                      child: _imageContainer(item, index));
                }),
              ),
            ),
          ],
          const SizedBox(height: 30.0),
          //ProductPriceWidget(price: productPrice),
        ],
      ),
    );
  }

  Widget _imageContainer(ActiveVariantItemModel active, int index) {
    return AnimatedContainer(
      duration: kDuration,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0)
          .copyWith(left: 4.0),
      margin: const EdgeInsets.only(right: 10.0),
      decoration: BoxDecoration(
          border: Border.all(
              color: _currentIndex == index
                  ? Utils.dynamicPrimaryColor(context)
                  : const Color(0xFFD5D5D5))),
      child: Row(
        children: [
          Container(
            height: 48.0,
            width: 54.0,
            margin: const EdgeInsets.only(right: 10.0),
            child: CustomImage(
              path: RemoteUrls.imageUrl(active.image),
              fit: BoxFit.cover,
            ),
          ),
          Text(active.name),
        ],
      ),
    );
  }
}
