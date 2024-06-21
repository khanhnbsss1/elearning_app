
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../base.export.dart';

class DragAbleWidget extends StatefulWidget{
  Widget ?child;
  AlignmentGeometry alignment;
  Color? bgColor;
  BorderRadiusGeometry? borderRadius;
  EdgeInsetsGeometry? padding;
  DragAbleWidget({super.key, this.child, this.alignment=Alignment.bottomCenter, this.bgColor, this.borderRadius, this.padding});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DragAbleWidgetState();
  }

}
class DragAbleWidgetState extends State<DragAbleWidget>{
  bool isExpand = true;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Align(
    alignment: widget.alignment,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: widget.padding??EdgeInsets.symmetric(vertical: Dimens.size5, horizontal: Dimens.size5),
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: widget.bgColor??ColorConst.whiteColor,
        borderRadius: widget.borderRadius??BorderRadius.vertical(top:Radius.circular(Dimens.size20))
      ),
        child: GestureDetector(
        onPanUpdate: (details) {
          if((details.delta.dx/details.delta.dy).abs()<1.0)
          {
            if (details.delta.dy > 0) {
              setState(() {
                isExpand= false;
              });
            } else {
              setState(() {
                isExpand= true;
              });
            }
          }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.transparent,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.drag_handle,
                      color:ColorConst.greyColor1,
                      size: Dimens.size20,),
                  ],
                ),
              ),
              Gap(Dimens.size5),
              Visibility(
                  visible: isExpand,
                  child: (widget.child!=null)?widget.child!:const SizedBox.shrink()
              ),
            ],
          ),
        ),
      ),
    );
  }

}