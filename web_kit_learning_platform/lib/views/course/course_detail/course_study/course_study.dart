import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webkit/base/base.export.dart';
import '../../../../helpers/theme/theme_customizer.dart';
import '../../../../helpers/utils/ui_mixins.dart';
import '../../../../services/apis/course/course_detail/models/course_detail_model.dart';
import '../../../layouts/layout.dart';
import '../../course_detail/bloc/course_detail_bloc.dart';
import 'course_study_study.dart';

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
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   ThemeCustomizer().toggleLeftBarCondensedByValue(leftBarCondensed: true);
    // });
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
          style: TextStyleConstant.textStyleBlack18w600,
        ),
        padding: EdgeInsets.zero,
        showBackButton: false,
        isScroll: false,
        child: Container(
          decoration: BoxDecoration(color: ColorConst.whiteColor),
          padding: EdgeInsets.symmetric(vertical: Dimens.size16),
          child: SafeArea(
            child: StatefulBuilder(
              builder:
                  (BuildContext context, void Function(void Function()) setState) {
                return CourseStudyStudy();
              },
            ),
          ),
        ),
      ),
    );
  }
}
