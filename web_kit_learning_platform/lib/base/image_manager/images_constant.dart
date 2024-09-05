import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:webkit/base/base.export.dart';

class ImageManager {
  ImageManager._();
  static final ImageManager _singletonImageConst = ImageManager._internal();
  static ImageManager get getInstance => _singletonImageConst;
  factory ImageManager() {
    return _singletonImageConst;
  }
  ImageManager._internal();
  
  // ========================IMAGE===========================
  // ========================ICON===========================
  // ========================SVG===========================
  // Home page
  static const pngFolder = "png/";
  static const pngFolderIpad = "png/ipad/";
  static const pngFolderPhone = "png/phone/";
  static const svgFolder = "svg/";
  static const iconFolder = "icons/";
  
  //svg
  static const String ic_svgLoginImageString = 'login.svg';
  static const String ic_success = 'ic_success.svg';
  static const String ic_error = 'ic_error.svg';
  static const String ic_ban = 'ic_ban.svg';
  
  //png
  static const String logo = 'logo.jpg';
  static const String user_png = 'user.png';
  static const String invalid_png = 'invalid.png';


  static const String icNoData = 'icNoData.png';
  static const String icLoading = 'icLoading.png';
  static const String ic_loading_on_page_png = 'loading_on_page.png';
  static const String icSearch = 'icSearch.png';
  static const String  ic_information_png ="ic_information.png";
  
  /*------------------------------------*/
   String getPngImageIpad(String name) {
    return "assets/$pngFolderIpad$name";
  }
   String getPngImagePhone(String name) {
    return "assets/$pngFolderPhone$name";
  }
   String getPngImagePath(String name) {
    return "assets/$pngFolder$name";
  }
   String getPngFolder() {
    return "assets/$pngFolder";
  }
   String getSvgFolder() {
    return "assets/$svgFolder";
  }
   String getIcon(String name) {
    return "assets/$iconFolder$name";
  }

   String getSvgImagePath(String name) {
    return "assets/$svgFolder$name";
  }

  Widget getImageByUrl(
      String url,
      {
        double? width,
        double? height,
        Color? color,
        Widget?errorBuilder,
        BoxFit boxFit = BoxFit.contain,
        Function()? onTap
      }) {
    return InkWell(
      onTap: onTap,
      child: 
/*      FutureBuilder(
          future: Future.sync(() async {
            Response res = await get(Uri.parse(url),);
            if (res.statusCode == 200) {
              return res.bodyBytes;
            }
          },), 
          builder: (context, snapshot) {
            
            return Image.asset(
              getPngImagePath(image),
              color: color,
              width: width,
              height: height,
              fit: boxFit,
              scale: FetchPixels.getScale(),
            )
          },
      )*/
      Image.network(
        url,
        color: color,
        width: width,
        height: height,
        fit: boxFit,
        scale: FetchPixels.getScale(),
        errorBuilder: (context, error, stackTrace) {
          return errorBuilder??ImageManager().getPngImage(ImageManager.invalid_png);
        },
      ),
    );
  }
  Widget getPngImage(String image,
      {
        double? width,
        double? height,
        Color? color,
        BoxFit boxFit = BoxFit.contain,
        Function()? onTap,
      }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Image.asset(
          getPngImagePath(image),
          color: color,
          width: width,
          height: height,
          fit: boxFit,
          scale: FetchPixels.getScale(),
        ),
      ),
    );
  }

  Widget getSvgImage(String image,
      {
        bool? isSvgFolder,
        double? width,
        double? height,
        Color? color,
        BoxFit boxFit = BoxFit.contain,
        Function()? onTap
      }) {
     isSvgFolder??=true;
    return InkWell(
      onTap: onTap,
      child: SvgPicture.asset(
        (isSvgFolder)?getSvgImagePath(image):image,
        color: color,
        width: width,
        height: height,
        fit: boxFit,
      ),
    );
  }

  Widget getPaddingWidget(EdgeInsets edgeInsets, Widget widget) {
    return Padding(
      padding: edgeInsets,
      child: widget,
    );
  }

  DecorationImage getDecorationAssetImage(BuildContext buildContext, String image,
      {BoxFit fit = BoxFit.contain}) {
    String folderPath = getSvgFolder();
    if(image.contains(".png")) {
      folderPath = getPngFolder();
    }
    return DecorationImage(
        image: AssetImage(folderPath + image),
        fit: fit,
        scale: FetchPixels.getScale());
  }
}
