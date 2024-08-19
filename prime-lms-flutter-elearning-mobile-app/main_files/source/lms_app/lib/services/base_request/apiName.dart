class ApiName {
  static ApiName ?_instance = ApiName();

  static ApiName getInstance() {
    _instance ??= ApiName();
    return _instance!;
  }

  final int connectTimeout = 30000;
  final int readTimeout = 20000;

  //user
  final String LOGIN = "/login";
  final String LOGOUT = "/logout";
  final String REQUEST_OTP = "/request-otp";
  final String VERIFY_OTP = "/verify-otp";
  final String CREATE_PIN = "/pin-code";
  final String UPDATE_PIN = "/pin-code";
  final String RESET_PIN = "/pin-code/reset";

  final String LOGIN_WITH_PIN = "/login-pin";
  final String LOGIN_WITH_OTP = "/login-otp";
  final String SEARCH_USER ="/search-child-users";
  final String CREATE_USER = "";
  final String CREATE_CUSTOM_USER = "/customer";

  final String DELETE_USER = "";
  final String GET_WALLET_BALANCE = "/wallet-balance";
  final String PROFILE = "/profile";
  final String CHANGE_PASSWORD = "/change-password";
  final String USER_CHILD_LIST = "/get-child-users";
  final String FORGOT_PASSWORD = "/forgot-password";


  ///tracking
  final String LIST_DEVICE = "/devices/search";
  final String DEVICE_DETAIL = "/devices";

  ///terminal
  final String LIST_TERMINAL ="/terminal/search";
  final String TERMINAL_INFO ="/terminal";

  ///setting
  final String GET_ALL_CONFIG = "/config";

  ///favourite

  final String DEVICE_FAVOURITE_CREATE= "/device_elearning-favourite";
  final String DEVICE_FAVOURITE_DELETE= "/device_elearning-favourite";
  final String DEVICE_FAVOURITE_SEARCH= "/device_elearning-favourite/search";

/// payment and charring
  final String getChargingStatus ="/charging";
  final String getPaymentQrCode= "/get-balance-qr";
  final String getPaymentDetail= "/search-By-RefNum";

  /// dardboard
  final String dashboard= "dashboard";
  final String paymentHistory= "transaction-history";
  /// qr_code
  final String getQrCodeByType= "/info";
  final String notifyHistory="/search";
  final String notifyUpdateReadStatus="/is-read";

  
  /// voucher
  final String LIST_VOUCHER ="/search";
  final String DETAIL_VOUCHER ="";
  final String LINK_VOUCHER ="/link-account";
  final String PAY_VOUCHER ="/pay";
  final String walletSearchHistory= "/wallet/search";

  
}

