import 'package:easy_localization/easy_localization.dart';

class NumberHelper {

  static NumberHelper ?_instance = NumberHelper();

  static NumberHelper getInstance() {
    _instance ??= NumberHelper();
    return _instance!;
  }
  String numberToString(dynamic value,{int? decimalDigits, bool? compact}){
    compact??=false;
    decimalDigits??=3;
    if(compact==true) {
      if (value > 1000 && value < 1000000) {
        return "${NumberFormat.currency(name: '', decimalDigits: 1).format(value.toDouble() / 1000)}k";
      }
      else if (value >= 1000000 && value < 1000000000) {
        return "${NumberFormat.currency(name: '', decimalDigits: 1).format(value.toDouble() / 1000000)}M";
      }
      else if (value >= 1000000000 && value < 1000000000000) {
        return "${NumberFormat.currency(name: '', decimalDigits: 1).format(value.toDouble() / 1000000000)}B";
      }
      else
        {
          return NumberFormat.currency(name:'',decimalDigits: decimalDigits??3).format(value);
        }
      }
    else
      {
        return NumberFormat.currency(name:'',decimalDigits: decimalDigits??3).format(value);
      }
  }
}