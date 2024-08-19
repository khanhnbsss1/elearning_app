
import 'package:flutter/material.dart';

import '../../constant/dimens_constant.dart';
import '../../theme/colors_app.dart';
import '../../theme/text_stype_constant.dart';

class ExpandWidget extends StatefulWidget{
  String? title;
  TextStyle? titleStyle;
  Widget? child;
  bool? initExpand;
  bool? enableExpand;
  EdgeInsetsGeometry? paddingChild;
  EdgeInsetsGeometry? paddingHeader;
  TextAlign? textAlignTitle;
  Color? expandColor;
  double? radius;
  bool? enableDivider;
  Color? dividerColor;
  ExpandWidget({
    super.key,
    this.title,
    this.titleStyle,
    this.child,
    this.initExpand,
    this.paddingChild,
    this.paddingHeader,
    this.enableExpand,
    this.textAlignTitle,
    this.expandColor,
    this.enableDivider,
    this.radius,
    this.dividerColor
  }){
    titleStyle??=TextStyleConstant.textStyleBlack16w600;
    enableExpand??=true;
    enableDivider??=false;
    radius??=Dimens.size8;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ExpandWidgetState();
  }

}
class ExpandWidgetState extends State<ExpandWidget>with SingleTickerProviderStateMixin{
  bool _isExpand = true;
  late AnimationController expandController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();

    _isExpand = widget.initExpand??true;
    if(widget.enableExpand==false){
      _isExpand=true;
    }
  }
  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }
  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500)
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }
  void _runExpandCheck() {
    if(_isExpand==true) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }
  @override
  void didUpdateWidget(ExpandWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
     decoration: BoxDecoration(
       color: widget.expandColor??ColorConst.whiteColor,
       borderRadius: BorderRadius.circular(widget.radius!)
     ),
     
     child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: widget.expandColor,
            alignment: Alignment.centerLeft,
            child: InkWell(
              onTap: () {
                if(widget.enableExpand==true)
                  {
                    setState(() {
                      _isExpand= !_isExpand;
                      _runExpandCheck();
                    });
                  }

              },
              child: Padding(
                padding: widget.paddingHeader?? EdgeInsets.symmetric(horizontal: Dimens.size8, vertical: Dimens.size8),
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: Dimens.size35,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            widget.title??"",
                            textAlign: widget.textAlignTitle??TextAlign.start,
                            style: widget.titleStyle!,
                        ),
                      ),
                      Visibility(
                        visible: widget.enableExpand??true,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                _isExpand= !_isExpand;
                                _runExpandCheck();
                              });
                            },
                            child: Icon(
                              _isExpand?Icons.arrow_drop_down_sharp:Icons.arrow_drop_up_outlined,
                              size: Dimens.size25,
                              color: ColorConst.greyColor,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizeTransition(
            axisAlignment: 1.0,
            sizeFactor: animation,
            child: Container(
              color: widget.expandColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: widget.enableDivider??false,
                    child: Divider(color: widget.dividerColor??ColorConst.greyColor.withOpacity(0.5),),
                  ),
                  Padding(
                    padding: widget.paddingChild??EdgeInsets.symmetric(horizontal: Dimens.size8, vertical: Dimens.size8),
                    child: widget.child??const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
   );
  }

}