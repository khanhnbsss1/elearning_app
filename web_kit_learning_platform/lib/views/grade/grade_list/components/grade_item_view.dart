import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/grade/models/grade_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';

class GradeItemView extends StatelessWidget {
  GradeItemView({
    required this.tagInfo,
    this.onViewDetail,
    this.onEdit,
    this.onDelete,
  });

  Function(GradeInfo)?onViewDetail;
  Function(GradeInfo)?onEdit;
  Function(GradeInfo)?onDelete;

  GradeInfo tagInfo;
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
      return  LayoutBuilder(builder: (context, constraints) {
        return OnHoverWidget(
          builder: (isHovered) {
            return Container(
              decoration: BoxDecoration(
                color: isHovered && !notifier.isDark
                // ? Color.fromRGBO(255, 243, 94, 1.0)
                    ? ColorConst.mainColor.withOpacity(0.05)
                    : isHovered && notifier.isDark
                    ? ColorConst.backGroundColor
                    : notifier.whitecolor,
                border: Border(
                  bottom: BorderSide(
                    color: ColorConst.dividerColor,
                    width: 0.5
                  )
                )
              ),
            
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: ColorConst.mainColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(Dimens.size40)
                          ),
                          width: Dimens.size50,
                          height: Dimens.size50,
                          
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                '${tagInfo.id}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleConstant
                                    .normalTextOnBackGroundColorStyle16w400.copyWith(
                                  color: ColorConst.mainColor,
                                  fontSize: ResponsiveInfo.isPhone()?Dimens.size18:Dimens.size16,
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Gap(Dimens.size8),
                        Text(
                          '${tagInfo.name}' ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConstant
                              .normalTextOnBackGroundColorStyle16w400.copyWith(
                            fontSize: ResponsiveInfo.isPhone()?Dimens.size18:Dimens.size16,
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ItemViewEditDelete(
                          itemInfo: tagInfo,
                          enableView: false,
                          enableEditDelete: UserManager().userContainPermission(permissionList: ["grades.delete.delete_grade"]),
                          enableEdit: UserManager().userContainPermission(permissionList: ["grades.delete.delete_grade"]),
                          onEdit: (p0) {
                            if(onEdit!=null)
                            {
                              onEdit!(p0);
                            }
                          },
                          onDelete: (p0) {
                            if(onDelete!=null)
                            {
                              onDelete!(p0);
                            }
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },);
    },
    );
  }
}
