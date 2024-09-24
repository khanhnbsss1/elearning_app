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
        buildWhen: (previous, current) {
          return current.blocStatus != AddCourseStatus.onChangeRating &&
              current.blocStatus != AddCourseStatus.getRatingList &&
              current.blocStatus != AddCourseStatus.onSubmitRating;
        },
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
              return Column(
                children: [
                  Gap(Dimens.size50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        L10nX.getStr.lesson_list,
                        style: TextStyleConstant.textStyleBlack20w700,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Divider(color: ColorConst.dividerColor,),
                  buildSubjectList(state: state),
                ],
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
              padding: EdgeInsets.symmetric( vertical: Dimens.size16),
              margin: EdgeInsets.symmetric(horizontal: Dimens.size32),
              decoration: BoxDecoration(
                  //border: Border(bottom: BorderSide(color: ColorConst.dividerColor, ))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("-"),
                  Gap(Dimens.size10),
                  Text('${L10nX.getStr.lecture_str} $lessonIndex: ${lessonInfo.lectureName}'.trim(), style: TextStyleConstant.textStyleBlack14w400,),
                ],
              ),
            )
        );
      }
    return ExpandWidget(
      title: '${L10nX.getStr.subject_str} ${subjectIndex.toString()}: ${subjects.subName}',
      enablePrefixExpand: true,
      enableSubfixExpand: false,
      expandColor: Color(0x00ff0000),
      titleExpandColor: ColorConst.mainColor,
      borderColor: ColorConst.colorIconGrays.withOpacity(0.1),
      enableDivider: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: ColorConst.dividerColor))
            ),
            child: Column(
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:listLesson,
          ),
        ],
      ),
    );
  }
}