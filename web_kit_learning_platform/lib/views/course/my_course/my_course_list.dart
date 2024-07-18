import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/apps/contact/member_list_controller.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_responsiv.dart';
import 'package:webkit/views/course/course_detail/course_detail.dart';
import 'package:webkit/views/course/course_list/bloc/course_list_bloc.dart';
import 'package:webkit/views/course/course_list/course_list.dart';
import '../../../helpers/theme/app_style.dart';
import '../../../helpers/widgets/course_item_grid_view.dart';
import '../../../helpers/widgets/my_button.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';
import '../../../services/apis/course/course_list/models/course_models.dart';
import '../../layouts/layout.dart';
import 'bloc/my_course_list_bloc.dart';

class MyCourseList extends CourseList{
  MyCourseList({super.key}):super(courseType: CourseType.myCourseList);
}
