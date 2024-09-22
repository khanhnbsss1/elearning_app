import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';

class StarRating extends StatefulWidget {
  final double initialRating;
  final bool? showText;
  final double? size;
  final void Function(double)? onChanged;

  const StarRating(
      {super.key, required this.initialRating, this.showText, this.onChanged, this.size});

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  double _rating = 0.0;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        RatingBar(
          itemSize: widget.size??24,
          initialRating: _rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(vertical: 3, horizontal: 1.0),
          unratedColor: Colors.grey.shade400,
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
            if (widget.onChanged != null) {
              widget.onChanged!(rating);
              ToastUtils.showToast('thanks_for_rating'.tr());
            }
          },
          ratingWidget: RatingWidget(
            empty: const Icon(
              Icons.star_border,
              color: Colors.orange,
              size: 16,
            ),
            half: const Icon(
              Icons.star_half_outlined,
              color: Colors.orange,
              size: 16,
            ),
            full: const Icon(
              Icons.star,
              color: Colors.orange,
              size: 16,
            ),
          ),
        ),
        Visibility(
          visible: widget.showText ?? true,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              _rating.toStringAsFixed(1),
              style: const TextStyle(
                  fontSize: 13,
                  color: Colors.deepOrange,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }
}
