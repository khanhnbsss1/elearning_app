import 'package:flutter/material.dart';

import '../../base.export.dart';

class CheckboxCommon extends StatefulWidget{
  bool? isCheck = false;
  String? title ="";
  void Function(bool?)? onChanged;
  CheckboxCommon({super.key, this.title, this.isCheck,this.onChanged});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckbocCommonState();
  }

}
class CheckbocCommonState extends State<CheckboxCommon>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
   return Row(
     mainAxisSize: MainAxisSize.min,
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Checkbox(
         value: widget.isCheck,
         checkColor: ColorConst.whiteColor,
         activeColor: ColorConst.greyColor1,
         fillColor: WidgetStateProperty.resolveWith(getColor),
         side: BorderSide(color: ColorConst.greyColor1, width: 1),
         shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(5 ),side: BorderSide(color: ColorConst.greyColor1, width: 1),),
         onChanged: (value) {
           setState(() {
             widget.isCheck = value!;
             if(widget.onChanged!=null)
               {
                 widget.onChanged!(value);
               }
           });
         },
       ),
       Text(widget.title??"", style: TextStyleConstant.normalTextOnBackGroundColorStyle14w400,)
     ],
   );
  }
  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      //WidgetState.pressed,
     // WidgetState.hovered,
      //WidgetState.focused,
      WidgetState.selected
    };
    if (states.any(interactiveStates.contains)) {
      return ColorConst.mainColor.withOpacity(0.5);
    }
    return ColorConst.whiteColor;
  }
}