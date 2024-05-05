import '../modules/category/single_category_product_screen.dart';
import '../modules/order/model/order_model.dart';
import '../modules/order/order_tracking_form_screen.dart';
import '../modules/order/order_tracking_screen.dart';
import '../modules/product_details/component/more_video_screen.dart';
import '../modules/product_details/model/video_model.dart';
import 'error/router_package_name.dart';

class RouteNames {
  static const String onBoardingScreen = '/onBoardingScreen';
  static const String animatedSplashScreen = '/';
  static const String mainPage = '/mainPage';
  static const String homeScreen = '/homeScreen';
  static const String authenticationScreen = '/authenticationScreen';
  static const String forgotScreen = '/forgotScreen';
  static const String verificationCodeScreen = '/verificationCodeScreen';
  static const String setPasswordScreen = '/setPasswordScreen';
  static const String allCategoryListScreen = '/allCategoryListScreen';
  static const String allSellerList = '/allSellerList';
  static const String allPopularProductScreen = '/allPopularProductScreen';
  static const String notificationScreen = '/notificationScreen';
  static const String messageScreen = '/messageScreen';
  static const String chatListScreen = '/chatListScreen';
  static const String singleCategoryProductScreen =
      '/singleCategoryProductScreen';
  static const String brandProductScreen = '/brandProductScreen';
  static const String subCategoryProductScreen = '/subCategoryProductScreen';
  static const String orderScreen = '/orderScreen';
  static const String singleOrderScreen = '/singleOrder';
  static const String orderTrackingScreen = '/orderTrackingScreen';
  static const String orderTrackingFormScreen = '/orderTrackingFormScreen';
  static const String settingScreen = '/settingScreen';
  static const String termsConditionScreen = '/termsConditionScreen';
  static const String privacyPolicyScreen = '/privacyPolicyScreen';
  static const String faqScreen = '/faqScreen';
  static const String aboutUsScreen = '/aboutUsScreen';
  static const String contactUsScreen = '/contactUsScreen';
  static const String profileEditScreen = '/profileEditScreen';
  static const String profileOfferScreen = '/profileOfferScreen';
  static const String wishlistOfferScreen = '/wishlistOfferScreen';
  static const String addAddressScreen = '/addAddressScreen';
  static const String editAddressScreen = '/editAddressScreen';
  static const String addNewPaymentCardScreen = '/addNewPaymentCardScreen';
  static const String cartScreen = '/cartScreen';
  static const String checkoutScreen = '/checkoutScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String submitFeedBackScreen = '/submitFeedBackScreen';
  static const String addressScreen = '/addressScreen';
  static const String paymentsScreen = '/paymentsScreen';
  static const String productSearchScreen = '/productSearchScreen';
  static const String allFlashDealProductScreen = '/allFlashDealProductScreen';
  static const String reviewListScreen = '/reviewListScreen';
  static const String changePasswordScreen = '/changePasswordScreen';
  static const String placeOrderScreen = '/placeOrderScreen';
  static const String paypalScreen = '/paypalScreen';
  static const String razorpayScreen = '/razorpayScreen';
  static const String flutterWaveScreen = '/flutterWaveScreen';
  static const String sslCommerceScreen = '/sslCommerceScreen';
  static const String molliePaymentScreen = '/molliePaymentScreen';
  static const String myFatoorahPaymentScreen = '/myFatoorahPaymentScreen';
  static const String instamojoPaymentScreen = '/instamojoPaymentScreen';
  static const String paystackPaymentScreen = '/paystackPaymentScreen';
  static const String stripeScreen = '/stripeScreen';
  static const String bankScreen = '/bankScreen';
  static const String flashScreen = '/flashScreen';
  static const String bannerProducts = '/bannerProducts';
  static const String sellerScreen = '/sellerScreen';
  static const String maintainScreen = '/maintainScreen';
  static const String chatScreen = '/chatScreen';
  static const String becomeSellerScreen = '/becomeSellerScreen';
  static const String deliveryManRegistrationScreen =
      '/deliveryManRegistrationScreen';
  static const String moreVideoScreen = '/moreVideoScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.onBoardingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OnboardingScreen());
      case RouteNames.changePasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChangePasswordScreen());
      case RouteNames.productSearchScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProductSearchScreen());

      case RouteNames.maintainScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MaintainScreen());

      case RouteNames.mainPage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const MainPage());
      case RouteNames.homeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomeScreen());
      case RouteNames.animatedSplashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AnimatedSplashScreen());
      case RouteNames.authenticationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AuthenticationScreen());
      case RouteNames.forgotScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ForgotScreen());
      case RouteNames.verificationCodeScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const VerificationCodeScreen());
      case RouteNames.setPasswordScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SetPasswordScreen());

      case RouteNames.allCategoryListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AllCategoryListScreen());
      case RouteNames.allSellerList:
        final sellerList = settings.arguments as List<HomeSellerModel>;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => AllSellerList(sellers: sellerList));

      case RouteNames.sellerScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SellerDetailsScreen());
      case RouteNames.allPopularProductScreen:
        // final keyword = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AllPopularProductScreen());
      case RouteNames.singleCategoryProductScreen:
        // final slug = settings.arguments as String;
        // final title = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SingleCategoryProductScreen(),
        );
      case RouteNames.brandProductScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BrandProductScreen(slug: slug),
        );
      case RouteNames.chatScreen:
        // final slug = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ChatScreen(),
        );

      case RouteNames.becomeSellerScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const BecomeSellerScreen(),
        );

      case RouteNames.deliveryManRegistrationScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DeliveryManRegistrationScreen(),
        );
      case RouteNames.moreVideoScreen:
        final videos = settings.arguments as List<VideoModel>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MoreVideoScreen(videos: videos),
        );

      case RouteNames.subCategoryProductScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SubCategoryProductScreen(slug: slug),
        );
      case RouteNames.allFlashDealProductScreen:
        final products = settings.arguments as List<ProductModel>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AllFlashDealProductScreen(products: products),
        );
      case RouteNames.notificationScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const NotificationScreen());
      case RouteNames.chatListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ChatListScreen());
      case RouteNames.orderScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const OrderScreen());
      case RouteNames.singleOrderScreen:
        final trackNumber = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SingleOrderDetails(trackNumber: trackNumber));

      case RouteNames.orderTrackingScreen:
        final orders = settings.arguments as OrderModel;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => OrderTrackingScreen(orders: orders));

      case RouteNames.orderTrackingFormScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const OrderTrackingFormScreen());
      case RouteNames.settingScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SettingScreen());
      case RouteNames.termsConditionScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const TermsConditionScreen());
      case RouteNames.privacyPolicyScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PrivacyPolicyScreen());
      case RouteNames.faqScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const FaqScreen());
      case RouteNames.aboutUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AboutUsScreen());
      case RouteNames.contactUsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ContactUsScreen());
      case RouteNames.profileEditScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileEditScreen());
      case RouteNames.profileOfferScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const ProfileOfferScreen());
      case RouteNames.wishlistOfferScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const WishlistOfferScreen());
      case RouteNames.paymentsScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const PaymentsScreen());
      case RouteNames.addressScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AddressScreen());

      case RouteNames.addAddressScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const AddAddressScreen());

      case RouteNames.editAddressScreen:
        final map = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            settings: settings, builder: (_) => EditAddressScreen(map: map));

      case RouteNames.addNewPaymentCardScreen:
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => const AddNewPaymentCardScreen());
      case RouteNames.cartScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CartScreen());
      case RouteNames.checkoutScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const CheckoutScreen());
      case RouteNames.productDetailsScreen:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => ProductDetailsScreen(slug: slug));
      case RouteNames.reviewListScreen:
        final productReviews =
            settings.arguments as List<DetailsProductReviewModel>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SeelAllReviewsScreen(productReviews: productReviews),
        );

      case RouteNames.submitFeedBackScreen:
        final orderItem = settings.arguments as OrderedProductModel;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SubmitFeedBackScreen(orderItem: orderItem),
        );

      case RouteNames.placeOrderScreen:
        // final shippingMethod = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const PlaceOrderScreen(),
        );

      case RouteNames.paypalScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaypalScreen(url: paypalUrl),
        );
      case RouteNames.razorpayScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RazorpayScreen(url: paypalUrl),
        );
      case RouteNames.flutterWaveScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FlutterWaveScreen(url: paypalUrl),
        );
      case RouteNames.molliePaymentScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MolliePaymentScreen(url: paypalUrl),
        );
      case RouteNames.myFatoorahPaymentScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MyFatoorahPaymentScreen(url: paypalUrl),
        );
      case RouteNames.instamojoPaymentScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => InstamojoPaymentScreen(url: paypalUrl),
        );
      case RouteNames.paystackPaymentScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PaystackPaymentScreen(url: paypalUrl),
        );
      case RouteNames.sslCommerceScreen:
        final paypalUrl = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => SslCommerceScreen(url: paypalUrl),
        );
      case RouteNames.stripeScreen:
        final body = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => StripeScreen(mapBody: body),
        );

      case RouteNames.bankScreen:
        final body = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BankPaymentScreen(mapBody: body),
        );

      case RouteNames.flashScreen:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const FlashScreen(),
        );
      case RouteNames.bannerProducts:
        final slug = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BannerProductScreen(
            slug: slug,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
