import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';

class CourseIntro extends StatelessWidget{
  late CourseDetailState _state;
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  buildInfo(context);
  }
  
  Widget buildInfo(BuildContext context) {
    return BlocConsumer<CourseDetailBloc, CourseDetailState>(
        listener: (context, state) {
          switch (state.blocStatus) {
            case AddCourseStatus.initial:
              break;
            default:
              break;
          }
        },
        builder: (BuildContext context, state) {
          _state = state;
          return MyResponsive(builder: (buildContext , constraints , myScreenMediaType ) { 
            return SingleChildScrollView(
              controller: controller,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: constraints.maxWidth> 800?Row(
                  children: [
                    Expanded(child: buildInfoBox(context)),
                    SizedBox(
                      width: Dimens.size400,
                      child: buildInfoCard()),
                  ],
                ):
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildInfoBox(context),
                    buildInfoCard()
                  ],
                ),
              ),
            );
          },
          );
        });
  }
  Widget buildInfoBox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildInfoBoxIntroduction(),
          SizedBox(
            height: 16,
          ),
          Divider(color: ColorConst.dividerColor,),
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
    );
  }
  Widget buildInfoBoxIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 16,
        ),
        Text('${_state.courseInfo?.introduction}'),
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
          child: (_state.courseInfo?.infoResult != null)
              ? ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: _state.courseObject?.length,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(child: Text((_state.courseObject??[])[index], maxLines: 5,))
                ],
              ))
              : Text('${_state.courseInfo?.infoResult}'),
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
          child: (_state.courseInfo?.infoResult != null)
              ? ListView.builder(
              shrinkWrap: true,
              controller: controller,
              itemCount: _state.courseResult?.length,
              itemBuilder: (context, index) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  Expanded(child: Text((_state.courseResult??[])[index], maxLines: 5,))
                ],
              ))
              : Text('${_state.courseInfo?.infoResult}'),
        ),
      ],
    );
  }

  Widget buildInfoBoxTag() {
    final tags = _state.courseInfo?.tags;
    try {
      print(_state.courseInfo?.lectures?.first);
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
                        (_state.courseInfo?.image??'').isEmpty ? 'assets/deshboard/adventure/adventure5.png' : _state.courseInfo?.image??"",
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'assets/deshboard/adventure/adventure5.png',
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return SizedBox();
                            },
                          );
                        },
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
                            Text(_state.courseInfo?.gradeName ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(_state.courseInfo?.producerName ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text(_state.courseInfo?.durian ?? '-'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${_state.courseInfo?.totalSubjects} chủ đề, ${_state.courseInfo?.totalLectures} bài học'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${_state.courseInfo?.isStandard ?? '0'}'),
                            SizedBox(
                              height: 8,
                            ),
                            Text('${_state.courseInfo?.id ?? '0'}'),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black.withOpacity(0.1))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Text(
                            '${_state.courseInfo?.payment??0 / 0.8} VND',
                            style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black45, fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            '${_state.courseInfo?.payment!} VND',
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
                            text: L10nX.getStr.register_now,
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

}