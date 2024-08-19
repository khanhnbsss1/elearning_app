import 'package:lms_app/base/base.export.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/base/helper/date_time/date_time_helper.dart';
import 'date_time_picker.dart';

class DateTimeSetting extends StatefulWidget {
  double? width;
  bool? isSettingRangeDay;
  bool? isShowResetButton;
  DateTime? startTime;
  DateTime? endTime;
  bool? enableActionButton;
  Function({DateTime startTime, DateTime endTime})? onChangeDateTimeCallBack;
  DateTimeSetting(
      {
        super.key,
        this.onChangeDateTimeCallBack,
        this.width,
        this.isSettingRangeDay,
        this.isShowResetButton,
        this.startTime,
        this.enableActionButton,
        this.endTime}) {
    isSettingRangeDay ??= false;
    isShowResetButton ??= true;
    startTime ??= DateTime.now().copyWith(day: 1);
    endTime ??= DateTime.now();
    enableActionButton??=true;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DateTimeSettingState();
  }
}

class DateTimeSettingState extends State<DateTimeSetting> {
  Widget buildUI(BuildContext context, {bool? isTablet}) {
    isTablet ??= false;
    double widthOfTimeDialog = isTablet ? MediaQuery.of(context).size.width / 2 : MediaQuery.of(context).size.width;
    double heightOfTimeDialog = isTablet ? 460 : MediaQuery.of(context).size.height / 2;
    return Container(//width: width??(isTablet?MediaQuery.of(context).size.width/2:MediaQuery.of(context).size.width),
      constraints:  BoxConstraints(
        maxWidth: isTablet?500:MediaQuery.of(context).size.width,
        minWidth: 300,
      ),
      decoration: BoxDecoration(
        color: ColorConst.whiteColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimens.size0, vertical: Dimens.size8),
      child: Stack(
        children: [
          Visibility(
            visible: !widget.isSettingRangeDay!,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimens.size8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: buildTimeItem(
                      context,
                      title: "",//S.of(context).to_time,
                      timeText: DateTimeHelper.dateFormat(date: widget.startTime, dateType: DateTimeHelper.ddMMyy),
                      onTapCenter: () {
                        DateTimePicker.ShowDialogDatePicker(
                          context: context,
                          calendarDatePicker2Type: CalendarDatePicker2Type.single,
                          initSingleDate: widget.startTime,
                          limitDate: widget.endTime,
                          widthOfDialog: widthOfTimeDialog,
                          heightOfDialog: heightOfTimeDialog,
                          onDimissCallBack: (calendarDatePicker2Type, dateTimeList) {
                            setState(() {
                              if (dateTimeList.isNotEmpty) {
                                widget.startTime = dateTimeList.first;
                              }
                            });
                            if (widget.onChangeDateTimeCallBack != null) {
                              widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                            }
                          },
                        );
                      },
                      onTapNext: () {
                        setState(() {
                          widget.startTime = widget.startTime?.copyWith(day: widget.startTime!.day + 1);
                        });
                        if (widget.onChangeDateTimeCallBack != null) {
                          widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                        }
                      },
                      onTapPre: () {
                        setState(() {
                          widget.startTime = widget.startTime?.copyWith(day: widget.startTime!.day - 1);
                        });
                        if (widget.onChangeDateTimeCallBack != null) {
                          widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                        }                          },
                    ),
                  ),
                  Gap(Dimens.size20),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        color: ColorConst.blackColor,
                        width: 10,
                        height: 1,
                      ),
                    ],
                   ),
                  Gap(Dimens.size20),
                  Expanded(
                    child: buildTimeItem(
                      context,
                      title: "",//S.of(context).to_time,
                      timeText: DateTimeHelper.dateFormat(date: widget.endTime, dateType: DateTimeHelper.ddMMyy),
                      onTapCenter: () {
                        DateTimePicker.ShowDialogDatePicker(
                          context: context,
                          calendarDatePicker2Type: CalendarDatePicker2Type.single,
                          initSingleDate: widget.endTime,
                          limitDate: DateTime.now(),
                          widthOfDialog: widthOfTimeDialog,
                          heightOfDialog: heightOfTimeDialog,
                          onDimissCallBack: (calendarDatePicker2Type, dateTimeList) {
                            setState(() {
                              if (dateTimeList.isNotEmpty) {
                                widget.endTime = dateTimeList.first;
                              }
                            });
                            if (widget.onChangeDateTimeCallBack != null) {
                              widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                            }
                          },
                        );
                      },
                      onTapNext: () {
                        setState(() {
                          widget.endTime = widget.endTime?.copyWith(day: widget.endTime!.day + 1);
                        });
                        if (widget.onChangeDateTimeCallBack != null) {
                          widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                        }                          },
                      onTapPre: () {
                        setState(() {
                          widget.endTime = widget.endTime?.copyWith(day: widget.endTime!.day - 1);
                        });
                        if (widget.onChangeDateTimeCallBack != null) {
                          widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                        }                           },
                    ),
                  ),
                  Visibility(
                    visible: widget.isShowResetButton!,
                    child: Padding(
                      padding:  EdgeInsets.only(right: Dimens.size10),
                      child: Material(
                        color: Colors.transparent,
                        clipBehavior: Clip.hardEdge,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              widget.startTime ??= DateTime.now().copyWith(day: 1);
                              widget.endTime ??= DateTime.now();
                            });
                            if (widget.onChangeDateTimeCallBack != null) {
                              widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                            }
                            },
                          child: Icon(
                            Icons.replay_circle_filled,
                            size: Dimens.size25,
                            color: ColorConst.iconColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.isSettingRangeDay!,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTimeItem(
                  context,
                  title: S.of(context).from_time,
                  timeText: DateTimeHelper.dateFormat(date: widget.startTime, dateType: DateTimeHelper.ddMMyy),
                  onTapCenter: () {
                    DateTimePicker.ShowDialogDatePicker(
                      context: context,
                      calendarDatePicker2Type: CalendarDatePicker2Type.range,
                      fromDate: widget.startTime,
                      toDate: widget.endTime,
                      widthOfDialog: widthOfTimeDialog,
                      heightOfDialog: heightOfTimeDialog,
                      onDimissCallBack: (calendarDatePicker2Type, dateTimeList) {
                        setState(() {
                          if (dateTimeList.length>=2) {
                            widget.startTime = dateTimeList.first;
                            widget.endTime = dateTimeList.last;
                          }
                        });
                        if (widget.onChangeDateTimeCallBack != null) {
                          widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                        }
                      },
                    );
                  },
                  onTapNext: () {
                    setState(() {
                      widget.startTime = widget.startTime?.copyWith(day: widget.startTime!.day + 1);
                    });
                    if (widget.onChangeDateTimeCallBack != null) {
                      widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                    }                          },
                  onTapPre: () {
                    setState(() {
                      widget.startTime = widget.startTime?.copyWith(day: widget.startTime!.day - 1);
                    });
                    if (widget.onChangeDateTimeCallBack != null) {
                      widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                    }                          },
                ),
                buildTimeItem(
                  context,
                  title: S.of(context).to_time,
                  timeText: DateTimeHelper.dateFormat(date: widget.endTime, dateType: DateTimeHelper.ddMMyy),
                  onTapCenter: () {
                    DateTimePicker.ShowDialogDatePicker(
                      context: context,
                      calendarDatePicker2Type: CalendarDatePicker2Type.range,
                      fromDate: widget.startTime,
                      toDate: widget.endTime,
                      widthOfDialog: widthOfTimeDialog,
                      heightOfDialog: heightOfTimeDialog,
                      onDimissCallBack: (calendarDatePicker2Type, dateTimeList) {
                        setState(() {
                          if (dateTimeList.length>=2) {
                            widget.startTime = dateTimeList.first;
                            widget.endTime = dateTimeList.last;
                          }
                        });
                        if (widget.onChangeDateTimeCallBack != null) {
                          widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                        }
                      },
                    );
                  },
                  onTapNext: () {
                    setState(() {
                      widget.endTime = widget.endTime?.copyWith(day: widget.endTime!.day + 1);
                    });
                    if (widget.onChangeDateTimeCallBack != null) {
                      widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                    }                             },
                  onTapPre: () {
                    setState(() {
                      widget.endTime = widget.endTime?.copyWith(day: widget.endTime!.day - 1);
                    });
                    if (widget.onChangeDateTimeCallBack != null) {
                      widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                    }                             },
                ),
                Visibility(
                  visible: widget.isShowResetButton!,
                  child: Row(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: Dimens.size10),
                        child: Material(
                          color: Colors.transparent,
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                widget.startTime ??= DateTime.now().copyWith(day: 1);
                                widget.endTime ??= DateTime.now();
                              });
                              if (widget.onChangeDateTimeCallBack != null) {
                                widget.onChangeDateTimeCallBack!(startTime: widget.startTime!, endTime: widget.endTime!);
                              }                                     },
                            child: Icon(
                              Icons.replay_circle_filled,
                              size: Dimens.size25,
                              color: ColorConst.iconColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildTimeItem(BuildContext context, {
    String? title,
    required String timeText, Function()? onTapPre, Function()? onTapNext, Function()? onTapCenter}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title!=null && title.isNotEmpty,
            child: Text(title??"", style:  TextStyleConstant.textStyleBlack14w600,)),
        Gap(Dimens.size4),
        Container(
          decoration: BoxDecoration(
            color: ColorConst.whiteColor,
              borderRadius: BorderRadius.circular(Dimens.size16),
              border: Border.all(color: ColorConst.greyColor1)
          ),
          padding: EdgeInsets.symmetric(horizontal: Dimens.size16, vertical: Dimens.size8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Visibility(
                visible: widget.enableActionButton??true,
                child: Material(
                    color: Colors.transparent,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        if (onTapPre != null) {
                          onTapPre();
                        }
                      },
                      child: SizedBox(
                        width: Dimens.size30,
                          child: getPngImage(ImagesNameConst.ic_back_png, width: Dimens.size20, height: Dimens.size20)
                    ),
                    )),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    if (onTapCenter != null) {
                      onTapCenter();
                    }
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Text(
                      timeText,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyleConstant.textStyleBlack12w400,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.enableActionButton??true,

                child: Material(
                    color: Colors.transparent,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        if (onTapNext != null) {
                          onTapNext();
                        }
                      },
                      child: SizedBox(
                        width: Dimens.size30,
                          child: getPngImage(ImagesNameConst.ic_next_png, width: Dimens.size20, height: Dimens.size20)
                      ),
                    )),
              ),
              Gap(Dimens.size10),
              InkWell(
                onTap: () {
                  if (onTapCenter != null) {
                    onTapCenter();
                  }
                },
                child: Icon(
                  Icons.calendar_month,
                  color: ColorConst.mainColor,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return buildUI(context);
  }
}
