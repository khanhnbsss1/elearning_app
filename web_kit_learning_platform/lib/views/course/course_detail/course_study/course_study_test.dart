import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../course_detail/bloc/course_detail_bloc.dart';

class CourseStudyTest extends StatefulWidget {

  const CourseStudyTest();

  @override
  State<CourseStudyTest> createState() => _CourseStudyTestState();
}

class _CourseStudyTestState extends State<CourseStudyTest> {
  late CourseDetailState _state;

  @override
  Widget build(BuildContext context) {
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
        return Placeholder();
      },
    );

    return const Placeholder();
  }
}
