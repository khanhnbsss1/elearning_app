import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/widgets/time_setting/date_time_picker.dart';
import 'package:webkit/views/apps/contacts/build_text_field.dart';

class PeriodOfTime extends StatelessWidget{
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();

  DateTime? initStartDate, initEndTime;
  Function(DateTime? startTime, DateTime? endTime)? onChangeTime;
  PeriodOfTime({this.initStartDate, this.onChangeTime, this.initEndTime}){
    if(initStartDate!=null)
      {
        String startTimeStr = DateTimeHelper.dateFormat(date: initStartDate, dateType: DateTimeHelper.yyyyMMDD);
        startTimeController.text = startTimeStr;

      }
    if(initEndTime!=null)
    {
      String timeStr = DateTimeHelper.dateFormat(date: initEndTime, dateType: DateTimeHelper.yyyyMMDD);
      endTimeController.text = timeStr;
    }  
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: Dimens.size500,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BuildTextField(
              enableEdit: true,
              enableHintText: false,
              suffixIcon: Icon(Icons.calendar_month,),
              onTap: () {
                DateTimePicker.ShowDialogDatePicker(
                  context: context,
                  widthOfDialog: Dimens.size500,
                  calendarDatePicker2Type: CalendarDatePicker2Type.single,
                  initSingleDate: initStartDate,
                  onDimissCallBack: (p0, p1) {
                    if(p1.isNotEmpty)
                    {
                      initStartDate = p1.first;
                      if(onChangeTime!=null )
                        {
                          onChangeTime!(initStartDate,initEndTime );
                        }
                    }
                  },
                );
              },
              controller: startTimeController,),
          ),
          Gap(Dimens.size16),
          Expanded(
            child: BuildTextField(
              enableEdit: true,
              enableHintText: false,
              suffixIcon: Icon(Icons.calendar_month,),
              onTap: () {
                DateTimePicker.ShowDialogDatePicker(
                  context: context,
                  widthOfDialog: Dimens.size500,
                  calendarDatePicker2Type: CalendarDatePicker2Type.single,
                  initSingleDate: initEndTime,
                  onDimissCallBack: (p0, p1) {
                    if(p1.isNotEmpty)
                    {
                      initEndTime = p1.first;
                      if(onChangeTime!=null )
                      {
                        onChangeTime!(initStartDate,initEndTime );
                      }
                    }
                  },
                );
              },
              controller: startTimeController,),
          ),
        ],
      ),
    );
  }


}