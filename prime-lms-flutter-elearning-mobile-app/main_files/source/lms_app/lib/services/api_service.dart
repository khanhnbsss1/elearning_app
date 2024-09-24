import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_app/models/app_settings_model.dart';
import 'package:lms_app/models/category.dart';
import 'package:lms_app/models/chart_model.dart';
import 'package:lms_app/models/course.dart';
import 'package:lms_app/models/lesson.dart';
import 'package:lms_app/models/purchase_history.dart';
import 'package:lms_app/models/review.dart';
import 'package:lms_app/models/section.dart';
import 'package:lms_app/models/subscription.dart';
import 'package:lms_app/models/tag.dart';
import 'package:lms_app/services/apis/lessson/lesson_detail/get_lesson_detail.dart';
import 'package:lms_app/services/apis/lessson/models/lesson_info.dart';
import 'package:lms_app/services/apis/teacher_list/teacher_list/get_landing_page_teacher_list_api.dart';
import 'package:lms_app/services/apis/vocabulary/vocabulary_list/vocabulary_list_api.dart';
import 'package:lms_app/services/apis/vocabulary/words/get_vocabulary_detail.dart';
import 'package:lms_app/services/app_service.dart';
import 'package:lms_app/services/apis/categories/get_categories_api.dart';
import 'package:lms_app/services/apis/course/course_detail/get_course_detail_api.dart';
import 'package:lms_app/services/apis/course/my_course_list/my_course_api.dart';
import 'package:lms_app/services/apis/tags/get_tag_list.dart';
import 'package:lms_app/services/apis/tags/models/tag_info.dart';
import 'package:lms_app/utils/toasts.dart';

import '../base/base_request_elearning/models/search_common_request.dart';
import '../base/base_request_elearning/models/search_common_request_v2.dart';
import '../models/user/UserProfile.dart';
import '../services/apis/course/course_detail/models/course_detail_model.dart';
import '../services/apis/course/course_fillter/get_course_fillter_api.dart';
import '../services/apis/course/course_fillter/models/course_filtter_info.dart';
import '../services/apis/course/course_list/course_api.dart';
import '../services/apis/course/course_list/models/course_models.dart';
import 'apis/course/course_list/course_v2_api.dart';
import 'apis/course/course_list/featured_course_api.dart';
import 'apis/course_progress/get_course_proccess_list.dart';
import 'apis/course_progress/models/course_proccess_info.dart';
import 'apis/rating/add_rating_api.dart';
import 'apis/rating/delete_rating_api.dart';
import 'apis/rating/get_rating_list.dart';
import 'apis/rating/models/rating_info.dart';
import 'apis/teacher_list/get_teacher_lt.dart';
import 'apis/teacher_list/models/landing_page_teacher_list_model.dart';
import 'apis/teacher_list/models/teacher_model.dart';
import 'apis/test/get_test_detail.dart';
import 'apis/test/models/test_detail.dart';
import 'apis/vocabulary/vocabulary_list/models/vocabulary_models.dart';


class ApiService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static String getUID(String collectionName) => FirebaseFirestore.instance.collection(collectionName).doc().id;

  CourseProgressResponseModel courseProgressResponseModel = CourseProgressResponseModel(content: []);

  Future<List<CourseInfo>?> getAllCourses({required String keyword}) async {
    GetCourseListV2Api getCourseListApi = GetCourseListV2Api(searchCommonRequestV2: SearchCommonRequestV2(pageNumber: 0, pageSize: 100));
    CourseResponseModel courseResponseModel = await getCourseListApi.call();
    return courseResponseModel.content??[];
  }

  Future<List<CourseInfo>?> getMyCourses() async {
    int? userId = UserProfile().id;
    MyCourseApi myCourseApi = MyCourseApi(
        searchCommonRequest: SearchCommonRequest(
          userId: userId,
          pageNumber: 0,
          pageSize: 100,
        )
    );
    CourseResponseModel courseResponseModel = await myCourseApi.call();
    return courseResponseModel.content??[];
  }

  Future<CourseInfo> getCourseDetail({required CourseInfo course}) async {
    CourseDetailApi courseDetailApi = CourseDetailApi(courseId: course.id!);
    CourseInfo courseInfo = await courseDetailApi.call();
    return courseInfo;
  }

  Future<List<CourseInfo>?> getLatestCourses() async {
    GetCourseListV2Api getCourseListApi = GetCourseListV2Api(searchCommonRequestV2: SearchCommonRequestV2(pageNumber: 0, pageSize: 100));
    CourseResponseModel courseResponseModel = await getCourseListApi.call();
    return courseResponseModel.content??[];
  }

  Future<List<CourseInfo>?> getRelatedCoursesByCategory(CourseInfo course) async {
    GetCourseListV2Api getCourseListApi = GetCourseListV2Api(searchCommonRequestV2: SearchCommonRequestV2(gradeId: course.gradeId, pageNumber: 0, pageSize: 10));
    CourseResponseModel courseResponseModel = await getCourseListApi.call();
    return courseResponseModel.content??[];
  }

  Future<List<CourseInfo>?> getFeaturedCourses() async {
    GetFeaturedCourseListApi getFeaturedCourseListApi = GetFeaturedCourseListApi();
    List<CourseInfo> list = await getFeaturedCourseListApi.call();
    return list;
  }

  Future<List<CourseInfo>?> getFreeCourses() async {
    GetCourseListV2Api getCourseListApi = GetCourseListV2Api(searchCommonRequestV2: SearchCommonRequestV2(mode: "Free", pageSize: 10, pageNumber: 0,));
    CourseResponseModel courseResponseModel = await getCourseListApi.call();
    return courseResponseModel.content??[];
  }

  Future<List<VocabularyInfo>> getDictionary(int pageNumber, String? keyword, DictionaryType dictionaryType) async {
    GetListVocabularyApi getListVocabularyApi = GetListVocabularyApi(searchCommonRequest: SearchCommonRequest(pageSize: 10, pageNumber: pageNumber, keyword: keyword??""), dictionaryType: dictionaryType);
    VocabularyResponseModel vocabularyResponseModel = await getListVocabularyApi.call();
    return vocabularyResponseModel.content??[];
  }

  Future<VocabularyInfo> getVocabularyDetail(int vocabularyId) async {
    GetVocabularyDetailApi getVocabularyDetailApi = GetVocabularyDetailApi(vocabularyId: vocabularyId);
    VocabularyInfo? vocabularyInfo = await getVocabularyDetailApi.call();
    return vocabularyInfo??VocabularyInfo();
  }

  Future<List<RatingInfo>> getRatingList(SearchCommonRequest? searchCommonRequestRating) async {
    GetRatingListApi getRatingListApi = GetRatingListApi(
        searchCommonRequest: searchCommonRequestRating!);
    RatingListResponseModel ratingListResponseModel = await getRatingListApi
        .call();
    return ratingListResponseModel.content ?? [];
  }

  Future<void> addRating(CourseInfo courseDetail, double ratePoint, String comment) async{
    AddRatingApi addRatingApi = AddRatingApi(info: RatingInfo(
        courseId: courseDetail.id,
        ratePoint: ratePoint,
        review: comment,
    ));
    await addRatingApi.call();
  }

  Future<void> deleteRating(RatingInfo ratingInfo) async{
    DeleteRatingApi deleteRatingApi = DeleteRatingApi(info: ratingInfo);
    await deleteRatingApi.call();
  }


  Future<List<CourseInfo>?> getCoursesByAuthorId(int authorId) async {
    MyCourseApi myCourseApi = MyCourseApi(
        searchCommonRequest: SearchCommonRequest(
          userId: authorId,
          pageNumber: 0,
          pageSize: 3,
        )
    );
    CourseResponseModel courseResponseModel = await myCourseApi.call();
    return courseResponseModel.content??[];
  }

  Future<List<CourseFilterInfo>> getHomeCategories() async {
    GetCourseFilterApi getCourseFilterApi = GetCourseFilterApi();
    CourseFilterListInfo categories = await getCourseFilterApi.call("");
    return categories.data??[];
  }

  Future<List<CourseInfo>?> getCourseByCategories(
      {required String filter,
        required int pageNumber,
        required String subFilterId,
        int? producerId}) async {
    GetCourseListApi getCourseListApi = GetCourseListApi(
        searchCommonRequest: SearchCommonRequest(
            filterType: (filter != "") ? filter.toUpperCase() : "ALL",
            subFilterId: subFilterId != "" ? subFilterId : null,
            pageSize: 100,
            pageNumber: pageNumber,
            keyword: "",
            isActive: 1,
            producerId: producerId
        )
    );
    CourseResponseModel courseResponseModel = await getCourseListApi.call();
    return courseResponseModel.content??[];
  }

  Future<List<CourseInfo>?> getCourseByCategoriesV2(
      {int? gradeId,
        int? categoryId,
        String? typePayment,
        String? mode,
        String? keyword,
        String? producerName,
        int? pageSize,
        int? pageNumber}) async {
    GetCourseListV2Api getCourseListV2Api = GetCourseListV2Api(
        searchCommonRequestV2: SearchCommonRequestV2(
            gradeId: gradeId,
            categoryId: categoryId,
            producerName: producerName,
            typePayment: typePayment,
            mode: mode,
            pageSize: pageSize??100,
            pageNumber: pageNumber,
            keyword: keyword??"",
            isActive: 1,
        )
    );
    CourseResponseModel courseResponseModel = await getCourseListV2Api.call();
    return courseResponseModel.content??[];
  }

  Future<List<TagsInfo>> getAllCategories() async {
    GetCategoriesApi getTagListApi = GetCategoriesApi();
    List<TagsInfo> tagsInfoList = await getTagListApi.call();
    return tagsInfoList;
  }

  Future<CourseProgressResponseModel?> getCourseProccessListInfo({bool? isReload}) async {
    isReload??=false;
    if((courseProgressResponseModel.content??[]).isNotEmpty && isReload==false) {
      return courseProgressResponseModel;
    }
    GetCourseProccessListApi getLessonListFilterApi = GetCourseProccessListApi();
    courseProgressResponseModel =  await getLessonListFilterApi.call();
    return courseProgressResponseModel;
  }

  Future<LessonInfo?> getLessonDetail(int lectureId) async {
    GetLessonDetailApi getLessonDetailApi = GetLessonDetailApi(lectureId: lectureId);
    LessonInfo? lessonInfo = await getLessonDetailApi.call();
    return lessonInfo;
  }

  Future<TestDetail> getTestDetail(int testId) async {
    GetTestDetailApi getTestDetailApi = GetTestDetailApi(testId: testId);
    TestDetail testDetail = await getTestDetailApi.call();
    return testDetail;
  }


  Future<List<LandingPageUserInfo>?> getTopAuthors() async {
    LandingPageTeacherListApi landingPageTeacherListApi = LandingPageTeacherListApi();
    List<LandingPageUserInfo>? list = await landingPageTeacherListApi.call();
    return list;
  }

  Future<List<TeacherDetail>> getTopAuthors1() async {
    GetTeacherList getTeacherList = GetTeacherList();
    List<TeacherDetail>? list = await getTeacherList.call();
    return list??[];
  }

  Future<List<Review>> getLimitedReviews(String courseId, int limit) async {
    List<Review> data = [];
    await firestore
        .collection('reviews')
        .where('course_id', isEqualTo: courseId)
        .orderBy('created_at', descending: true)
        .limit(limit)
        .get()
        .then((QuerySnapshot? snapshot) {
      data = snapshot!.docs.map((e) => Review.fromFirebase(e)).toList();
    });
    return data;
  }


  Future<UserProfile?> getUserData() async {
    UserProfile? user;
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      final DocumentSnapshot snap = await firestore.collection('users').doc(userId).get();
      // user = UserProfile.fromFirebase(snap);
    } catch (e) {
      debugPrint('error on getting user data: $e');
    }

    return user;
  }

  Future<AppSettingsModel?> getAppSettingsData() async {
    AppSettingsModel? settings;
    try {
      final DocumentSnapshot snap = await firestore.collection('settings').doc('app').get();
      settings = AppSettingsModel.fromFirestore(snap);
    } catch (e) {
      debugPrint('error on getting app settings data');
    }
    return settings;
  }

  Future updateWishList(UserProfile user, CourseInfo course) async {
    final DocumentReference ref = firestore.collection('users').doc(user.id.toString());
    final newCourseId = course.id;
    final List courses = user.wishList ?? [];

    if (courses.contains(newCourseId)) {
      await ref.update({
        'wishlist': FieldValue.arrayRemove([newCourseId])
      });
    } else {
      courses.add(newCourseId);
      await ref.update({'wishlist': FieldValue.arrayUnion(courses)});
    }
  }

  Future saveUserData(UserProfile user) async {
    try {
      // final data = UserProfile.getMap(user);
      // await firestore.collection('users').doc(user.id.toString()).set(data);
    } catch (e) {
      debugPrint('error on saving user data: $e');
    }
  }


  Future updateSubscription(UserProfile user, Subscription subscription) async {
    final DocumentReference ref = firestore.collection('users').doc(user.id.toString());
    final data = Subscription.getMap(subscription);
    await ref.update({'subscription': data});
  }

  Future savePurchaseHistory(UserProfile user, PurchaseHistory history) async {
    final Map<String, dynamic> data = PurchaseHistory.getMap(history);
    final DocumentReference ref = firestore.collection('purchases').doc();
    await ref.set(data);
  }

  Future<bool> isUserExists(String userId) async {
    DocumentSnapshot snap = await firestore.collection('users').doc(userId).get();
    if (snap.exists) {
      debugPrint('User Exists');
      return true;
    } else {
      debugPrint('New User');
      return false;
    }
  }

  //for wishlish and my courses
  Future<QuerySnapshot> getCoursesQuery(chunk) {
    Query itemsQuery = FirebaseFirestore.instance.collection('courses').where(FieldPath.documentId, whereIn: chunk);
    return itemsQuery.get();
  }

  Future<QuerySnapshot> getReviewsSnapshot({required String courseId, DocumentSnapshot? lastDocument}) async {
    QuerySnapshot snapshot;
    if (lastDocument == null) {
      snapshot =
          await firestore.collection('reviews').where('course_id', isEqualTo: courseId).orderBy('created_at', descending: true).limit(10).get();
    } else {
      snapshot = await firestore
          .collection('reviews')
          .where('course_id', isEqualTo: courseId)
          .orderBy('created_at', descending: true)
          .startAfterDocument(lastDocument)
          .limit(10)
          .get();
    }
    return snapshot;
  }

  Future updateUserStats() async {
    final String id = AppService.getTodaysID();
    final DocumentReference docRef = firestore.collection('user_stats').doc(id);
    await firestore.runTransaction((transaction) {
      return transaction.get(docRef).then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          final ChartModel chartModel = ChartModel.fromFirestore(snapshot);
          final newChartModel = ChartModel(id: chartModel.id, count: chartModel.count + 1, timestamp: chartModel.timestamp);
          final Map<String, dynamic> data = ChartModel.getMap(newChartModel);
          transaction.set(docRef, data, SetOptions(merge: true));
        } else {
          final newChartModel = ChartModel(id: id, count: 1, timestamp: DateTime.now().toUtc());
          final Map<String, dynamic> data = ChartModel.getMap(newChartModel);
          transaction.set(docRef, data, SetOptions(merge: true));
        }
      });
    });
  }

  Future updatePurchaseStats() async {
    final String id = AppService.getTodaysID();
    final DocumentReference docRef = firestore.collection('purchase_stats').doc(id);
    await firestore.runTransaction((transaction) {
      return transaction.get(docRef).then((DocumentSnapshot snapshot) {
        if (snapshot.exists) {
          final ChartModel chartModel = ChartModel.fromFirestore(snapshot);
          final newChartModel = ChartModel(id: chartModel.id, count: chartModel.count + 1, timestamp: chartModel.timestamp);
          final Map<String, dynamic> data = ChartModel.getMap(newChartModel);
          transaction.set(docRef, data, SetOptions(merge: true));
        } else {
          final newChartModel = ChartModel(id: id, count: 1, timestamp: DateTime.now().toUtc());
          final Map<String, dynamic> data = ChartModel.getMap(newChartModel);
          transaction.set(docRef, data, SetOptions(merge: true));
        }
      });
    });
  }


  Future<List<Course>> getHomeCategoryCourses(String categoryId, int limit) async {
    List<Course> data = [];
    await firestore
        .collection('courses')
        .where('cat_id', isEqualTo: categoryId)
        .where('status', isEqualTo: 'live')
        .limit(5)
        .get()
        .then((QuerySnapshot? snapshot) {
      data = snapshot!.docs.map((e) => Course.fromFirestore(e)).toList();
    });
    return data;
  }
}
