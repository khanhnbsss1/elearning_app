import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/common/alert_dialog/loading.common.dart';
import 'package:lms_app/base/widgets/my_button.dart';
import 'package:lms_app/components/rating_bar.dart';
import 'package:lms_app/components/rating_star.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/empty_animation.dart';
import 'package:lms_app/utils/loading_widget.dart';
import '../../base/base_request_elearning/models/search_common_request.dart';
import '../../base/widgets/toast_common/toast_utils.dart';
import '../../configs/app_assets.dart';
import '../../models/user/UserProfile.dart';
import '../../services/apis/rating/models/rating_info.dart';
import '../../services/api_service.dart';

final courseRatingProvider = StateProvider.family
    .autoDispose<double, CourseInfo>(
        (ref, course) => (course.ratePoint ?? 0).toDouble());

class RatingForm extends ConsumerStatefulWidget {
  const RatingForm({super.key, required this.courseDetail});

  final CourseInfo courseDetail;

  @override
  ConsumerState<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends ConsumerState<RatingForm> {
  double _rating = 0.0;
  bool canComment = true;
  var reviewCtlr = TextEditingController();
  int selected = 0;
  UserProfile? user = UserManager().getUserProfile();
  int _pageNumber = 0;
  bool lastPage = false;
  bool isLoading = true;
  late ScrollController _controller;
  List<RatingInfo> reviewList = [];
  RatingInfo yourRating = RatingInfo();

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 0.0);
    _controller.addListener(_scrollListener);
    _rating = 5.0;
    _getReviewList();
    reviewCtlr.text = '';
  }

  Future<void> _addRating() async {
    MonitorLoading().showLoading('');
    await ApiService().addRating(widget.courseDetail, _rating, reviewCtlr.text);
    // yourRating = RatingInfo(
    //   ratePoint: _rating,
    //   review: reviewCtlr.text,
    //   createdAt: DateFormat('MM/dd/yyyy hh:mm:ss a').format(DateTime.now()),
    //   fullname: user?.fullName,
    // );
    // if (reviewList.first.fullname == yourRating.fullname) {
    //   reviewList.removeAt(0);
    //   reviewList.insert(0, yourRating);
    // } else {
    //   reviewList.insert(0, yourRating);
    // }
    // setState(() {});
    _getReviewList();
    MonitorLoading().dismiss();
    ToastUtils.showSnackBar(context, 'thanks_for_rating'.tr());
  }

  Future<void> _getReviewList() async {
    List<RatingInfo> data = await getReviewDetail(_pageNumber);
    if (data.isNotEmpty) {
      for (RatingInfo review in data) {
        if (widget.courseDetail.id == review.courseId && review.isShow == 1) {
          if (review.fullname == user?.fullName) {
            reviewList.insert(0, review);
          } else {
            reviewList.add(review);
          }
        }
      }
    } else {
      lastPage = true;
    }
    setState(() {
      isLoading = false;
    });
  }

  _scrollListener() async {
    var isEnd = _controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange;
    if (isEnd) {
      if (!lastPage) _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() {
      _pageNumber++;
      _getReviewList();
    });
  }

  Future<void> _deleteRating(RatingInfo ratingInfo) async {
    await ApiService().deleteRating(ratingInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('reviews').tr(),
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context)),
      ),
      // bottomSheet: BottomAppBar(
      //   child: RoundedLoadingButton(
      //     animateOnTap: false,
      //     elevation: 0,
      //     color: Theme.of(context).primaryColor,
      //     controller: _btnController,
      //     child: Text(
      //       _btnText,
      //       style: Theme.of(context)
      //           .textTheme
      //           .titleMedium
      //           ?.copyWith(color: Colors.white, fontSize: 18),
      //     ).tr(),
      //     onPressed: () => {},
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Visibility(
                visible: false,
                child: Text(
                  'rating-note',
                  style: Theme.of(context).textTheme.bodySmall,
                ).tr(),
              ),
            ),
            Visibility(
              visible: !canComment,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  height: 35,
                  width: 120,
                  child: FloatingActionButton(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      setState(() {
                        canComment = true;
                      });
                    },
                    child: Text('write-review'.tr()),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: canComment,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user?.fullName}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('write-review').tr(),
                      Spacer(),
                      StarRating(
                        initialRating: (_rating).toDouble(),
                        size: 24,
                        onChanged: (value) {
                          _rating = value;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    controller: reviewCtlr,
                    minLines: 3,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'write-your-review'.tr()),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 35,
                          width: 70,
                          child: FloatingActionButton(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              setState(() {
                                canComment = false;
                              });
                            },
                            child: Text('cancel'.tr()),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          height: 35,
                          width: 70,
                          child: FloatingActionButton(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            onPressed: () async {
                              await _addRating();
                            },
                            child: Text('submit'.tr()),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                // runSpacing: 8,
                child: Row(
                  children: [
                    ActionChip(
                      onPressed: () {
                        setState(() {
                          selected = 0;
                        });
                      },
                      backgroundColor: (selected == 0)
                          ? Theme.of(context).primaryColor.withOpacity(0.1)
                          : Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      label: Text(
                        'view-all-reviews'.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    ...List.generate(5, (index) {
                      return ActionChip(
                        onPressed: () {
                          setState(() {
                            selected = index + 1;
                          });
                        },
                        backgroundColor: (selected == index + 1)
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 6),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${5 - index} ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                            ),
                            const Icon(
                              Icons.star,
                              color: Colors.orange,
                              size: 16,
                            )
                          ],
                        ),
                      );
                    }),
                  ],
                )),
            const SizedBox(
              height: 10,
            ),
            (isLoading == true)
                ? const Flexible(child: Center(child: LoadingIndicatorWidget()))
                : (reviewList.isNotEmpty)
                    ? Flexible(
                        child: ListView.builder(
                            controller: _controller,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: reviewList.length,
                            itemBuilder: (context, index) {
                              if (6 - selected ==
                                  reviewList[index].ratePoint?.floor()) {
                                return reviewItem(reviewList[index]);
                              } else if (selected == 0) {
                                return reviewItem(reviewList[index]);
                              } else {
                                return const SizedBox();
                              }
                            }),
                      )
                    : EmptyAnimation(
                        animationString: reviewAnimation,
                        title: 'no-review'.tr()),
          ],
        ),
      ),
    );
  }

  Widget reviewItem(RatingInfo ratingInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '${ratingInfo.fullname}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(
              width: 20,
            ),
            RatingViewer(
              showText: false,
              rating: ratingInfo.ratePoint ?? 0,
            ),
          ],
        ),
        if (ratingInfo.createdAt != null)
          Row(
            children: [
              Text(
                'created-at'.tr(args: [ratingInfo.createdAt!]),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black54),
              ),
              const Spacer(),
              if (ratingInfo.fullname == user?.fullName)
                InkWell(
                    onTap: () {
                      _showDeleteDialog(context, ratingInfo);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        LineIcons.trash,
                        size: 20,
                      ),
                    )),
            ],
          ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Flexible(
                child: Text(
              '${ratingInfo.review}',
              style: Theme.of(context).textTheme.bodyLarge,
            )),
          ],
        ),
        const Divider()
      ],
    );
  }

  Future<List<RatingInfo>> getReviewDetail(int pageNumber) async {
    List<RatingInfo> list =
        await ApiService().getRatingList(SearchCommonRequest(
      pageNumber: pageNumber,
      pageSize: 10,
    ));
    return list ?? [];
  }

  void _showDeleteDialog(BuildContext context, RatingInfo ratingInfo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('delete-comment'.tr()),
          content: Text('are-you-sure-delete-comment'.tr()),
          actions: [
            MyButton(
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                'cancel'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            MyButton(
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                'confirm'.tr(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () async {
                await ApiService().deleteRating(ratingInfo);
                _getReviewList();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
