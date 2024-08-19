
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';

import '../button/action_button1.dart';

class DateTimePicker{
  static Future<void> ShowDialogDatePicker(
      {
        required BuildContext context,
        required CalendarDatePicker2Type calendarDatePicker2Type,
        DateTime?fromDate, /// using for CalendarDatePicker2Type.range type
        DateTime?toDate, /// using for CalendarDatePicker2Type.range type
        DateTime?initSingleDate, /// using for CalendarDatePicker2Type.single type
        DateTime?limitDate,/// default limitDate = DateTime.now()
        List<DateTime?>? multiDateInitValue, /// using for CalendarDatePicker2Type.multi type
        double ?widthOfDialog,
        double ?heightOfDialog,
        Function(CalendarDatePicker2Type , List<DateTime?>)? onDimissCallBack}) async {
    widthOfDialog??=  MediaQuery.of(context).size.width;
    heightOfDialog??=  MediaQuery.of(context).size.height/2;
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        double width= MediaQuery.of(context).size.width/2;
        double height= MediaQuery.of(context).size.height/2;
        List<DateTime?> rangeDatePickerValueWithDefaultValue = [
        ];
        switch(calendarDatePicker2Type){
          case CalendarDatePicker2Type.single:
          
            if(initSingleDate!=null) {
              rangeDatePickerValueWithDefaultValue.addAll([initSingleDate]);
            }
            break;
          case CalendarDatePicker2Type.multi:
          
            if(multiDateInitValue!=null && multiDateInitValue.isNotEmpty)
            {
              rangeDatePickerValueWithDefaultValue.addAll([...multiDateInitValue]);
            }
            break;
          case CalendarDatePicker2Type.range:
          
            if(fromDate==null || toDate==null)
            {
              return SizedBox(
                width: width,
                height:  height,
                child: const Center(child: Text("Missing fromDate or toDate for CalendarDatePicker2Type.range type!"),),
              );
            }
            else
            {
              rangeDatePickerValueWithDefaultValue.addAll([fromDate, toDate]);
            }
            break;
        }

        final config = CalendarDatePicker2Config(
          calendarType: calendarDatePicker2Type,
          selectedDayHighlightColor: ColorConst.mainColor,
          selectedRangeHighlightColor:ColorConst.mainColor.withOpacity(0.7) ,
          weekdayLabelTextStyle: baseStyle.copyWithCustom(
            color: ColorConst.blackColor87,
            fontWeight: FontWeight.bold,
          ),
          controlsTextStyle: baseStyle.copyWithCustom(
            color: ColorConst.blackColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          selectedDayTextStyle: baseStyle.copyWithCustom(
            color: ColorConst.whiteColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          selectedRangeDayTextStyle: baseStyle.copyWithCustom(
            color: ColorConst.whiteColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),

        );
        List<DateTime?> resultDates = [];
        limitDate ??= DateTime.now();
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          insetPadding:  EdgeInsets.symmetric(horizontal: 10),
          content: SizedBox(
            width: widthOfDialog??MediaQuery.of(context).size.width,
            height: heightOfDialog??MediaQuery.of(context).size.height*1/2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: ColorConst.greyColor1,size: Dimens.size30,),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CalendarDatePicker2(
                          config: config,
                          value: rangeDatePickerValueWithDefaultValue,
                          onValueChanged: (dates){
                            List<DateTime?> datesResult = [];

                            for(DateTime? date in dates)
                              {
                                int checkResult =date!.compareTo(limitDate!);
                                if(checkResult>0) {
                                  datesResult.add(limitDate);
                                } else{
                                  datesResult.add(date);
                                }
                              }
                            resultDates = datesResult;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20,),
                    ActionButton1(
                      text: S.of(context).str_accept,
                      width: 150,
                      height: 40,
                      onTap: () {
                        Navigator.of(context).pop();
                        if(onDimissCallBack!=null) {
                          onDimissCallBack(calendarDatePicker2Type, resultDates);
                        }
                      },
                    ),
                    const SizedBox(height: 20,),
                  ],
                ),
              ],
            ),
          ),
        );
      },

    );
  }
}