part of 'user_list_bloc.dart';

enum UserListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
}

@immutable
class UserListState extends Equatable {
  UserListResponseModel? userListResponseModel;
  UserListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  UserProfile? selectUserInfo;
  UserType? userType;
  int? courseId;
  UserListState({
      this.blocStatus, 
    this.userListResponseModel,
    this.searchCommonRequest,
    this.selectUserInfo,
    this.userType,
    this.courseId
  }){
    userType??=UserType.User;
    userListResponseModel??= UserListResponseModel(content: [],pageNumber: 0, pageSize: 10);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 15, keyword: "", userType: userTypeToStr[userType], courseId: courseId);
  }


  UserListState copyWith({
    UserListResponseModel? userListResponseModel,
    UserListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    UserProfile? selectUserInfo,
    UserType? userType,
    int? courseId
  })
  {
    return UserListState(
      blocStatus: blocStatus??this.blocStatus,
      userListResponseModel: userListResponseModel??this.userListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectUserInfo: selectUserInfo??this.selectUserInfo,
      userType: userType??this.userType,
      courseId: courseId??this.courseId,

    );
  }
  @override
  List<Object?> get props => [blocStatus, userListResponseModel, searchCommonRequest, selectUserInfo, userType, courseId];

}