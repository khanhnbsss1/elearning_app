import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/table_common/animation/animation.exports.dart';
import 'package:webkit/landing_page/components/colornotifier.dart';
import 'package:webkit/services/apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';
import 'package:webkit/widgets/item_edit_view_delete/item_edit_view_delete.dart';

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
                    width: 0.3
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
                          .normalTextOnBackGroundColorStyle16w400
                          .copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: ResponsiveInfo.isPhone()?Dimens.size20:Dimens.size18,),
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ItemViewEditDelete(
                          itemInfo: vocabularyInfo,
                          enableView: false,
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
