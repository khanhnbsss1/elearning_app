import 'package:lms_app/base/base.export.dart';
import 'package:flutter/material.dart';

import 'bloc/list_body_common_bloc.dart';

class ListBodyCommon extends StatefulWidget {
  Widget ?list;
  Widget body;
  double widthOfListRatio;
  double? maxOfWidthOfListRatio = 0.5;
  double? minOfWidthOfListRatio = 0.05;
  double? heightOfPage = 600;
  Color? expandIconColor ;
  MainAxisAlignment? mainAxisAlignment = MainAxisAlignment.start;
  CrossAxisAlignment? crossAxisAlignment = CrossAxisAlignment.center;

  ListBodyCommon(
      {
        super.key,
        required this.list,
        required this.body,
        this.mainAxisAlignment,
        this.crossAxisAlignment,
        this.maxOfWidthOfListRatio,
        this.minOfWidthOfListRatio,
        this.widthOfListRatio = 0.3,
        this.expandIconColor,
        this.heightOfPage
      }) {
    mainAxisAlignment ??= MainAxisAlignment.start;
    crossAxisAlignment ??= CrossAxisAlignment.center;
    maxOfWidthOfListRatio ??= 0.5;
    minOfWidthOfListRatio ??= 0.05;
    expandIconColor??=ColorConst.whiteColor;
  }

  @override
  State<StatefulWidget> createState() {
    return _ListBodyCommonState();
  }
}

class _ListBodyCommonState extends State<ListBodyCommon> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return ListBodyCommonBloc(
              ListBodyCommonState(
                  blocStatus: ListBodyCommonStatus.initial,
                maxOfWidthOfListRatio: widget.maxOfWidthOfListRatio,
                minOfWidthOfListRatio:widget.minOfWidthOfListRatio,
                  widthOfListRatio:widget.widthOfListRatio

              ))..add(const ListBodyCommonInitEvent());
        },
        child: BlocConsumer<ListBodyCommonBloc, ListBodyCommonState>(
            listener: (context, state) {
          switch (state.blocStatus) {
            case ListBodyCommonStatus.initial:
              
              break;
            case ListBodyCommonStatus.unKnown:
              
              break;
            case ListBodyCommonStatus.onDrag:
              
              state.blocStatus = ListBodyCommonStatus.unKnown;
              break;
          }
        }, builder: (BuildContext context, state) {
          return LayoutBuilder(
            builder: (buildContext, boxConstraints) {
              state.widthOfPage = boxConstraints.maxWidth;
              widget.heightOfPage = boxConstraints.maxHeight;
              return Stack(
                children: [
                  Row(
                  mainAxisAlignment: widget.mainAxisAlignment!,
                  crossAxisAlignment: widget.crossAxisAlignment!,
                  children: [
                    widget.list!=null?
                    SizedBox(
                    width:(state.widthOfPage!) * state.widthOfListRatio!,
                    child:widget.list,
                    ):const SizedBox.shrink(),
                    Expanded(
                      child: widget.body,
                    )
                  ],
                ),
                  Visibility(
                    visible: widget.list!=null,
                    child: Padding(
                      padding: EdgeInsets.only( left:(state.widthOfPage! -Dimens.size45) * state.widthOfListRatio!,),
                      child: _lineVertical(context),
                    ),
                  ),
                ]
              );
            },
          );
        }));
  }

  Widget _lineVertical(BuildContext context) {
    return GestureDetector(
        onPanUpdate: (details) {
          BlocProvider.of<ListBodyCommonBloc>(context).add(ListBodyCommonDragEvent(dx: details.delta.dx));
        },
        child: Padding(
          padding: EdgeInsets.only(top: Dimens.size70),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: Dimens.size5,
                color: Colors.transparent,
              ),
              SizedBox(
                width: Dimens.size20,
                height: Dimens.size20,
                child: Image.asset(
                    ImagesNameConst.getPngImage(
                        ImagesNameConst.ic_resize),
                  color: widget.expandIconColor,
                ),
              ),
              Container(
                width: Dimens.size5,
                color: Colors.transparent,
              ),
            ],
          ),
        ));
  }
}
