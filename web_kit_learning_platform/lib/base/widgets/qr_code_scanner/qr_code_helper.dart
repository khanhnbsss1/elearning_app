import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webkit/plugins/screenshot/lib/screenshot.dart';
class QRCodeHelper{
  static final QRCodeHelper _singletonQRCodeHelper = QRCodeHelper._internal();
  static QRCodeHelper get getInstance => _singletonQRCodeHelper;
  factory QRCodeHelper() {
    return _singletonQRCodeHelper;
  }
  QRCodeHelper._internal();


  Future<void> captureAndShareQRCode({required BuildContext context,  required ScreenshotController controller}) async {
    controller.capture(
        delay: const Duration(milliseconds: 10)).then((image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);
        final box = context.findRenderObject() as RenderBox?;

        /// Share Plugin
        await Share.shareXFiles(
          [XFile(imagePath.path),],
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        );
      }
    });
  }
}