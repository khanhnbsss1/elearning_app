import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/ui/add_course_controller.dart';
import 'package:webkit/services/apis/course/add_course/add_course_api.dart';
import 'package:webkit/services/apis/course/course_detail/get_course_detail_api.dart';
import 'package:webkit/services/apis/course/course_detail/link_lesson_api.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/course/course_detail/ulink_lesson_api.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_api.dart';
import 'package:webkit/services/apis/course/get_course_dictionary/get_course_directory_model.dart';
import 'package:webkit/services/apis/course/update_course/update_course_api.dart';
import 'package:webkit/services/apis/lessson/models/lesson_info.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/test/link_test_to_course_api.dart';
import 'package:webkit/services/apis/test/models/test_info.dart';
import 'package:webkit/services/apis/test/unklink_test_from_course_api.dart';
import 'package:webkit/services/apis/test/unklink_test_from_lesson_api.dart';
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';
import 'package:webkit/views/course/create_edit_course/create_edit_course.dart';
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
    on<AddCourseUnLinkLessonEvent>(_onUnLinkLesson);

    on<AddCourseUpdateCourseFromApiEvent>(_onUpdateCourseFromAPI);
    on<AddCourseUpdateControllerEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
        blocStatus: AddCourseStatus.onUpdateController,
        controller: event.addCourseController,
        courseInfo: event.courseInfo
      ));
    });
    on<AddCourseUpdateTestInfoEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: AddCourseStatus.onUpdateTestInfo,
          
          testInfo: event.testInfo
      ));
    });
    on<AddCourseUpdateSubjectListEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: AddCourseStatus.onUpdateSubjectList,
          subjectList: event.subjectList
      ));
    });
    on<AddCourseUpdateCurrentSubjectEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: AddCourseStatus.onUpdateCurrentSubject,
          currentSubject: event.subject
      ));
    });
    on<AddCourseUpdateCourseInfoEvent>((event, emit) {
      // TODO: implement event handler
      emit(state.copyWith(
          blocStatus: AddCourseStatus.onUpdateCurrentSubject,
          courseInfo: event.courseInfo
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
    if(state.courseInfo?.id!=null && state.courseInfo?.id!=0)
      {
        CourseDetailApi courseDetailApi = CourseDetailApi(courseId: state.courseInfo!.id!);
        CourseInfo courseInfo = await courseDetailApi.call();
        state.courseInfo = courseInfo;
        if(state.courseInfo?.testId!=null)
          {
            state.testInfo = TestInfo(id: state.courseInfo?.testId??0, name:  state.courseInfo?.testName??"");
          }
        for(LessonInfo lessonInfo in state.courseInfo?.lectures??[]){
          if(lessonInfo.subName!=null && !state.subjectList!.contains(lessonInfo.subName) && lessonInfo.subName!.isNotEmpty)
            {
              state.subjectList?.add(lessonInfo.subName!);
            }
        }
        state.controller?.setInfoObjectController(state.courseInfo?.getListInfoObj()??[]);
        state.controller?.setResultObjectController(state.courseInfo?.getListInfoResult()??[]);
      }
    else
      {
        state.controller?.setInfoObjectController(state.courseInfo?.getListInfoObj()??[]);
        state.controller?.setResultObjectController(state.courseInfo?.getListInfoResult()??[]);

      }
    
    state.controller?.basicValidator.getController('course_mode')?.text = state.courseInfo?.courseMode??'FREE';
    state.controller?.basicValidator.getController('is_standard')?.text = (state.courseInfo?.isStandard??0).toString();
    state.controller?.basicValidator.getController('id')?.text =( state.courseInfo?.id??0).toString();
    state.controller?.basicValidator.getController('total_lectures')?.text = (state.courseInfo?.totalLectures??0).toString();
    state.controller?.basicValidator.getController('total_subjects')?.text = (state.courseInfo?.totalSubjects??0).toString();
    state.controller?.basicValidator.getController('payment_mode')?.text = (state.courseInfo?.mode??0).toString();
    state.controller?.basicValidator.getController('rate_point')?.text = (state.courseInfo?.rating??0).toString();
    state.controller?.basicValidator.getController('category_id')?.text = (state.courseInfo?.categoryId??0).toString();
    state.controller?.basicValidator.getController('is_active')?.text = (state.courseInfo?.isActive??1).toString();
    state.controller?.basicValidator.getController('language')?.text = state.courseInfo?.language??'CN';
    state.controller?.basicValidator.getController('durian')?.text = state.courseInfo?.durian??'';
    state.controller?.basicValidator.getController('payment_value')?.text = (state.courseInfo?.price??0).toString();

    
    state.controller?.basicValidator.getController('name')?.text = state.courseInfo?.name??'jooko';
    state.controller?.basicValidator.getController('image')?.text = state.courseInfo?.image??'';
    state.controller?.basicValidator.getController('introduction')?.text = state.courseInfo?.introduction??'';
    state.controller?.basicValidator.getController('grade_name')?.text = state.courseInfo?.gradeName??'';
    state.controller?.basicValidator.getController('producer_name')?.text = state.courseInfo?.producerName??'';
    state.controller?.basicValidator.getController('category_name')?.text = state.courseInfo?.categoryName??'';
    state.controller?.basicValidator.getController('video_preview')?.text = state.courseInfo?.videoPreview??'';
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
            if (state.controller!.listOfTags.where((element) => element.id == e.id,).isEmpty) {
              state.controller!.listOfTags.add(TagsInfo(id: e.id, name: e.name));
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
      courseInfo: state.courseInfo,
      subjectList: state.subjectList,
      controller: state.controller,
      testInfo: state.testInfo
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

    MonitorLoading().showLoading("");
    CourseInfo? courseInfo = await state.controller?.getCourseInfoFromUI(courseInfo: state.courseInfo!);
    courseInfo = courseInfo?.copyWith(
        image: state.courseInfo?.image,
        videoPreview: state.courseInfo?.videoPreview
    );
    UpdateCourseApi updateCourseApi = UpdateCourseApi(addCourseRequest: courseInfo!);
    dynamic data = await updateCourseApi.call();
    await _onLinkTestToCourse();
    MonitorLoading().dismiss();
    if(data.runtimeType==String && (data as String).isEmpty)
    {
      //courseInfo.id = data as int;
      ToastUtils.showToastSuccess(L10nX.getStr.success);
    }
    else
    {

    }
    
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
    await _onLinkTestToCourse();
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
    UploadFileResponseInfo? data = await uploadFileApi.call();
    if(data!=null )
      {
        state.courseInfo?.image = data.link;
        state.courseInfo?.imageId = data.id;
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
    UploadFileResponseInfo? data = await uploadFileApi.call();
    if(data!=null )
    {
      state.courseInfo?.videoPreview = data.link;
    }
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onSubmitAdd
    ));
  }
  Future<void> _onLinkLesson(
      AddCourseLinkLessonEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    MonitorLoading().showLoading("");
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onLoading
    ));
    LinkLessonApi lessonApi = LinkLessonApi(courseId: event.courseId, lessonId: event.lessonId, subject: event.subject);
    dynamic data = await lessonApi.call();
    MonitorLoading().dismiss();
    if(data.runtimeType==String && (data as String).isEmpty)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.success);
      add(AddCourseUpdateCourseFromApiEvent());
    }
    else
    {

    }
  }
  Future<void> _onUnLinkLesson(
      AddCourseUnLinkLessonEvent event,
      Emitter<AddCourseState> emit,
      ) async {
    MonitorLoading().showLoading("");
    emit(state.copyWith(
        blocStatus:  AddCourseStatus.onLoading
    ));
    UnLinkLessonApi lessonApi = UnLinkLessonApi(courseId: event.courseId, lessonId: event.lessonId,subject: event.subject);
    dynamic data = await lessonApi.call();
    MonitorLoading().dismiss();
    if(data.runtimeType==String && (data as String).isEmpty)
    {
      ToastUtils.showToastSuccess(L10nX.getStr.success);
      add(AddCourseUpdateCourseFromApiEvent());
    }
    else
    {
    }
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
  Future<void> _onUpdateCourseFromAPI(
      AddCourseUpdateCourseFromApiEvent event,
      Emitter<AddCourseState> emit,
      )async {
    if(state.courseInfo?.id!=null && state.courseInfo?.id!=0)
    {
      CourseDetailApi courseDetailApi = CourseDetailApi(courseId: state.courseInfo!.id!);
      CourseInfo courseInfo = await courseDetailApi.call();
      state.courseInfo = courseInfo;
    }
    emit(state.copyWith(
      blocStatus: AddCourseStatus.onUpdateCourseFromApi,
      courseInfo: state.courseInfo
    ));
  }
  Future<void> _onLinkTestToCourse()async {
    if(state.testInfo!=null)
    {
      /// Cần phải unlink trước khi link tới 1 test khác
      UnLinkTestToCourseApi unlinkWordApi = UnLinkTestToCourseApi(courseId: state.courseInfo?.id??0, testId: state.testInfo?.id??0);
      dynamic unlinkData = await unlinkWordApi.call();

      LinkTestToCourseApi linkWordApi = LinkTestToCourseApi(courseId: state.courseInfo?.id??0, testId: state.testInfo?.id??0);
      dynamic linkData = await linkWordApi.call();
    }
  }
}

