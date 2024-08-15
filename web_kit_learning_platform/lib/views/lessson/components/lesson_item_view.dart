import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';

class LessonItemView extends StatelessWidget {
  LessonItemView({
    required this.lessonInfo,
    this.onViewDetail,
    this.onEdit,
    this.onDelete,
  });

  Function(LessonInfo)?onViewDetail;
  Function(LessonInfo)?onEdit;
  Function(LessonInfo)?onDelete;

  LessonInfo lessonInfo;
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
                                '${lessonInfo.id}'?? "",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleConstant
                                    .normalTextOnBackGroundColorStyle14w400.copyWith(color: ColorConst.mainColor)
                                    .copyWith(
                                  // fontSize: Dimens.size24,
                                  fontSize: ResponsiveInfo.isPhone()?Dimens.size18:Dimens.size16,
                                  // color: Color.fromRGBO(163, 20, 19, 1.0)
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Gap(Dimens.size8),
                        Text(
                          '${lessonInfo.lectureName}' ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConstant
                              .normalTextOnBackGroundColorStyle14w400
                              .copyWith(
                            // fontSize: Dimens.size24,
                            fontSize: ResponsiveInfo.isPhone()?Dimens.size18:Dimens.size16,
                            // color: Color.fromRGBO(163, 20, 19, 1.0)
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
                          itemInfo: lessonInfo,
                          onViewDetail: (p0) {
                            if(onViewDetail!=null)
                            {
                              onViewDetail!(p0);
                            }
                          },
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
