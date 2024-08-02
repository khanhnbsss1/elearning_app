import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/views/course/create_edit_course/components/build_tab_bar.dart';

import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../services/apis/course/course_detail/models/course_detail_model.dart';

class CourseStudy extends StatefulWidget {
  final CourseInfo courseInfo;

  const CourseStudy({
    super.key,
    required this.courseInfo,
  });

  void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => this,
    );
  }

  @override
  State<CourseStudy> createState() => _CourseStudyState();
}

class _CourseStudyState extends State<CourseStudy>
    with SingleTickerProviderStateMixin, UIMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    likeCheck = List.filled(reviewCount, false);
    dislikeCheck = List.filled(reviewCount, false);
    showReply = List.filled(reviewCount, false);
    checkLecture = List.generate(subjectCount, (index) => List.filled(lectureCount, false));
    showSubject = List.filled(
      subjectCount,
      false,
    );
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
        title: Text(S.of(context).lets_study),
        centerTitle: true,
      ),
      body: BuildTabBar(
        widgets: [
          buildInfo(),
          buildStudy(),
          buildTest(),
        ],
        titles: ['Introduction', 'Study', 'Test'],
      ),
    );
  }

  int position = 0;

  Widget buildInfo() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
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
            buildTitle(),
            SizedBox(
              height: 16,
            ),
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

  Widget buildTitle() {
    return SizedBox(
      height: 450,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.courseInfo.image!.isNotEmpty
                  ? widget.courseInfo.image!
                  : 'assets/deshboard/adventure/adventure5.png',
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget buildStudyVideo() {
    return SizedBox(
      height: 450,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 400,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              widget.courseInfo.image!.isNotEmpty
                  ? widget.courseInfo.image!
                  : 'assets/deshboard/adventure/adventure5.png',
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget buildStudyTitle() {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.courseInfo.name!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: ColorConst.textColor,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  'Giảng viên: ${widget.courseInfo.producerName!}',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: ColorConst.textColor,
                  ),
                ),
                Spacer(),
                StarRating(
                  color: Colors.yellow,
                  allowHalfRating: true,
                  rating: widget.courseInfo.ratePoint!.toDouble(),
                ),
              ],
            ),
          ],
        ),
      ],
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

  List<bool> showSubject = [];
  List<List<bool>> checkLecture = [[]];
  int subjectCount = 4;
  int lectureCount = 3;

  double _checkProgression({required int subjectIndex}) {
    int finished = 0;
    for (bool check in checkLecture[subjectIndex].toList()) {
      if (check) finished++;
    }
    return finished / checkLecture[subjectIndex].length;
  }

  Widget buildLectureList() {
    for (int i = 0; i < subjectCount; i++) {
      for (int j = 0; j < lectureCount; j++) {
        print('=======  ${checkLecture[i][j]} $i  $j');
      }
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: subjectCount,
              itemBuilder: (context, subjectIndex) {
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Subject $subjectIndex: Subject $subjectIndex name',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32.0),
                                      child: Row(
                                        children: [
                                          Text('Tiến độ: '),
                                          Align(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              height: 20,
                                              constraints: BoxConstraints(
                                                minWidth: 50,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Stack(children: [
                                                Positioned(
                                                  left: 0,
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width * 0.2 * _checkProgression(subjectIndex: subjectIndex),
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.circular(20),
                                                    ),
                                                  ),
                                                ),
                                                Center(child: Text('${( _checkProgression(subjectIndex: subjectIndex) * 100).floor()} %', style: TextStyle(color: Colors.white),)),
                                              ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                (!showSubject[subjectIndex])
                                    ? Icon(
                                        Icons.arrow_drop_down,
                                        size: 32,
                                      )
                                    : Icon(Icons.arrow_drop_up, size: 32),
                                SizedBox(
                                  width: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          showSubject[subjectIndex] =
                              !showSubject[subjectIndex];
                        });
                      },
                    ),
                    AnimatedSize(
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(milliseconds: 200),
                      child: showSubject[subjectIndex]
                          ? Container(
                              margin: EdgeInsets.all(16),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: lectureCount,
                                itemBuilder: (context, lectureIndex) {
                                  return Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: 32,
                                            top: 16,
                                            bottom: 16,
                                            right: 32),
                                        child: Row(
                                          children: [
                                            Text(
                                                'Subject $subjectIndex: Lecture $lectureIndex name'),
                                            Spacer(),
                                            InkWell(
                                              onTap: () {
                                                print('Subject $subjectIndex: Lecture $lectureIndex name');
                                                setState(() {
                                                  // print(_checkProgression(subjectIndex: subjectIndex));
                                                  // print('   ');
                                                  // print(subjectIndex);
                                                  // print('$subjectIndex   $lectureIndex  ${checkLecture[subjectIndex][lectureIndex]} ');

                                                  checkLecture[subjectIndex][lectureIndex] = !checkLecture[subjectIndex][lectureIndex];
                                                });
                                              },
                                              child: Container(
                                                width: 24,
                                                height: 24,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                  color: Colors.red,
                                                )),
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child:
                                                      checkLecture[subjectIndex][lectureIndex]
                                                          ? Icon(
                                                              Icons.check,
                                                              color: Colors.red,
                                                            )
                                                          : SizedBox(),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Divider(
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                      )
                                    ],
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
                  itemBuilder: (context, index) => Row(
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
                  itemBuilder: (context, index) => Row(
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
                                '${widget.courseInfo.totalSubjects} chủ đề, ${widget.courseInfo.totalLectures} bài học'),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Expanded(
                flex: 6,
                child: Align(
                    alignment: Alignment.topLeft, child: buildStudySection())),
            Expanded(
                flex: 4,
                child: Align(
                    alignment: Alignment.topCenter, child: buildLectureList())),
          ],
        ),
      ),
    );
  }

  Widget buildStudySection() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStudyVideo(),
            buildStudyTitle(),
            SizedBox(
              height: 16,
            ),
            BuildTabBar(
              widgets: [
                buildStudyOverview(),
                buildStudyReview(),
                buildStudyQuiz(),
              ],
              titles: const ['Overview', 'Review', 'Quiz'],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStudyOverview() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            'Introduction: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('${widget.courseInfo.introduction}'),
          SizedBox(
            height: 16,
          ),
          Text(
            'Tài liệu: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('Chưa lấy dữ liệu'),
          SizedBox(
            height: 16,
          ),
          Text(
            'Danh sách từ vựng',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 500,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return buildWordItem(
                      index: index,
                      simplified: '吃',
                      pinyin_tones: 'chī',
                      translation_vn: 'ăn',
                      audio: '');
                }),
          )
        ],
      ),
    );
  }

  Widget buildWordItem(
      {required int index,
      required String simplified,
      required String pinyin_tones,
      required String translation_vn,
      required String audio}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Text('$index.'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$pinyin_tones'),
                  Row(
                    children: [
                      // Text('$index.'),
                      Text('$simplified : '),
                      Text('$translation_vn'),
                      SizedBox(
                        width: 16,
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.volume_up)),
                    ],
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.remove_red_eye_outlined)),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Divider(
          color: Colors.black.withOpacity(0.2),
        ),
        SizedBox(
          height: 4,
        ),
      ],
    );
  }

  Review review = Review(
    username: 'username 1',
    text: '',
    rating: 5,
    likeCount: 0,
    dislikeCount: 0,
    avatar: null,
  );

  List<Review> listOfReview = [];

  int reviewCount = 10;

  Widget buildStudyReview() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '4 Reviews',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 16,
          ),
          buildStudyReviewItemUser(replyCheck: false),
          SizedBox(
            height: 500,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: reviewCount,
                itemBuilder: (context, index) {
                  listOfReview.add(
                    Review(
                      username: 'username $index',
                      text: 'review $index',
                      rating: 5,
                      likeCount: 0,
                      dislikeCount: 0,
                      avatar: null,
                    ),
                  );
                  return Column(
                    children: [
                      buildStudyReviewItem(
                          review: listOfReview[index], index: index),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget buildStudyReviewItemUser({required bool replyCheck}) {
    double _rating = 5;
    TextEditingController controller = TextEditingController();
    final List<String> menuItems = ['Item 1', 'Item 2', 'Item 3'];
    bool check = false;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: !replyCheck,
          child: Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 60, maxHeight: 60),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(Icons.face),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Rate and comment',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    StarRating(
                      rating: _rating,
                      onRatingChanged: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
                Stack(children: [
                  TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: replyCheck ? 'Trả lời...' : 'Bình luận...',
                      alignLabelWithHint: true,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      // prefixIcon: const Icon(
                      //   LucideIcons.lock,
                      //   size: 20,
                      // ),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                    minLines: 3,
                    maxLines: 6,
                    onChanged: (value) {
                      // setState(() {
                      //   controller.text = value;
                      //   (controller.text.isEmpty) ? check = false : check = true;
                      // });
                    },
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: PopupMenuButton<String>(
                        icon: Icon(Icons.tag_faces),
                        onSelected: (value) {
                          controller.text += value;
                        },
                        itemBuilder: (context) {
                          return menuItems.map((item) {
                            return PopupMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList();
                        }),
                  )
                ]),
                Visibility(
                  visible: !check,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: ActionButton1(
                      text: replyCheck ? 'Trả lời' : 'Bình luận',
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  List<bool> likeCheck = [];
  List<bool> dislikeCheck = [];
  List<bool> showReply = [];

  Widget buildStudyReviewItem({required Review review, required int index}) {
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 60, maxHeight: 60),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Icon(Icons.face),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        review.username,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      StarRating(
                        rating: review.rating,
                        size: 16,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: Text(
                      review.text,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.thumb_up_alt_rounded,
                          color: (likeCheck[index]) ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            likeCheck[index] = !likeCheck[index];
                            (likeCheck[index])
                                ? review.likeCount++
                                : review.likeCount--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('${review.likeCount}'),
                      SizedBox(
                        width: 16,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.thumb_down_alt_rounded,
                          color:
                              (dislikeCheck[index]) ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            dislikeCheck[index] = !dislikeCheck[index];
                            (dislikeCheck[index])
                                ? review.dislikeCount++
                                : review.dislikeCount--;
                          });
                        },
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('${review.dislikeCount}'),
                      SizedBox(
                        width: 32,
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              showReply = List.filled(reviewCount, false);
                              showReply[index] = !showReply[index];
                            });
                          },
                          child: Text('Reply')),
                    ],
                  ),
                  Visibility(
                      visible: showReply[index],
                      child: Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Container(
                              // width: MediaQuery.of(context).size.width,
                              child:
                                  buildStudyReviewItemUser(replyCheck: true))))
                ],
              )),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Divider(
          color: Colors.black.withOpacity(0.1),
        ),
      )
    ]);
  }

  Future<UserProfile?> getProfile() async {
    UserProfile? userInfo = await UserManager().getUserProfile();
    return userInfo;
  }

  Widget buildStudyQuiz() {
    return SizedBox();
  }

  Widget buildTest() {
    return Placeholder();
  }
}

class Review {
  final String username;
  final String text;
  final double rating;
  int likeCount;
  int dislikeCount;
  final Image? avatar;

  Review({
    required this.username,
    required this.text,
    required this.rating,
    required this.likeCount,
    required this.dislikeCount,
    required this.avatar,
  });
}
