import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';

class TestItemView extends StatelessWidget {
  TestItemView({
    required this.info,
    this.onViewDetail,
    this.onEdit,
    this.onDelete,
  });

  Function(TestInfo)?onViewDetail;
  Function(TestInfo)?onEdit;
  Function(TestInfo)?onDelete;

  TestInfo info;
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
                    width: 0.2
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
                                '${info.id}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyleConstant
                                    .normalTextOnBackGroundColorStyle16w400.copyWith(
                                  // fontSize: Dimens.size24,
                                  color: ColorConst.mainColor,
                                  fontSize: ResponsiveInfo.isPhone()?Dimens.size18:Dimens.size16,
                                  //color: Color.fromRGBO(163, 20, 19, 1.0)
                                ),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ),
                        Gap(Dimens.size8),
                        Text(
                          '${info.name}' ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConstant
                              .normalTextOnBackGroundColorStyle16w400.copyWith(
                            // fontSize: Dimens.size24,
                            fontSize: ResponsiveInfo.isPhone()?Dimens.size18:Dimens.size16,
                            //color: Color.fromRGBO(163, 20, 19, 1.0)
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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

                                  if(onViewDetail!=null) {
                                    onViewDetail!(info);
                                  }
                                },
                                child: Icon(Icons.remove_red_eye, color: ColorConst.mainColor.withOpacity(0.5),size: Dimens.size20,),
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
                                  if(onEdit!=null) {
                                    onEdit!(info);
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
                                    onDelete!(info);
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
