
import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';

enum LoadingType{
  fullScreen,
  loadOnPage
}
class LoadingLogo extends StatefulWidget {
   String? title;
   double? textSize;
   String? assetImage;
   double? sizeImage;
   Color? imageColor;
   LoadingType? loadingType;
    LoadingLogo({super.key,
         this.title,
         this.textSize,
         this.assetImage,
         this.sizeImage,
      this.loadingType,
      this.imageColor
    }){
      title??="Loading...";
      textSize??=Dimens.size14;
      loadingType??=LoadingType.fullScreen;
      imageColor??=ColorConst.mainColor;
      switch(loadingType)
          {

        case null:
          // TODO: Handle this case.
          break;
        case LoadingType.fullScreen:
          // TODO: Handle this case.
          assetImage??= ImagesNameConst.getPngImage(ImagesNameConst.icLoading);
          break;
        case LoadingType.loadOnPage:
          // TODO: Handle this case.
          assetImage??= ImagesNameConst.getPngImage(ImagesNameConst.ic_loading_on_page_png);
          break;
      }
      sizeImage??=Dimens.size60;
    }

  @override
  State<LoadingLogo> createState() => _LoadingLogoState();
}

class _LoadingLogoState extends State<LoadingLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationRotation;
  late Animation<double> animationScale;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    animationRotation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 1.0, curve: Curves.linear)));

    animationScale = Tween<double>(begin: 0, end: widget.sizeImage).animate(controller);
    controller.forward().whenComplete(() {
      controller.reverse();
    });

    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        //width: 100.0,
        height: 100.0,
        child: Center(
          child: Column(
            children: [
              RotationTransition(
                  turns: animationRotation,
                  child: AnimatedBuilder(
                    animation: animationScale,
                    builder: (context, child) {
                      return SizedBox(
                        height: widget.sizeImage,
                          width: widget.sizeImage,
                        child: Image.asset(
                            widget.assetImage!,
                          color: widget.imageColor,
                        ),
                      );
                    },
                  )),
              const SizedBox(height: 10),
              Text(widget.title!,
                style:baseStyle.copyWithCustom(
                    color: ColorConst.blackColor,
                fontSize: widget.textSize),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
