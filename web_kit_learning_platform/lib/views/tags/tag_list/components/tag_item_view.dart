import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';

class TagItemView extends StatelessWidget {
  TagItemView({
    required this.tagInfo,
    this.onViewDetail,
    this.onEdit,
    this.onDelete,
  });

  Function(TagsInfo)?onViewDetail;
  Function(TagsInfo)?onEdit;
  Function(TagsInfo)?onDelete;

  TagsInfo tagInfo;
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
                        Gap(Dimens.size6),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorConst.mainColor.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(Dimens.size40)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if(onEdit!=null) {
                                    onEdit!(tagInfo);
                                  }
                                },
                                child: Icon(Icons.edit, color: ColorConst.mainColor.withOpacity(0.5),size: Dimens.size20,),
                              ),
                            ),
                          ),
                        ),
                        
                        Gap(Dimens.size6),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorConst.mainColor.withOpacity(0.02),
                              borderRadius: BorderRadius.circular(Dimens.size40)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if(onDelete!=null) {
                                    onDelete!(tagInfo);
                                  }
                                },
                                child: Icon(Icons.delete, color: ColorConst.mainColor.withOpacity(0.5),size: Dimens.size20,),
                              ),
                            ),
                          ),
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
