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
  });

  VocabularyInfo vocabularyInfo;
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width* (ResponsiveInfo.isPhone()?1:1/5),
      constraints: BoxConstraints(
        minWidth: 330,
        maxWidth: 500
      ),
      child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) { 
        return  LayoutBuilder(builder: (context, constraints) {
          return OnHoverWidget(
            builder: (isHovered) {
              return Card(
                color: isHovered && !notifier.isDark
                    ? Color.fromRGBO(252, 173, 106, 1.0)
                    : isHovered && notifier.isDark
                    ? ColorConst.backGroundColor
                    : notifier.whitecolor,
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: isHovered && !notifier.isDark
                    // ? Color.fromRGBO(255, 243, 94, 1.0)
                        ? Color.fromRGBO(252, 173, 106, 1.0)
                        : isHovered && notifier.isDark
                        ? ColorConst.backGroundColor
                        : notifier.whitecolor,
                    borderRadius: BorderRadius.circular(16),
                  ),

                  clipBehavior: Clip.hardEdge,
                  child: Padding(
                    padding: (width > 550) ? const EdgeInsets.all(12.0) : EdgeInsets.all(4),
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            width: 2,
                            color: (isHovered) ? Colors.deepPurple : notifier.whitecolor,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 4,),
                          Text(
                            '${vocabularyInfo.name} \n' ?? "",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConstant
                                .textStyleBlack16w600
                                .copyWith(
                                fontWeight: FontWeight.bold,
                                // fontSize: Dimens.size24,
                                fontSize: ResponsiveInfo.isPhone()?Dimens.size20:Dimens.size18,
                                color: Color.fromRGBO(163, 20, 19, 1.0)),
                            maxLines: width < 550 ? 1 : 2,
                          ),
                          Gap(Dimens.size4),
                          Text(
                            vocabularyInfo.producerName??"",
                            maxLines: 1,
                            style: TextStyleConstant
                                .textStyleBlack12w400
                                .copyWith(
                              fontWeight: FontWeight.w100,

                              // fontSize: Dimens.size18,
                              fontSize: ResponsiveInfo.isPhone()?Dimens.size16: width < 1300 ? Dimens.size10 :Dimens.size15,
                              color: notifier.subgreycolor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },);
      },
      ),
    );
  }
}
