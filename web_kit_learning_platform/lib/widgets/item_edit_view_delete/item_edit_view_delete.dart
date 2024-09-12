import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';

class ItemViewEditDelete extends StatelessWidget{
  Function(dynamic)?onViewDetail;
  Function(dynamic)?onEdit;
  Function(dynamic)?onDelete;
  dynamic itemInfo;
  bool? enableEdit, enableEditDelete, enableView;
  ItemViewEditDelete(
      {
        this.onViewDetail, 
        this.onDelete, 
        this.onEdit, 
        this.itemInfo,
        this.enableEdit, 
        this.enableEditDelete,
        this.enableView
      });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(Dimens.size6),
        Visibility(
          visible: enableView??true,
          child: Tooltip(
            message: L10nX.getStr.detail_str,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConst.greyColor.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(Dimens.size20)
              ),
              constraints: BoxConstraints(
                maxHeight: Dimens.size30,
                maxWidth: Dimens.size30,
              ),
              child: Center(
                child: InkWell(
                  onTap: () {
                    if(onViewDetail!=null)
                    {
                      onViewDetail!(itemInfo);
                    }
                  },
                  child: Icon(Icons.remove_red_eye, color: ColorConst.greyColor,size: Dimens.size15,),
                ),
              ),
            ),
          ),
        ),
        Gap(Dimens.size6),
        Visibility(
          visible: enableEditDelete??true,
          child: Tooltip(
            message: L10nX.getStr.edit_str,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConst.greyColor.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(Dimens.size40)
              ),
              constraints: BoxConstraints(
                maxHeight: Dimens.size35,
                maxWidth: Dimens.size35,
              ),
              child: Padding(
                padding:  EdgeInsets.all(Dimens.size6),
                child: Center(
                  child:  InkWell(
                    onTap: () {
                      if(onEdit!=null)
                      {
                        onEdit!(itemInfo);
                      }
                    },
                    child: Icon(Icons.note_alt_outlined, color: ColorConst.greyColor,size: Dimens.size15,),
                  ),
                ),
              ),
            ),
          ),
        ),
        Gap(Dimens.size6),
        Visibility(
          visible: enableEditDelete??true,
          child: Tooltip(
            message: L10nX.getStr.delete_str,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConst.mainColor.withOpacity(0.02),
                  borderRadius: BorderRadius.circular(Dimens.size40)
              ),
              constraints: BoxConstraints(
                maxHeight: Dimens.size35,
                maxWidth: Dimens.size35,
              ),
              child: Padding(
                padding:  EdgeInsets.all(Dimens.size6),
                child: Center(
                  child: InkWell(
                    onTap: () {
                      if(onDelete!=null)
                      {
                        onDelete!(itemInfo);
                      }
                    },
                    child: Icon(Icons.delete, color: ColorConst.mainColor,size: Dimens.size15,),
                  ),
                ),
              ),
            ),
          ),
        ),
        Gap(Dimens.size6),
      ],
    );
  }
  
}