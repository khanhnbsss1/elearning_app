
import '../../question/models/question_info.dart';

class ScoresInfo {
  int? testId;
  int? courseId;
  int? lectureId;
  List<ScoreItem>? scores;

  ScoresInfo({this.testId, this.scores, this.lectureId, this.courseId}){
    scores??=[];
  }

  ScoresInfo.fromJson(Map<String, dynamic> json) {
    testId = json['test_id'];
    courseId = json['course_id'];
    lectureId = json['lecture_id'];

    if (json['scores'] != null) {
      scores = <ScoreItem>[];
      json['scores'].forEach((v) {
        scores!.add(new ScoreItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['test_id'] = testId;
    data['course_id'] = courseId;
    data['lecture_id'] = lectureId;
    if (scores != null) {
      data['scores'] = scores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScoreItem {
  int? questionId;
  int? answerId;
  String? answerName;
  QuestionType? questionType; 
  ScoreItem({this.questionId, this.answerId, this.answerName, this.questionType});

  ScoreItem.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answerId = json['answer_id'];
    answerName = json['answer_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['type_question'] = mapQuestionTypeToStrKey[questionType];
    if(answerId!=null)
      {
        data['answer_id'] = answerId;
      }
    if(answerName!=null)
    {
      data['answer_name'] = answerName;
    }
    
    return data;
  }
}
