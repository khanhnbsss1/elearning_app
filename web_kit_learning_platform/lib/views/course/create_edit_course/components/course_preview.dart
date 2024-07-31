import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/widgets/my_tab_indicator_style.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';

import '../../../../helpers/utils/ui_mixins.dart';
import '../../../../services/apis/course/course_detail/models/course_detail_model.dart';

class CoursePreview extends StatefulWidget {
  final CourseInfo courseInfo;

  const CoursePreview({super.key, required this.courseInfo,});

  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CoursePreview> createState() => _CourseStudyState();
}

class _CourseStudyState extends State<CoursePreview>
    with SingleTickerProviderStateMixin, UIMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  final List<String> courseObject = [
    'Dành cho các bạn mới học Tiếng Trung',
    'Dành cho các bạn tự học Tiếng Trung nhưng không hiệu quả',
    'Dành cho các bạn đã từng học Tiếng Trung nhưng mất gốc và quên kiến thức',
    'Dành cho các bạn có nhu cầu sử dụng Tiếng Trung cơ bản trong giao tiếp thường ngày'
  ];

  final List<String> courseResult = [
    'Bạn nhận được gì sau khóa học này?',
    'Nắm được 500 từ vựng cơ bản, 400 từ vựng mở rộng, 100 cấu trúc ngữ pháp thông dụng',
    'Sử dụng thành thạo Tiếng Trung ở mức cơ bản, giao tiếp được các chủ đề trong cuộc sống và công việc',
    'Bắt đầu dịch được những văn bản, video cơ bản bằng Tiếng Trung',
    'Thêm điểm cộng khi tham gia phỏng vấn',
    'Đủ năng lực thi được chứng chỉ Tiếng Trung sơ cấp',
    'Đủ năng lực thi Tiếng Trung tốt nghiệp THPT hoặc xét tuyển đại học'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                  height: 500,
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      buildInfo(),
                      buildLectureList(),
                      Text("It's sunny here"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildTitle() {
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          SizedBox(
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
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.6,
                constraints: BoxConstraints(
                  maxWidth: 800,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.black.withOpacity(0.1),
                  ),
                  borderRadius: BorderRadius.circular(16),
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
                              // SizedBox(
                              //   width: 4,
                              // ),
                              // Text(
                              //     '${widget.courseInfo.ratePoint!.toDouble()} trên 5')
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    ActionButton1(
                      text: 'Đăng ký ngay',
                    ),
                    SizedBox(
                      width: 16,
                    ),
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
    return Center(
      child: Card(
        elevation: 5,
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.5,
          constraints: BoxConstraints(
            maxWidth: 800,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: TabBar(
            indicatorColor: ColorConst.mainColor,
            dividerColor: Colors.transparent,
            labelColor: ColorConst.mainColor,
            indicator: BoxDecoration(
                border:
                Border(bottom: BorderSide(color: ColorConst.mainColor))),
            splashBorderRadius: BorderRadius.circular(12),
            overlayColor:
            WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
            dividerHeight: 0,
            controller: tabController,
            tabs: [
              Tab(text: 'Introduction'),
              Tab(text: 'Content'),
              Tab(text: 'Test'),
            ],
          ),
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
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
// SizedBox(
//   height: 16,
// ),
// buildInfoRelatedCourse(),
          ],
        ),
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

  List<bool> showLecture = List.filled(3, false, growable: true);
  int tappedIndex = -1;

  Widget buildLectureList() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danh sách bài học: ',
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Card(
                          elevation: 5,
                          child: Container(
                            margin: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                (!showLecture[index])
                                    ? Icon(Icons.add)
                                    : Icon(Icons.horizontal_rule_outlined),
                                SizedBox(
                                  width: 4,
                                ),
                                Text('Subject $index: Subject $index name'),
                                Spacer(),
                                Checkbox(
                                  value: false,
                                  onChanged: (bool? value) {
                                    value = !value!;
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          showLecture[index] = !showLecture[index];
                        });
                      },
                    ),
                    AnimatedSize(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(milliseconds: 200),
                      child: showLecture[index]
                          ? Container(
                        margin: EdgeInsets.all(16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, lectureIndex) {
                            return Container(
                              margin: EdgeInsets.only(
                                  left: 32, top: 16, bottom: 16),
                              child: Text(
                                  'Lecture $index: Lecture $lectureIndex name'),
                            );
                          },
                        ),
                      )
                          : SizedBox(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
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
          child: (widget.courseInfo.infoResult == null)
              ? ListView.builder(
              shrinkWrap: true,
              itemCount: courseObject.length,
              itemBuilder: (context, index) =>
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(courseObject[index])
                    ],
                  ))
              : Text('${widget.courseInfo.infoResult}'),
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
          child: (widget.courseInfo.infoResult == null)
              ? ListView.builder(
              shrinkWrap: true,
              itemCount: courseResult.length,
              itemBuilder: (context, index) =>
                  Row(
                    children: [
                      Icon(
                        Icons.check,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Text(courseResult[index])
                    ],
                  ))
              : Text('${widget.courseInfo.infoResult}'),
        ),
      ],
    );
  }

  Widget buildInfoBoxTag() {
    final tags = widget.courseInfo.tags;
    try {
      print(widget.courseInfo.lectures?.first);
    } catch (e) {
      print(e);
    }
    if (tags == null || tags.isEmpty) {
      return const Text(
        "Tags: No tags",
        style: TextStyle(fontSize: 14),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Tags:   ",
            style: const TextStyle(fontSize: 16),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: tags.map((tag) {
                return Row(
                  children: [
                    Text(
                      tag.name ?? "Unnamed tags",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                  ],
                );
              }).toList(),
            ),
          )
        ],
      );
    }
  }

// Widget buildInfoRelatedCourse() {
//
// }

  Widget buildInfoCard() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                )),
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                  SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Phân loại:'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Tác giả: '),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Thời lượng: '),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Nội dung: '),
                            SizedBox(
                              height: 8,
                            ),
                            Text('Chính quy: '),
                            SizedBox(
                              height: 8,
                            ),
                            Text('ID: '),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.courseInfo.gradeName ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(widget.courseInfo.producerName ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(widget.courseInfo.durian ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                                '${widget.courseInfo
                                    .totalSubjects} chủ đề, ${widget.courseInfo
                                    .totalLectures} bài học'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${widget.courseInfo.isStandard ?? '0'}'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${widget.courseInfo.id ?? '0'}'),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '${widget.courseInfo.payment! / 0.8} VND',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.black45,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${widget.courseInfo.payment!} VND',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFFFC711),
                                fontStyle: FontStyle.italic,
                                color: Color(0xFFFFC711),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          ActionButton1(
                            text: 'Đăng ký ngay',
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStudy() {
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
                      alignment: Alignment.topLeft,
                      child: buildStudySection())),
              Expanded(
                  flex: 4,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: buildLectureList())),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStudySection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoBoxIntroduction(),
          ],
        ),
      ),
    );
  }
}
