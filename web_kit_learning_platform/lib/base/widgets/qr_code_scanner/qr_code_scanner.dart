import 'dart:convert';
import 'package:gap/gap.dart';
import 'package:webkit/base/widgets/qr_code_scanner/scanner_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanning_effect/scanning_effect.dart';

import '../../base.export.dart';

class QRCodeScanner extends StatefulWidget{
  void show(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => this);
  }
  String? title;
  bool? enableBackButton;
  QRCodeScanner({super.key, this.scannerResult, this.title, this.enableBackButton});
  Function(String text)?scannerResult;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _QRCodeScannerState();
  }
  
}
class _QRCodeScannerState extends State<QRCodeScanner>{
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    autoStart: false
  );
  @override
  Future<void> dispose() async {
    super.dispose();
    controller.stop();
  }
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),() async {
      await controller.start();
    },);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double sizeOfScanner= MediaQuery.of(context).size.width*3/4;
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: Dimens.size400,
      height: Dimens.size400,
    );
    return Scaffold(
      backgroundColor: ColorConst.blackColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: MobileScanner(
                fit: BoxFit.contain,
                controller: controller,
                scanWindow: scanWindow,
                onDetect: (barcodes) {
                  String text = utf8.decode(base64.decode(barcodes.barcodes.first.displayValue??""));
                  if(widget.scannerResult!=null)
                  {
                    widget.scannerResult!(text);
                  }
                },
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                overlayBuilder: (context, constraints) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: sizeOfScanner,
                          height: sizeOfScanner,
                          child: ScanningEffect(
                            scanningColor: ColorConst.mainColor,
                            borderLineColor: ColorConst.whiteColor,
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(seconds: 2),
                            scanningLinePadding: EdgeInsets.zero,
                            child: const SizedBox.shrink(),
                          ),
                        ),
                        Visibility(
                          visible: widget.title!=null && widget.title!.isNotEmpty,
                          child: Center(child: Text(widget.title??"", textAlign: TextAlign.center,), ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: widget.enableBackButton??true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Gap((Dimens.size16)),
                      BackButtonCustom(buildContext: context, color: ColorConst.whiteColor),
                      Text(S.of(context).string_back,
                          style: TextStyleConstant.textStyleBlack24w700.copyWith(color: ColorConst.whiteColor),
                          maxLines:1
                      )
                    ],
                  ),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
