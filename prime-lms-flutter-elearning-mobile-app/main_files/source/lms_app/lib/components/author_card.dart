import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/components/user_avatar.dart';
import 'package:lms_app/constants/custom_colors.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/services/app_service.dart';
import 'package:lms_app/utils/next_screen.dart';

import '../models/user/UserProfile.dart';
import '../screens/author_profie/author_profile.dart';
import '../services/apis/teacher_list/models/landing_page_teacher_list_model.dart';
import '../services/apis/teacher_list/models/teacher_model.dart';

class AuthorCard extends StatelessWidget {
  final TeacherDetail teacherDetail;
  final bool isDarkMode;

  const AuthorCard({super.key, required this.teacherDetail, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    // final String jobTitle = user.authorInfo?.jobTitle ?? '';
    // final int students = user.authorInfo?.students ?? 0;
    teacherDetail.bio = teacherDetail.bio ?? "Giáo viên ${teacherDetail.fullName} giàu kinh nghiệm, tận tâm khơi dậy tiềm năng của học sinh. Đam mê tạo ra các bài học hấp dẫn và nuôi dưỡng tình yêu học tập trong môi trường lớp học hỗ trợ.";

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color:
            (isDarkMode != true) ? Colors.white : Colors.black.withOpacity(0.1),
        border: Border.all(
            color: AppService.isDarkMode(context)
                ? CustomColor.borderDark
                : CustomColor.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(imageUrl: teacherDetail.avatar, radius: 40),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(teacherDetail.fullName ?? "-",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            // color: (isDarkMode != true)
                            //     ? Colors.black
                            //     : Colors.white,
                            color: Colors.black,
                        )),
                    Text(
                      teacherDetail.position ?? "-",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          // color: (isDarkMode != true)
                          //     ? Colors.black
                          //     : Colors.white,
                          color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                'courses-str',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    // color: (isDarkMode != true) ? Colors.black : Colors.white),
                    color: Colors.black,
                ),
              ).tr(args: ['${teacherDetail.totalCourse??2} ',]),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            teacherDetail.bio??"",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppService.isDarkMode(context) ? CustomColor.paragraphColorDark : CustomColor.paragraphColor,
                ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    elevation: 0,
                    side: BorderSide(color: Theme.of(context).primaryColor)),
                onPressed: () =>
                    NextScreen.iOS(context, AuthorProfile(teacherDetail: teacherDetail)),
                // onPressed: () {},
                child: Text(
                  'view-profile',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ).tr()),
          )
        ],
      ),
    );
  }
}
