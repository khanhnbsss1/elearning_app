import 'package:equatable/equatable.dart';

class SQLiteKeyInfo extends Equatable {
  String key = "";
  String value = "";
  SQLiteKeyInfo({
    required this.key,
    required this.value,
  });
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  SQLiteKeyInfo.fromJsonForDB(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}
