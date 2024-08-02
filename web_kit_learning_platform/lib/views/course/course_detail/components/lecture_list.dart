import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/widgets/expands/expand_widget.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/topic/model/topic_info.dart';
import 'package:webkit/views/course/course_detail/bloc/course_detail_bloc.dart';

class LectureList extends StatelessWidget{
  late CourseDetailState _state;
  List<bool> showLecture = List.filled(3, false, growable: true);

  int lessonIndex=0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
          return StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(Dimens.size50),
                    Text(
                      L10nX.getStr.lesson_list,
                      style: TextStyleConstant.textStyleBlack20w700,
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
                                          (!showLecture[index]) ? Icon(Icons.add) : Icon(Icons.horizontal_rule_outlined),
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
                                        margin: EdgeInsets.only(left: 32, top: 16, bottom: 16),
                                        child: Text('Lecture $index: Lecture $lectureIndex name'),
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
            },
          );
        });
  }
  
  Widget buildSubjectList({required CourseDetailState state}){
    
    List<Widget>listSubject = [];
    int index =0;
    for(Subjects subjects in state.courseInfo?.getListSubjectAndLesson()??[])
      {
        index++;
        listSubject.add(buildSubjectItem(subjects:subjects, subjectIndex: index));
      }
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: listSubject,
      ),
    );
  }
  
  Widget buildSubjectItem({required Subjects subjects, required int subjectIndex}){
    List<Widget>listLesson = [];
    for(LessonInfo lessonInfo in subjects.lectures??[])
      {
        lessonIndex ++;
        listLesson.add(
            Container(
              margin: EdgeInsets.only(left: 32, top: 16, bottom: 16),
              child: Text('${L10nX.getStr.lecture_name_str} $lessonIndex: ${lessonInfo.lectureName}'),
            )
        );
      }
    return ExpandWidget(
      title: '${L10nX.getStr.subject_name_str} ${subjectIndex.toString()}: ${subjects.subName}',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:listLesson,
      ),
    );
  }
}