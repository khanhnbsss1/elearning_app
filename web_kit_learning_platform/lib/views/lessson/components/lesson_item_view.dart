import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';

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
                    Text(
                      '${lessonInfo.id}. ${lessonInfo.lectureName} \n' ?? "",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            if(onViewDetail!=null)
                              {
                                onViewDetail!(lessonInfo);
                              }
                          },
                          child: Icon(Icons.remove_red_eye, color: ColorConst.colorIconGrays.withOpacity(0.5),size: Dimens.size20,),
                        ),
                        Gap(Dimens.size6),
                        InkWell(
                          onTap: () {
                            if(onEdit!=null)
                            {
                              onEdit!(lessonInfo);
                            }
                          },
                          child: Icon(Icons.edit, color: ColorConst.colorIconGrays.withOpacity(0.5),size: Dimens.size20,),
                        ),
                        Gap(Dimens.size6),
                        InkWell(
                          onTap: () {
                            if(onDelete!=null)
                            {
                              onDelete!(lessonInfo);
                            }
                          },
                          child: Icon(Icons.delete, color: ColorConst.colorIconGrays.withOpacity(0.5),size: Dimens.size20,),
                        ),
                        Gap(Dimens.size6),
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
