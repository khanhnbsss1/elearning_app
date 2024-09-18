import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_pagination/flutter_custom_pagination.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';

class PaginationCustom extends FlutterCustomPagination {
  bool? enableTotalElement;
  PaginationCustom(
      {super.key,
      required super.currentPage,
      required super.limitPerPage,
      required super.totalDataCount,
      required super.onPreviousPage,
      required super.onNextPage,
      super.onBackToFirstPage,
      super.onGoToLastPage,
      super.backgroundColor,
      super.textStyle,
      super.previousPageIcon = Icons.keyboard_arrow_left,
      super.nextPageIcon = Icons.keyboard_arrow_right,
      super.backToFirstPageIcon = Icons.first_page,
      super.goToLastPageIcon = Icons.last_page,
      this.enableTotalElement});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        super.build(context),
        Visibility(
            visible: enableTotalElement ?? true,
            child: Row(
              children: [
                Gap(Dimens.size16),
                Text(
                  "${L10nX.getStr.display_str.toLowerCase()} ${(currentPage - 1) * limitPerPage}-${(currentPage) * limitPerPage > totalDataCount ? totalDataCount : (currentPage) * limitPerPage} ${L10nX.getStr.of_str.toLowerCase()} $totalDataCount",
                  style: TextStyleConstant.textStyleBlack14w600.copyWith(color: ColorConst.mainColor),
                ),
              ],
            ))
      ],
    );
  }
}
