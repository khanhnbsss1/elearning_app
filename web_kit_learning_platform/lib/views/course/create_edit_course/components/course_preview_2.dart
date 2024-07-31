import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';

import '../../../../helpers/utils/ui_mixins.dart';

class CoursePreview2 extends StatefulWidget {
  final CourseInfo courseInfo;

  const CoursePreview2({super.key, required this.courseInfo});

  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CoursePreview2> createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview2>
    with SingleTickerProviderStateMixin, UIMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Preview'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                buildTitle(),
                SizedBox(
                  height: 16,
                ),
                buildTabBar(),
                SizedBox(
                  height: 16,
                ),
                buildInfo(),
              ],
            ),
          ),
        ));
  }

  Widget buildTitle() {
    return Container(
      height: 450,
      child: Stack(
        children: [
          Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 400,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.courseInfo.image!.isNotEmpty
                      ? widget.courseInfo.image!
                      : 'assets/deshboard/adventure/adventure5.png',
                  fit: BoxFit.cover,
                  // width: constraints.maxWidth * 0.9,
                  // errorBuilder: (context, error, stackTrace) {
                  //   return Image.network(
                  //     'assets/deshboard/adventure/adventure5.png',
                  //     fit: BoxFit.cover,
                  //     // width: constraints.maxWidth * 0.9,
                  //     // height: constraints.maxWidth * 0.5,
                  //   );
                  // },
                )),
          ),
          Positioned(
            bottom: 0,
            right: (MediaQuery
                .of(context)
                .size
                .width - 16 * 2 - 800) / 2,
            child: Center(
              child: Container(
                height: 100,
                width: 800,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: (Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          MyText.titleLarge(
                            widget.courseInfo.name!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            color: ColorConst.textColor,
                          ),
                          Spacer(),
                          Row(
                            children: [
                              StarRating(
                                color: Colors.yellow,
                                allowHalfRating: true,
                                rating: widget.courseInfo.ratePoint!.toDouble(),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                  '${widget.courseInfo.ratePoint!
                                      .toDouble()} trên 5')
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ActionButton1(
                      text: 'Đăng ký ngay',
                    )
                  ],
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  int position = 0;

  Widget buildTabBar() {
    TextStyle textStyle = TextStyleConstant.textStyleBlack15w700.copyWith(
        color: (position == 0
            ? ColorConst.textColorSelectTabBar
            : ColorConst.subtext));
    return Material(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
            color: ColorConst.whiteColor,
            borderRadius: BorderRadius.circular((Dimens.size0))),
        constraints: BoxConstraints(
            minWidth: Dimens.size200 * 2, maxWidth: Dimens.size200 * 3),
        alignment: Alignment.center,
        child: TabBar(
          indicatorColor: ColorConst.mainColor,
          dividerColor: Colors.transparent,
          labelColor: ColorConst.mainColor,
          overlayColor: WidgetStateProperty.all(Colors.red),
          indicator: BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorConst.mainColor))),
          onTap: (index) {},
          tabs: [
            Tab(
              child: Container(
                height: (Dimens.size40),
                width: (Dimens.size150),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    S
                        .of(context)
                        .introduction_str,
                    style: TextStyleConstant.textStyleBlack15w700.copyWith(
                        color: position == 0
                            ? ColorConst.textColorSelectTabBar
                            : ColorConst.subtext),
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: (Dimens.size40),
                // width:(Dimens.size108),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    S
                        .of(context)
                        .content_str,
                    style: textStyle,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: (Dimens.size40),
                // width:(Dimens.size108),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    S
                        .of(context)
                        .pricing_plan_str,
                    style: textStyle,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: (Dimens.size40),
                //width:(Dimens.size108),
                alignment: Alignment.center,
                child: Center(
                  child: Text(
                    S
                        .of(context)
                        .create_quiz_str,
                    style: textStyle,
                    maxLines: 1,
                  ),
                ),
              ),
            )
          ],
          controller: tabController,
        ),
      ),
    );
  }

  Widget buildInfo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Row(
            children: [
              Expanded(
                  flex: 6,
                  child: Align(
                      alignment: Alignment.topLeft, child: buildInfoBox())),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.centerLeft, child: buildInfoCard())),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoBox() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoBoxIntroduction(),
          SizedBox(
            height: 16,
          ),
          buildInfoBoxInfoObj(),
          SizedBox(
            height: 16,
          ),
          buildInfoBoxInfoResult(),
          SizedBox(
            height: 16,
          ),
          buildInfoBoxTag(),
        ],
      ),
    );
  }

  Widget buildInfoBoxIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giới thiệu khóa học: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Text('${widget.courseInfo.introduction}'),
      ],
    );
  }

  Widget buildInfoBoxInfoObj() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Khóa học này dành cho: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (widget.courseInfo.infoResult == null) ? Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) =>
                        Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: 24,),
                            Text('lí do $index')
                          ],
                        )
                ),
              ) : Text('${widget.courseInfo.infoResult}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInfoBoxInfoResult() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bạn nhận được gì sau khóa học này:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              (widget.courseInfo.infoResult == null) ? Flexible(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) =>
                        Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: 24,),
                            Text('lí do $index')
                          ],
                        )
                ),
              ) : Text('${widget.courseInfo.infoResult}'),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildInfoBoxTag() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('data'),
      ],
    );
  }

  Widget buildInfoCard() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        constraints: BoxConstraints(
          maxWidth: 450,
        ),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  (widget.courseInfo.videoPreview == null)
                      ? 'assets/deshboard/adventure/adventure5.png'
                      : widget.courseInfo.videoPreview!,
                  fit: BoxFit.fill,
                )),
          ],
        ),
      ),
    );
  }
}
