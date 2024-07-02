class CommonEnviroment {
  
}

const Map<DOMAIN_TYPE, String> LIVE_DOMAIN = {
  DOMAIN_TYPE.MAIN: "http://192.168.0.47:8989/api/",
  DOMAIN_TYPE.PAYMENT: "https://navitrack.fft.com.vn:8899/api/",
};

const Map<DOMAIN_TYPE, String> UAT_DOMAIN = {
  DOMAIN_TYPE.MAIN: "http://192.168.0.47:8989/api/",
  DOMAIN_TYPE.PAYMENT: "https://navitrack.fft.com.vn:8899/api/",
};

const Map<DOMAIN_TYPE, String> DEV_DOMAIN = {
  DOMAIN_TYPE.MAIN: "http://192.168.0.47:8989/api/",
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
  USER,
  COURSE,
  LandingPages,
  NONE
}

const Map<SERVICE_TYPE, String> SERVICE = {
  SERVICE_TYPE.AUTHEN: "Account",
  SERVICE_TYPE.SETTING: "settings",
  SERVICE_TYPE.USER: "Users",
  SERVICE_TYPE.COURSE: "Course",
  SERVICE_TYPE.LandingPages: "LandingPages",
  SERVICE_TYPE.NONE: "",

};
