import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/base/widgets/dialog_common/common_dialog1.dart';

import '../../base.export.dart';
class ConfirmPopupPage extends StatefulWidget{
  void show(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => this);
  }
  void Function()? onAccept;
  String? title;
  String? content;
  ConfirmPopupPage({super.key, this.onAccept, this.content, this.title});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ConfirmPopupPageState();
  }

}
class ConfirmPopupPageState extends State<ConfirmPopupPage> with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    bool  isTablet = ResponsiveInfo.isTablet();
    return buildUiAll(context, isTablet: isTablet);
  }
  late AnimationController controller ;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
  }

  Widget buildUiAll(BuildContext context, {bool ? isTablet}){
    isTablet??=false;
    
    return ScaleTransition(
      scale: scaleAnimation,
      child: CustomDialog1(
          title: widget.title,
          titleAlignment: MainAxisAlignment.center,
          insetPadding: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width*(!isTablet?0.95: 0.7),
          enableBackButton: false,
          enableCloseButton: true,
          mainAxisSizeParent: MainAxisSize.min,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
                child: Center(
                  child: Text(
                      widget.content??"",
                      textAlign: TextAlign.center,
                      style: TextStyleConstant.titleTextColorOnBackgroundColorStyle14w400
                  ),),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ActionButton1(
                        width: Dimens.size120,
                        onTap: () async {
                          Navigator.of(context).pop();
                        },
                        text: S.of(context).str_cancel,
                        height: Dimens.size40),
                    Gap(Dimens.size20),
                    ActionButton1(
                        width: Dimens.size120,
                        onTap: () async {
                          Navigator.of(context).pop();
                          if(widget.onAccept!=null)
                            {
                              widget.onAccept!();
                            }
                        },
                        text: S.of(context).str_accept,
                        height: Dimens.size40),
                  ],
                ),
              )
            ],
          )
      ),
    );
  }

  

  }