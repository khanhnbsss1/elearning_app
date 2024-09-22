import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/components/rating_bar.dart';
import 'package:lms_app/components/rating_star.dart';
import 'package:lms_app/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:lms_app/utils/empty_animation.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../base/base_request_elearning/models/search_common_request.dart';
import '../../configs/app_assets.dart';
import '../../models/course.dart';
import '../../models/review.dart';
import '../../models/review_user.dart';
import '../../models/user_model.dart';
import '../../models/user/UserProfile.dart';
import '../../providers/user_data_provider.dart';
import '../../services/apis/rating/models/rating_info.dart';
import '../course_details.dart/course_reviews.dart';
import 'reviews_provider.dart';
import '../../services/api_service.dart';
import '../../utils/snackbars.dart';

final courseRatingProvider = StateProvider.family
    .autoDispose<double, CourseInfo>(
        (ref, course) => (course.ratePoint ?? 0).toDouble());

class RatingForm extends ConsumerStatefulWidget {
  const RatingForm(
      {super.key, required this.reviewList, required this.courseDetail});

  final CourseInfo courseDetail;
  final List<RatingInfo> reviewList;

  @override
  ConsumerState<RatingForm> createState() => _RatingFormState();
}

class _RatingFormState extends ConsumerState<RatingForm> {
  double _rating = 0.0;
  var reviewCtlr = TextEditingController();
  final _btnController = RoundedLoadingButtonController();
  late String _btnText;
  int selected = 0;

  @override
  void initState() {
    super.initState();
    _btnText = 'update';
    _rating = 5.0;
    reviewCtlr.text = '';
  }

  @override
  Widget build(BuildContext context) {
    UserProfile? user = UserManager().getUserProfile();
    List<RatingInfo> reviewList = [];
    for (RatingInfo review in widget.reviewList) {
      if (widget.courseDetail.id == review.courseId) {
        reviewList.add(review);
      }
    }
    return Scaffold(
      appBar: AppBar(
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
            Text(
              '${user?.fullName}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 8),
            const Text('write-review').tr(),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StarRating(
                    initialRating: (_rating).toDouble(),
                    size: 24,
                    onChanged: (value) {
                      _rating = value;
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: FloatingActionButton(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      onPressed: () {
                        ApiService().addRating(
                            widget.courseDetail, _rating, reviewCtlr.text);
                        setState(() {});
                      },
                      child: Text('submit'.tr()),
                    ),
                  )
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
            (reviewList.isNotEmpty)
                ? Flexible(
                    child: ListView.builder(
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
                    animationString: reviewAnimation, title: 'no-review'.tr()),
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
              rating: ratingInfo.ratePoint??0,
            ),
          ],
        ),
        if (ratingInfo.createdAt != null)
          Text(
            'created-at'.tr(args: [ratingInfo.createdAt!]),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black54),
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

  Future<List<RatingInfo>> getReviewDetail() async {
    List<RatingInfo> list =
    await ApiService().getRatingList(SearchCommonRequest(
      pageNumber: 0,
      pageSize: 10,
    ));
    return list ?? [];
  }
}
