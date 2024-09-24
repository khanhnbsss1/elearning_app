import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/services/base_request/BaseApiRequest.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/landing_page/components/course_list/edit_course_landingpage/search_course_drop_down.dart';
import 'package:webkit/services/apis/course/course_detail/models/course_detail_model.dart';
import 'package:webkit/services/apis/landing_page/course/course_list/course_list_api.dart';
import 'package:webkit/services/apis/landing_page/course/models/course_list_landing_page_response_model.dart';
import 'package:webkit/services/apis/tags/add_tag_api.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/services/apis/tags/update_tag_api.dart';

class EditCourseLandingPagePage extends StatefulWidget{
  EditCourseLandingPagePage();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditCourseLandingPagePageState();
  }
  
  void show(BuildContext context, {Function(dynamic)? callBack}) {
    showDialog(
      context: context,
       builder: (context) => this,
    ).then((value) {
      if(callBack!=null && value !=null)
        {
          callBack(value);
        }
    },);
  }}
class EditCourseLandingPagePageState extends State<EditCourseLandingPagePage>with UIMixin {
  TextEditingController tagController = TextEditingController();
  CourseListResponseModel courseListLandingPageResponseModel = CourseListResponseModel(data: []); 
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text("${L10nX.getStr.course_create} landing page" ),
      content: FutureBuilder(
        future: Future.sync(() async {
          if((courseListLandingPageResponseModel.data??[]).isEmpty)
          {
          LandingPageCourseListApi courseListApi = LandingPageCourseListApi();
          courseListLandingPageResponseModel  = await courseListApi.call();
          }
          return courseListLandingPageResponseModel;
        },), 
        builder: (context, snapshot) {
          if(snapshot.hasData && (courseListLandingPageResponseModel.data??[]).isEmpty)
            {
              courseListLandingPageResponseModel = snapshot.data??CourseListResponseModel(data: []);
            }
          
        return Container(
          width: MediaQuery.of(context).size.width/2,
          constraints: BoxConstraints(
            maxWidth: Dimens.size800,
            minWidth: Dimens.size400,
          ),
          child: SearchCourseDropDown(
            allWords: [],
            onSelectCourse: (p0) {
              setState(() {
               // (courseListLandingPageResponseModel.data??[]).add(CourseLandingPageInfo.fromCourseInfo(p0));
              });
            },
            actionType: ActionType.create,
          ),
        );
      },),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionButton1(
              text: L10nX.getStr.create_str,
              width: Dimens.size120,
              onTap: () async {
               /* dynamic tagApi = AddTagApi(tagInfo: widget.tagsInfo!);
                MonitorLoading().showLoading("");
                dynamic data = await tagApi.call();
                MonitorLoading().dismiss();
                if(data.runtimeType == String && (data as String).isEmpty)
                  {
                    Navigator.of(context).pop();
                  }*/
              },
            ),
            Gap(Dimens.size20),
            ActionButton1(
              text: L10nX.getStr.close,
              enableBgColor: ColorConst.whiteColor,
              textStype: TextStyleConstant.textStyleBlack14w600,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
  
}