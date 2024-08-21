class ScoresInfo {
  int? testId;
  List<ScoreItem>? scores;

  ScoresInfo({this.testId, this.scores}){
    scores??=[];
  }

  ScoresInfo.fromJson(Map<String, dynamic> json) {
    testId = json['test_id'];
    if (json['scores'] != null) {
      scores = <ScoreItem>[];
      json['scores'].forEach((v) {
        scores!.add(new ScoreItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['test_id'] = this.testId;
    if (scores != null) {
      data['scores'] = scores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScoreItem {
  int? questionId;
  int? answerId;
  String? answerText;
  ScoreItem({this.questionId, this.answerId, this.answerText});

  ScoreItem.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    answerId = json['answer_id'];
    answerText = json['answer_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    if(answerId!=null)
      {
        data['answer_id'] = answerId;
      }
    if(answerText!=null)
    {
      data['answer_text'] = answerText;
    }
    return data;
  }
}
