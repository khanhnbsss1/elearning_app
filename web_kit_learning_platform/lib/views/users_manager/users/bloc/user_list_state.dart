part of 'user_list_bloc.dart';

enum UserListStatus {
  initial,
  onLoading,
  onSearchByParams,
  onLoadEnd,
  onSelectLesson
}

@immutable
class UserListState extends Equatable {
  UserListResponseModel? userListResponseModel;
  UserListStatus? blocStatus;
  SearchCommonRequest? searchCommonRequest;
  UserProfile? selectUserInfo;
  UserType? userType;
  UserListState({
      this.blocStatus, 
    this.userListResponseModel,
    this.searchCommonRequest,
    this.selectUserInfo,
    this.userType
  }){
    userType??=UserType.User;
    userListResponseModel??= UserListResponseModel(content: [],pageNumber: 0, pageSize: 10);
    searchCommonRequest??= SearchCommonRequest(pageNumber: 0, pageSize: 15, keyword: "", userType: userTypeToStr[userType]);
  }


  UserListState copyWith({
    UserListResponseModel? userListResponseModel,
    UserListStatus? blocStatus,
    SearchCommonRequest? searchCommonRequest,
    UserProfile? selectUserInfo
  })
  {
    return UserListState(
      blocStatus: blocStatus??this.blocStatus,
      userListResponseModel: userListResponseModel??this.userListResponseModel,
      searchCommonRequest: searchCommonRequest??this.searchCommonRequest,
      selectUserInfo: selectUserInfo??this.selectUserInfo,

    );
  }
  @override
  List<Object?> get props => [blocStatus, userListResponseModel, searchCommonRequest, selectUserInfo];

}