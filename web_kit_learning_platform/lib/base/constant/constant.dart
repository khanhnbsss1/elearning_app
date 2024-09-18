class Constant{
  static final Constant _singletonConstant = Constant._internal();
  static Constant get getInstance => _singletonConstant;
  factory Constant() {
    return _singletonConstant;
  }
  Constant._internal();
  String phoneNumber ="0939917688";
  String hotline ="0903947941";
  String email = "nguyenthuong51899@gmail.com";
  String address = 'Số 26 Đường 57A, phường Tân Tạo, Quận Bình Tân, TPHCM';
  String androidLink ="https://play.google.com/store/apps/details?id=com.FFTCompany.YAXChinese";
  String iosAppLink ="https://apps.apple.com/us/app/yax-chinese/id6504179728";
  String mst ="0317530373";
  String companyName =" Công Ty Cổ Phần Giáo Dục Global Connection";

}