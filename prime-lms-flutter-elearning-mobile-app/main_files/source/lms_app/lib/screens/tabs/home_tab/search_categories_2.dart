import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lms_app/components/loading_tile.dart';
import 'package:lms_app/screens/all_courses.dart/seach_courses_view.dart';
import 'package:lms_app/screens/all_courses.dart/search_result.dart';
import 'package:lms_app/services/api_service.dart';
import '../../../constants/custom_colors.dart';
import '../../../services/apis/course/course_fillter/models/course_filtter_info.dart';
import '../../../utils/next_screen.dart';
import '../../all_courses.dart/courses_view.dart';
import '../../home/home_bottom_bar.dart';
import '../../home/home_view.dart';
import 'home_categories.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

final courseFilterInfoProvider =
    StateProvider<CourseFilterInfo>((ref) => CourseFilterInfo(name: "All"));

final subFilterInfoProvider =
    StateProvider<SubFilterInfo>((ref) => SubFilterInfo());

class SearchCategories2 extends ConsumerStatefulWidget {
  const SearchCategories2({super.key});

  @override
  ConsumerState<SearchCategories2> createState() => _SearchCategoriesState2();
}

class _SearchCategoriesState2 extends ConsumerState<SearchCategories2> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(homeCategoriesProvider);
    final courseFilterInfo = ref.watch(courseFilterInfoProvider);
    final subFilterInfo = ref.watch(subFilterInfoProvider);
    return (categories.hasValue == true)
        ? Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  categories.when(
                      skipLoadingOnRefresh: false,
                      data: (categories) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PopupMenuButton(
                                    onSelected: (filter) {
                                      setState(() {
                                        ref
                                            .read(courseFilterInfoProvider
                                                .notifier)
                                            .state = filter!;
                                        ref
                                            .read(subFilterInfoProvider
                                            .notifier)
                                            .state = SubFilterInfo();
                                      });
                                    },
                                    itemBuilder: (context) =>
                                        categories!.map((item) {
                                          if (item.subFilter!.isNotEmpty && item.filterType != "AUTHOR") {
                                            return PopupMenuItem(
                                              value: item,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(item.name!),
                                                  PopupMenuButton(
                                                    onSelected: (value) {
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        ref
                                                            .read(
                                                                subFilterInfoProvider
                                                                    .notifier)
                                                            .state = value;
                                                      });
                                                    },
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 100,
                                                            maxHeight: 300),
                                                    child: const Icon(
                                                        Icons.arrow_right),
                                                    itemBuilder: (context) =>
                                                        item.subFilter!
                                                            .map((subFilter) =>
                                                                PopupMenuItem(
                                                                  value:
                                                                      subFilter,
                                                                  child: Text(
                                                                      subFilter
                                                                          .name!),
                                                                ))
                                                            .toList(),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else if (item.filterType != "AUTHOR") {
                                            return PopupMenuItem(
                                              value: item,
                                              child: Text(item.name!),
                                            );
                                          } else {
                                            return const PopupMenuItem(value: null, child: SizedBox(),
                                            );
                                          }
                                        }).where((popupItem) => (popupItem.value != null)).toList(),
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          children: [
                                            const Icon(Icons.menu),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              courseFilterInfo.name != "" && courseFilterInfo.name != null
                                                  && subFilterInfo.name != "" && subFilterInfo.name != null
                                                  ? subFilterInfo.name??""
                                                  : courseFilterInfo.name != "" && courseFilterInfo.name != null
                                                      ? courseFilterInfo.name??"!"
                                                      : "categories".tr(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ))),
                                // Container(
                                //   color: CustomColor.container,
                                //   child: DropdownButtonHideUnderline(
                                //     child: DropdownButton2<String>(
                                //       isExpanded: true,
                                //       hint: Text(
                                //         'Select Item',
                                //         style: TextStyle(
                                //           fontSize: 14,
                                //           color: Theme.of(context).hintColor,
                                //         ),
                                //       ),
                                //       items: items
                                //           .map((String item) => DropdownMenuItem<String>(
                                //         value: item,
                                //         child: Text(
                                //           item.tr(),
                                //           style: const TextStyle(
                                //               fontSize: 14,
                                //               fontWeight: FontWeight.w400
                                //           ),
                                //         ),
                                //       ))
                                //           .toList(),
                                //       value: selectedValue == "" ? null : selectedValue,
                                //       onChanged: (String? value) {
                                //         setState(() {
                                //           selectedValue = value;
                                //           editProfileController.basicValidator.getController('gender')!.text = value!;
                                //         });
                                //       },
                                //       buttonStyleData: const ButtonStyleData(
                                //         padding: EdgeInsets.symmetric(horizontal: 16),
                                //         height: 40,
                                //         width: 140,
                                //       ),
                                //       menuItemStyleData: const MenuItemStyleData(
                                //         height: 40,
                                //       ),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SearchResult(
                              paddingAll: 0,
                              gridStyle: GridStyle.grid,
                            )
                          ],
                        );
                      },
                      error: (e, x) => Text('error: $e, $x'),
                      loading: () =>
                          const LoadingTile(height: 100, padding: 0)),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
