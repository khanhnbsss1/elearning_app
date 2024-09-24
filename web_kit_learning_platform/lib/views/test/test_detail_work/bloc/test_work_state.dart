part of 'test_work_bloc.dart';

enum TestWorkStatus {
  initial,
  onLoading,
  onScoring,
  onShowResult,
  onChangePage,
  onUpdateChooseQuestion,
  onScoreResult,
  onStartTest, 
  unKnown
}

@immutable
class TestWorkState extends Equatable {
  TestWorkStatus? blocStatus;
  TestInfo? testInfo;
  bool? enableShowResult;
  bool? startTest;
  int? page;
  int? pageSize;
  ScoreResultInfo? result;
  List<List<QuestionInfo>>? quizDTOsForView;
  TestWorkState({
      this.blocStatus,
    this.testInfo, 
    this.enableShowResult,
    this.pageSize, 
    this.quizDTOsForView,
    this.page,
    this.result,
    this.startTest
  }){
    page??=0;
    pageSize??=8;
    startTest??=false;
  }
  
  TestWorkState copyWith({
    TestWorkStatus? blocStatus,
    TestInfo? testInfo,
    bool? enableShowResult,
    int? page,
    int? pageSize,
    List<List<QuestionInfo>>? quizDTOsForView,
    ScoreResultInfo? result,
    bool? startTest
  })
  {
    return TestWorkState(
      blocStatus: blocStatus??this.blocStatus,
      testInfo: testInfo??this.testInfo,
      enableShowResult: enableShowResult??this.enableShowResult,
      page: page??this.page,
      pageSize: pageSize??this.pageSize,
      quizDTOsForView: quizDTOsForView??this.quizDTOsForView,
      result: result??this.result,
      startTest: startTest??this.startTest,

    );
  }
  @override
  List<Object?> get props => [
    blocStatus,
    testInfo, 
    enableShowResult,
    page, 
    pageSize,
    quizDTOsForView,
    result,
    startTest
  ];

}