import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/services/apis/course/add_course/add_course_api.dart';
import 'package:webkit/services/apis/course/course_list/models/course_models.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_api.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_model.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';
part 'add_course_event.dart';
part 'add_course_state.dart';

class AddCourseBloc extends Bloc<AddCourseEvent, AddCourseState> {
  AddCourseBloc(super.initialState) {
    on<AddCourseInitEvent>(_onInit);
    on<AddCourseSubmitAddEvent>(_onAddCourse);
    on<AddCourseSubmitUpdateEvent>(_onUpdateCourse);
    on<AddCourseUploadImageEvent>(_onUploadImage);
    on<AddCourseUploadVideoPreViewEvent>(_onUploadVideoPreview);
    on<AddCourseLinkDiscountEvent>(_onLinkDiscount);
    on<AddCourseLinkLessonEvent>(_onLinkLesson);

    on<AddCourseUpdateControllerEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
        blocStatus: AddCourseStatus.onUpdateController,
        controller: event.addCourseController
      ));
    });
  }

  Future<void> _onInit(
      AddCourseInitEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onLoading
    ));
    state.controller?.basicValidator.getController('course_mode')?.text = state.courseInfo?.courseMode??'FREE';
    state.controller?.basicValidator.getController('is_standard')?.text = (state.courseInfo?.isStandard??0).toString();
    state.controller?.basicValidator.getController('id')?.text =( state.courseInfo?.id??0).toString();
    state.controller?.basicValidator.getController('total_lectures')?.text = (state.courseInfo?.totalLectures??0).toString();
    state.controller?.basicValidator.getController('total_subjects')?.text = (state.courseInfo?.totalSubjects??0).toString();
    state.controller?.basicValidator.getController('payment')?.text = (state.courseInfo?.payment??0).toString();
    state.controller?.basicValidator.getController('rate_point')?.text = (state.courseInfo?.ratePoint??0).toString();
    state.controller?.basicValidator.getController('category_id')?.text = (state.courseInfo?.categoryId??0).toString();
    state.controller?.basicValidator.getController('is_active')?.text = (state.courseInfo?.isActive??0).toString();
    state.controller?.basicValidator.getController('language')?.text = state.courseInfo?.language??'CN';

    state.controller?.basicValidator.getController('name')?.text = state.courseInfo?.name??'jooko';
    state.controller?.basicValidator.getController('image')?.text = state.courseInfo?.image??'';
    state.controller?.basicValidator.getController('introduction')?.text = state.courseInfo?.introduction??'';
    state.controller?.basicValidator.getController('grade_name')?.text = state.courseInfo?.gradeName??'';
    state.controller?.basicValidator.getController('producer_name')?.text = state.courseInfo?.producerName??'';
    state.controller?.basicValidator.getController('category_name')?.text = state.courseInfo?.categoryName??'';
    state.controller?.basicValidator.getController('video_preview')?.text = state.courseInfo?.videoPreview??'';
    state.controller?.basicValidator.getController('info_obj')?.text = state.courseInfo?.infoObj??'';
    state.controller?.basicValidator.getController('info_result')?.text = state.courseInfo?.infoResult??'';
    state.controller?.basicValidator.getController('accompany_course')?.text = state.courseInfo?.accompanyCourse??'';

    GetAddCourseFilterApi addCourseFilterApi = GetAddCourseFilterApi();
    GetAddCourseFilterModel addCourseFilterModel = await addCourseFilterApi.call();
    addCourseFilterModel.data?.forEach((data) {
      switch (data.filterType) {
        case 'CATEGORY':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfCategoryName.containsValue(e.name!)) {
              state.controller!.listOfCategoryName[e.id!] = e.name!;
            }
          });
          break;
        case 'AUTHOR':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfProduceNames.containsValue(e.name!)) {
              state.controller!.listOfProduceNames[e.id!] = e.name!;
            }
          });
          break;
        case 'GRADE':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfGradeNames.containsValue(e.name!)) {
              state.controller!.listOfGradeNames[e.id!] = e.name!;
            }
          });
          break;
        case 'ACCOMPANY':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfAccompanyCourses.containsValue(e.name!)) {
              state.controller!.listOfAccompanyCourses[e.id!] = e.name!;
            }
          });
          break;
        case 'TAG':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfTags.containsValue(e.name!)) {
              state.controller!.listOfTags[e.id!] = e.name!;
            }
          });
        case 'DISCOUNT':
          data.subFilter!.where((e) => e.name != null).forEach((e) {
            if (!state.controller!.listOfDiscounts.containsValue(e.name!)) {
              state.controller!.listOfDiscounts[e.id!] = e.name!;
            }
          });
          break;
        default:
          break;
      }
    });

    emit(state.copyWith(
        addCourseFilterModel: addCourseFilterModel,
        blocStatus:  AddCourseStatus.initial,
      controller: state.controller
    ));
  }
  

  Future<void> _onUpdateCourse(
      AddCourseSubmitUpdateEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    emit(state.copyWith(
      controller: event.addCourseController,
      blocStatus:  AddCourseStatus.onLoading,
    ));
    
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onSubmitUpdate
    ));
  }
  Future<void> _onAddCourse(
      AddCourseSubmitAddEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    emit(state.copyWith(
      controller: event.addCourseController,
        blocStatus:  AddCourseStatus.onLoading
    ));
    MonitorLoading().showLoading("");
    CourseInfo? courseInfo = await state.controller?.getCourseInfoFromUI(courseInfo: state.courseInfo!);
    courseInfo = courseInfo?.copyWith(
      image: state.courseInfo?.image,
      videoPreview: state.courseInfo?.videoPreview
    );
    AddCourseApi addCourseApi = AddCourseApi(addCourseRequest: courseInfo!);
    dynamic data = await addCourseApi.call();
    MonitorLoading().dismiss();
    if(data.runtimeType==int)
    {
      courseInfo.id = data as int;
      ToastUtils.showToastSuccess(L10nX.getStr.success);
    }
    else
      {

      }
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onSubmitAdd,
      courseInfo: courseInfo
    ));
  }

  Future<void> _onUploadImage(
      AddCourseUploadImageEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus: AddCourseStatus.onLoading
    ));

    UploadFileApi uploadFileApi = UploadFileApi(fileInfo: event.uploadFileInfo);
    dynamic data = await uploadFileApi.call();
    if(data.runtimeType == String && (data as String).isNotEmpty)
      {
        state.courseInfo?.image = data;
      }
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onSubmitAdd,
      courseInfo: state.courseInfo
    ));
  }
  Future<void> _onUploadVideoPreview(
      AddCourseUploadVideoPreViewEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onLoading
    ));
    UploadFileApi uploadFileApi = UploadFileApi(fileInfo: event.uploadFileInfo);
    dynamic data = await uploadFileApi.call();
    if(data.runtimeType == String && (data as String).isNotEmpty)
    {
      state.courseInfo?.videoPreview = data;
    }
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onSubmitAdd
    ));
  }
  Future<void> _onLinkLesson(
      AddCourseLinkLessonEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onLoading
    ));

    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onSubmitAdd
    ));
  }
  Future<void> _onLinkDiscount(
      AddCourseLinkDiscountEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onLoading
    ));

    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onSubmitAdd
    ));
  }
}

