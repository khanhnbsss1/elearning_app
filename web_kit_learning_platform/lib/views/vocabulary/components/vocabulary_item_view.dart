import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';

class VocabularyItemView extends StatelessWidget {
  
  VocabularyItemView({
    required this.vocabularyInfo,
    this.onViewDetail,
    this.onEdit,
    this.onDelete,
  });

  Function(VocabularyInfo)?onViewDetail;
  Function(VocabularyInfo)?onEdit;
  Function(VocabularyInfo)?onDelete;
  VocabularyInfo vocabularyInfo;
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
                    ? Color.fromRGBO(252, 173, 106, 1.0)
                    : isHovered && notifier.isDark
                    ? ColorConst.backGroundColor
                    : notifier.whitecolor,
                border: Border(
                  bottom: BorderSide(
                    color: ColorConst.dividerColor,
                    width: 1
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
                      '${vocabularyInfo.simplified} \n' ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConstant
                          .textStyleBlack16w600
                          .copyWith(
                          fontWeight: FontWeight.bold,
                          // fontSize: Dimens.size24,
                          fontSize: ResponsiveInfo.isPhone()?Dimens.size20:Dimens.size18,
                          color: Color.fromRGBO(163, 20, 19, 1.0)),
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Gap(Dimens.size6),
                            InkWell(
                              onTap: () {
                                if(onViewDetail!=null)
                                {
                                  onViewDetail!(vocabularyInfo);
                                }
                              },
                              child: Icon(Icons.remove_red_eye, color: ColorConst.colorIconGrays.withOpacity(0.5),size: Dimens.size15,),
                            ),
                            Gap(Dimens.size6),
                            InkWell(
                              onTap: () {
                                if(onEdit!=null)
                                {
                                  onEdit!(vocabularyInfo);
                                }
                              },
                              child: Icon(Icons.edit, color: ColorConst.colorIconGrays.withOpacity(0.5),size: Dimens.size15,),
                            ),
                            Gap(Dimens.size6),
                            InkWell(
                              onTap: () {
                                if(onDelete!=null)
                                {
                                  onDelete!(vocabularyInfo);
                                }
                              },
                              child: Icon(Icons.delete, color: ColorConst.colorIconGrays.withOpacity(0.5),size: Dimens.size15,),
                            ),
                            Gap(Dimens.size6),
                          ],
                        )
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
