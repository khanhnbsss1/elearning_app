
import 'package:flutter/material.dart';

import '../../constant/dimens_constant.dart';
import '../../theme/colors_app.dart';
import '../../theme/text_stype_constant.dart';

class ExpandWidget extends StatefulWidget{
  String? title;
  TextStyle? titleStyle;
  Widget? child;
  bool? initExpand;
  bool? enableSubfixExpand;
  bool? enablePrefixExpand;
  EdgeInsetsGeometry? paddingChild;
  EdgeInsetsGeometry? paddingHeader;
  TextAlign? textAlignTitle;
  Color? expandColor;
  double? radius;
  bool? enableDivider;
  Color? dividerColor;
  Color? borderColor;

  List<Color>? titleGradient;
  Color? titleExpandColor;
  Color? titleCollapseColor;
  ExpandWidget({
    super.key,
    this.title,
    this.titleStyle,
    this.child,
    this.initExpand,
    this.paddingChild,
    this.paddingHeader,
    this.enableSubfixExpand,
    this.textAlignTitle,
    this.expandColor,
    this.enableDivider,
    this.radius,
    this.dividerColor,
    this.titleGradient,
    this.enablePrefixExpand,
    this.titleCollapseColor, 
    this.titleExpandColor,
    this.borderColor
  }){
    titleStyle??=TextStyleConstant.textStyleBlack16w600;
    enableSubfixExpand??=true;
    enablePrefixExpand??=false;
    enableDivider??=false;
    radius??=Dimens.size8;
    titleGradient??=null;
    borderColor??=Colors.transparent;
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
    if(widget.enableSubfixExpand==false){
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
   return Card(
     elevation: 1,
     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(widget.radius!), ),
     child: Container(
       decoration: BoxDecoration(
         color: widget.expandColor??ColorConst.whiteColor,
         borderRadius: BorderRadius.circular(widget.radius!),
         border: Border.all(color: widget.borderColor!)
       ),
       clipBehavior: Clip.hardEdge,
       child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: widget.expandColor??ColorConst.whiteColor,
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  if(widget.enableSubfixExpand==true)
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
                    decoration: BoxDecoration(
                      gradient: widget.titleGradient != null ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment(0.8, 1),
                        colors: <Color>[
                          widget.titleGradient![0],
                          widget.titleGradient![1],
                        ], // Gradient from https://learnui.design/tools/gradient-generator.html
                        tileMode: TileMode.mirror,
                      ) : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.enablePrefixExpand??true,
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
                                _isExpand?Icons.remove:Icons.add,
                                size: Dimens.size25,
                                color: (_isExpand?widget.titleExpandColor: widget.titleCollapseColor)??ColorConst.greyColor,),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                              widget.title??"",
                              textAlign: widget.textAlignTitle??TextAlign.start,
                              style: widget.titleStyle?.copyWith(color:  (_isExpand?widget.titleExpandColor: widget.titleCollapseColor)),
                          ),
                        ),
                        Visibility(
                          visible: widget.enableSubfixExpand??true,
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
                                color: (_isExpand?widget.titleExpandColor: widget.titleCollapseColor)??ColorConst.greyColor,),
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
     ),
   );
  }

}