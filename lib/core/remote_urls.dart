class RemoteUrls {
  static const String rootUrl = "https://mamunuiux.com/shopo/";
  static const String baseUrl = '${rootUrl}api/';
  static const String homeUrl = baseUrl;
  static const String userRegister = '${baseUrl}store-register';
  static const String userLogin = '${baseUrl}store-login';

  static String socialSignUrl(String userInfo) =>
      '${baseUrl}callback/mobile-app?$userInfo';

  static String updateUserForPushNotification(String token) =>
      '${baseUrl}user/update-device-token?token=$token';

  static const String createDeliveryMan = '${baseUrl}deliveryman/registration';

  static String userLogOut(String token) =>
      '${baseUrl}user/logout?token=$token';
  static const String sendForgetPassword = '${baseUrl}send-forget-password';
  static const String resendRegisterCode = '${baseUrl}resend-register-code';

  static String storeResetPassword(String code) =>
      '${baseUrl}store-reset-password/$code';

  static String userVerification(String code) =>
      '${baseUrl}user-verification/$code';

  static String userProfile(String token) =>
      '${baseUrl}user/my-profile?token=$token';

  static String updateProfile(String token) =>
      '${baseUrl}user/update-profile?token=$token';

  static String becomeSellerRequest(String token) =>
      '${baseUrl}user/seller-request?token=$token';

  static String changePassword(String token) =>
      '${baseUrl}user/update-password?token=$token';

  static String countryListUrl(String token) =>
      '${baseUrl}user/address/create?token=$token';

  static String editAddress(String id, String token) =>
      '${baseUrl}user/address/$id/edit?token=$token';

  static String stateByCountryId(String countryId, String token) =>
      '${baseUrl}user/state-by-country/$countryId?token=$token';

  static String sellerDetailsUrl(String slug) => '${baseUrl}sellers/$slug';

  static String citiesByStateId(String stateId, String token) =>
      '${baseUrl}user/city-by-state/$stateId?token=$token';

  static String orderList(String token) => '${baseUrl}user/order?token=$token';

  static String deleteUserAccount(String token) =>
      '${baseUrl}user/remove-account?token=$token';

  static String allChartUrl(String token) =>
      '${baseUrl}user/message-with-seller?token=$token';

  static String sendMsgToSeller(String token) =>
      '${baseUrl}user/send-message-to-seller?token=$token';

  static String showOrderTracking(String trackNumber, String token) =>
      '${baseUrl}user/order-show/$trackNumber?token=$token';

  static String trackingOrderResponse(String trackNumber) =>
      '${baseUrl}track-order-response/$trackNumber';
  static const String aboutUs = '${baseUrl}about-us';
  static const String faq = '${baseUrl}faq';
  static const String termsAndConditions = '${baseUrl}terms-and-conditions';
  static const String privacyPolicy = '${baseUrl}privacy-policy';
  static const String contactUs = '${baseUrl}contact-us';
  static const String sendContactMessage = '${baseUrl}send-contact-message';
  static const String websiteSetup = '${baseUrl}website-setup';

  static String productDetail(String slug) => '${baseUrl}product/$slug';

  static String address(String token) => '${baseUrl}user/address?token=$token';

  static String singleAddress(String id, String token) =>
      '${baseUrl}user/address/$id?token=$token';

  static String deleteAddress(String id, String token) =>
      '${baseUrl}user/address/$id?token=$token';

  static String billingAddress(String token) =>
      '${baseUrl}user/update-billing-address?token=$token';

  static String updateAddress(String id, String token) =>
      '${baseUrl}user/address/$id?token=$token';

  static String addAddressUrl(String token) =>
      '${baseUrl}user/address?token=$token';

  static String shippingAddress(String token) =>
      '${baseUrl}user/update-shipping-address?token=$token';

  static String wishList(String token) =>
      '${baseUrl}user/wishlist?token=$token';

  static String removeWish(int id, String token) =>
      '${baseUrl}user/remove-wishlist/$id?token=$token';

  static String clearWishList(String token) =>
      '${baseUrl}user/clear-wishlist?token=$token';

  static String addWish(int id, String token) =>
      '${baseUrl}user/add-to-wishlist/$id?token=$token';
  static const String searchProduct = '${baseUrl}product?';

  static String cartProduct(String token) => "${baseUrl}cart?token=$token";

  static String submitReviewUrl(String token) =>
      '${baseUrl}user/store-product-review?token=$token';

  static const String stripeBaseUrl = "https://api.stripe.com/v1";
  static const String paymentApi = "$stripeBaseUrl/payment_intents";

  static String cartCheckout(String token, String coupon) =>
      "${baseUrl}user/checkout?token=$token&coupon=$coupon";

  static String incrementQuantity(String id, String token) =>
      "${baseUrl}cart-item-increment/$id?token=$token";

  static String decrementQuantity(String id, String token) =>
      "${baseUrl}cart-item-decrement/$id?token=$token";

  static String applyCoupon(String coupon, String token) =>
      "${baseUrl}apply-coupon?coupon=$coupon&token=$token";

  static String removeCartItem(String id, String token) =>
      "${baseUrl}cart-item-remove/$id?token=$token";
  static const String addToCart = '${baseUrl}add-to-cart?';
  static const String filterUrl = '${baseUrl}search-product?';
  static const String flashSaleUrl = '${baseUrl}flash-sale';

  static String cashOnDelivery(String token) =>
      '${baseUrl}user/checkout/cash-on-delivery?token=$token';

  static const String payWithPaypal =
      '${baseUrl}user/checkout/pay-with-paypal?';

  static String payWithPaypalWeb(String token, String params) =>
      '${rootUrl}user/checkout/paypal-web-view?token=$token&$params&agree_terms_condition=1';

  static String razorOrder = '${rootUrl}user/checkout/razorpay-order';

  static String payWithRazorpayWeb(
    String token,
    String params,
  ) =>
      "${rootUrl}user/checkout/razorpay-web-view?token=$token&$params";

  static String payWithFlutterWave(
    String token,
    String params,
  ) =>
      "${rootUrl}user/checkout/flutterwave-web-view?token=$token&$params";

  static String payWithMollieWeb(
    String token,
    String params,
  ) =>
      "${rootUrl}user/checkout/pay-with-mollie?token=$token&$params";

  // myfatoorah-webview?token=eeer&others_params
  static String payWithMyFatooraheWeb(
    String token,
    String params,
  ) =>
      "${rootUrl}user/checkout/myfatoorah-webview?token=$token&$params";

  // https://ztatgo.net/api/?
  static String payWithInstaMojoWeb(
    String token,
    String params,
  ) =>
      "${rootUrl}user/checkout/pay-with-instamojo?token=$token&$params";

  static String payWithPayStackWeb(
    String token,
    String params,
  ) =>
      "${rootUrl}user/checkout/paystack-web-view?token=$token&$params";

  static String payWithSslCommerz(
    String token,
    String params,
  ) =>
      "${rootUrl}user/checkout/sslcommerz-web-view?token=$token&$params";

  static String payWithBankUrl(String token) =>
      "${baseUrl}user/checkout/pay-with-bank?token=$token";
  static const String categoryLists = '${baseUrl}category-list';

  static String subCategoryLists(String categoryId) =>
      '${baseUrl}subcategory-by-category/$categoryId';

  static String childCategoryLists(String subCategoryId) =>
      '${baseUrl}childcategory-by-subcategory/$subCategoryId';

  static String highlightProductsUrl(String keyword) =>
      '${baseUrl}search-product?highlight=$keyword&page=1&per_page=10';

  static String loadMoreProducts(String keyword, int page, int perPage) =>
      '${baseUrl}search-product?highlight=$keyword&page=$page&per_page=$perPage';

  static String categoryProducts(String slug, int page) =>
      '${baseUrl}product?category=$slug&page=$page&per_page=1';

  static String brandProducts(String slug) => '${baseUrl}product?brand=$slug';

  static String subCategoryProducts(String slug) =>
      '${baseUrl}product?sub_category=$slug';

  static String filterProductsUrl(String slug) =>
      '${baseUrl}product?sub_category=$slug';

  static String payWithStripe(String token) =>
      '${baseUrl}user/checkout/pay-with-stripe?token=$token';

  static imageUrl(String imageUrl) => rootUrl + imageUrl;

  static videoUrl(String videoUrl) => '${rootUrl}upload/$videoUrl';

  static const String secretKey =
      "sk_test_51IiF1SCchAAd9IUU4Vf50h2Ps9KQcA6S8AJFWvtvkZLd7YKx2n5EfQzQWOG5v8oNMQy40Pye9rzbfshSCFtb9IUH00EQCTJHlS";
  static const String publishableKey =
      "pk_test_51IiF1SCchAAd9IUU01ifKTszStCbroodG5VCivqq8hbPcKlfWcgpacc7fuuNxRWLqV4kQ9Jp4cPfs09fYQArULKY00n86nl0cb";
}
