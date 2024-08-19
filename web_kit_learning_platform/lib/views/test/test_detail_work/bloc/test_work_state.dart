part of 'test_work_bloc.dart';

enum TestWorkStatus {
  initial,
  onLoading,
  onScoring,
  onShowResult,
  onChangePage
}

@immutable
class TestWorkState extends Equatable {
  TestWorkStatus? blocStatus;
  TestInfo? testInfo;
  bool? enableShowResult;
  int? page;
  int pageSize;
  TestWorkState({
      this.blocStatus,
    this.testInfo, 
    this.enableShowResult,
    this.pageSize =6, 
    this.page}){
    page??=0;
  }


  TestWorkState copyWith({
    TestWorkStatus? blocStatus,
    TestInfo? testInfo,
    bool? enableShowResult,
    int? page,
    int? pageSize,
  })
  {
    return TestWorkState(
      blocStatus: blocStatus??this.blocStatus,
      testInfo: testInfo??this.testInfo,
      enableShowResult: enableShowResult??this.enableShowResult,
      page: page??this.page,
      pageSize: pageSize??this.pageSize,
    );
  }
  @override
  List<Object?> get props => [
    blocStatus,
    testInfo, 
    enableShowResult,
    page, 
    pageSize,
  ];

}