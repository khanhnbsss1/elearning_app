import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/views/course/course_study/course_study_introduction.dart';
import 'package:webkit/views/course/course_study/course_study_study.dart';
import 'package:webkit/views/course/course_study/course_study_test.dart';
import 'package:webkit/views/course/create_edit_course/components/build_tab_bar.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../layouts/layout.dart';
import '../course_detail/bloc/course_detail_bloc.dart';

class CourseStudy1 extends StatefulWidget {
  final CourseInfo courseInfo;

  const CourseStudy1({
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
  State<CourseStudy1> createState() => _CourseStudyState();
}

class _CourseStudyState extends State<CourseStudy1>
    with SingleTickerProviderStateMixin, UIMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return CourseDetailBloc(CourseDetailState(courseInfo: widget.courseInfo))
          ..add(CourseDetailInitEvent());
      },
      child: Layout(
        title: Text(
          widget.courseInfo.name??'',
          style: TextStyleConstant.textStyleBlack20w700,
        ),
        padding: EdgeInsets.zero,
        showBackButton: true,
        isScroll: false,
        child: Container(
          decoration: BoxDecoration(color: ColorConst.whiteColor),
          padding: EdgeInsets.only(
              top: Dimens.size50,
              bottom: Dimens.size16,
              left: Dimens.size16,
              right: Dimens.size16),
          child: StatefulBuilder(
            builder:
                (BuildContext context, void Function(void Function()) setState) {
              return BuildTabBar(
                widgets: const [
                  CourseStudyIntroduction(),
                  CourseStudyStudy(),
                  CourseStudyTest(),
                ],
                titles: const ['Introduction', 'Study', 'Test'],
              );
            },
          ),
        ),
      ),
    );
  }
}
