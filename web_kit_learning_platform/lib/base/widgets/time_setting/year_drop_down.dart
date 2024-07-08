import 'package:webkit/base/base.export.dart';
import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:datepicker_dropdown/order_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YearDropDown extends StatefulWidget{
  int? startYear;
  int? endYear;

  Function(String year)?onSelectYear;
  Function(String month)?onSelectMonth;
  Function(String day)?onSelectDay;
  bool? isShowDay, isShowMonth, isShowYear;
  BoxConstraints? constraints;
  double? borderRadius;
  YearDropDown(
      {
        super.key,
        this.endYear,
        this.startYear,
        this.onSelectDay,
        this.onSelectMonth,
        this.onSelectYear,
        this.isShowDay,
        this.isShowMonth,
        this.isShowYear,
        this.constraints,
        this.borderRadius
      }){
    endYear??=DateTime.now().year;
    startYear??=endYear!-5;
    borderRadius??=Dimens.size5;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return YearDropDownState();
  }

}
class YearDropDownState extends State<YearDropDown>{
  final DateTime now = DateTime.now();
  int? selectDay;
  int? selectMonth;
  int? selectYear;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    selectDay??=now.day;
    selectMonth??=now.month;
    selectYear??=now.year;
    return DropdownDatePicker(
      dateformatorder: OrderFormat.DMY, // def// ault is myd
      inputDecoration: InputDecoration(
          enabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(widget.borderRadius!)
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(widget.borderRadius!)
          ),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(widget.borderRadius!)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(widget.borderRadius!)
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(widget.borderRadius!)
          ),

          constraints:  widget.constraints,
          contentPadding: EdgeInsets.symmetric(vertical: Dimens.size0),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0),
              borderRadius: BorderRadius.circular(widget.borderRadius!))), // optional
      isDropdownHideUnderline: true, // optional
      isFormValidator: true, // optional
      startYear: widget.startYear, // optional
      endYear: widget.endYear, // optional
      width: 10, // optional
      onChangedDay: (value) {
        if(widget.onSelectDay!=null && value!=null)
          {
            widget.onSelectDay!(value);
            selectDay= int.parse(value);
          }
      },
      onChangedMonth:(value) {
        if(widget.onSelectMonth!=null && value!=null)
        {
          widget.onSelectMonth!(value);
          selectMonth= int.parse(value);

        }
      },
      onChangedYear: (value) {
        if(widget.onSelectYear!=null && value!=null)
        {
          widget.onSelectYear!(value);
          selectYear= int.parse(value);

        }
      },
      boxDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          border: Border.all(color: Colors.grey, width: 1.0)), // optional
      showDay: widget.isShowDay??true,
      showMonth: widget.isShowMonth??true,
      showYear: widget.isShowYear??true,
      selectedDay: selectDay,
      selectedMonth: selectMonth,
      selectedYear: selectYear,
      // showDay: false,// optional
      // dayFlex: 2,// optional
      // locale: "zh_CN",// optional
      // hintDay: 'Day', // optional
      // hintMonth: 'Month', // optional
      // hintYear: 'Year', // optional
      // hintTextStyle: baseStyle.copyWith(color: Colors.grey), // optional
    );
  }

}