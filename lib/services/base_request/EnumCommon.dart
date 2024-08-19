class CommonEnviroment {
  
}

const Map<DOMAIN_TYPE, String> LIVE_DOMAIN = {
  DOMAIN_TYPE.MAIN: "https://navitrack.fft.com.vn:9092/api/",
  DOMAIN_TYPE.PAYMENT: "https://navitrack.fft.com.vn:8899/api/",
};

const Map<DOMAIN_TYPE, String> UAT_DOMAIN = {
  DOMAIN_TYPE.MAIN: "https://navitrack.fft.com.vn:9092/api/",
  DOMAIN_TYPE.PAYMENT: "https://navitrack.fft.com.vn:8899/api/",
};

const Map<DOMAIN_TYPE, String> DEV_DOMAIN = {
  DOMAIN_TYPE.MAIN: "https://navitrack.fft.com.vn:9092/api/",
  DOMAIN_TYPE.PAYMENT: "https://navitrack.fft.com.vn:8899/api/",
};

const Map<EVIROMENT_DOMAIN, Map<DOMAIN_TYPE, String>> DOMAIN_FINAL = {
  EVIROMENT_DOMAIN.LIVE_DOMAIN: LIVE_DOMAIN,
  EVIROMENT_DOMAIN.UAT_DOMAIN: UAT_DOMAIN,
  EVIROMENT_DOMAIN.DEV_DOMAIN: DEV_DOMAIN,
};

enum EVIROMENT_DOMAIN {
  LIVE_DOMAIN,
  UAT_DOMAIN,
  DEV_DOMAIN
}
enum DOMAIN_TYPE {
  MAIN,
  PAYMENT,
}

enum SERVICE_TYPE {
  AUTHEN,
  SETTING,
  BOOKING,
  USER,
  MAP,
  OCPP,
  TRANSACTION,
  OCPP_TRANSACTION,
  QR_CODE,
  PAYMENT,
  HISTORY,
  NOTIFICATION,
  VOUCHER,
  NONE
}

const Map<SERVICE_TYPE, String> SERVICE = {
  SERVICE_TYPE.AUTHEN: "auth",
  SERVICE_TYPE.SETTING: "settings",
  SERVICE_TYPE.USER: "users",
  SERVICE_TYPE.MAP: "map",
  SERVICE_TYPE.BOOKING: "booking",
  SERVICE_TYPE.OCPP: "OCPP",
  SERVICE_TYPE.OCPP_TRANSACTION:"ocpp-transaction",
  SERVICE_TYPE.TRANSACTION:"transaction",
  SERVICE_TYPE.PAYMENT:"payment",
  SERVICE_TYPE.QR_CODE:"qr-code",
  SERVICE_TYPE.HISTORY:"History",
  SERVICE_TYPE.NOTIFICATION:"notification",
  SERVICE_TYPE.VOUCHER:"vouchers",
  SERVICE_TYPE.NONE: "",

};
