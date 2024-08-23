import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/widgets/time_setting/date_time_picker.dart';
import 'package:webkit/controller/apps/contact/edit_profile_controller.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/user/get_user_detail_api.dart';
import 'package:webkit/services/apis/user/update_password_api.dart';
import 'package:webkit/services/apis/user/user_manager/add_user_api.dart';
import 'package:webkit/services/apis/user/user_manager/update_user_api.dart';
import 'package:webkit/views/apps/contacts/build_text_field.dart';
import 'package:webkit/views/layouts/layout.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart' as dio;
import 'package:webkit/services/apis/upload_file/models/upload_file_info.dart';
import 'package:webkit/services/apis/upload_file/upload_file_api.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({super.key, this.userProfile, this.actionType, this.editSelfProfile}){
    actionType??=ActionType.view;
    editSelfProfile??= true;
    userProfile??=UserProfile();
  }
  UserProfile ?userProfile;
  ActionType? actionType;
  bool? editSelfProfile;

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile>
    with SingleTickerProviderStateMixin, UIMixin {
  late EditProfileController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EditProfileController());
    if(widget.actionType == ActionType.create)
      {
        enableEdit = true;
      }
  }
  bool changePassword = false;
  TextEditingController birdthdayController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPassWordController = TextEditingController();
  TextEditingController newPassWordAgainController = TextEditingController();
  TextEditingController billInfoController = TextEditingController();
  TextEditingController backNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();


  bool enableEdit = false;

  
  @override
  Widget build(BuildContext context) {
    return Layout(
      showBackButton: true,
      child: FutureBuilder(
          future: getUserProfile(), 
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height*2/5),
                child: SizedBox(
                  child:  Center(
                    child: NoData(),
                  ),
                ),
              );
            }
            widget.userProfile = snapshot.data;
            String fullName = widget.userProfile?.fullName ?? "";
            String firstName = fullName
                .split(" ")
                .sublist(0, fullName.split(" ").length - 1)
                .join(" ");
            String lastName = fullName.split(" ").last;
            return Column(
              children: [
                Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.titleMedium(
                        "Edit Profile",
                        fontWeight: 600,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: enableEdit == true,
                            child: MyButton(
                              elevation: 5,
                              onTap: () async {
                                if(widget.actionType== ActionType.create)
                                  {
                                    Navigator.of(context).pop();
                                  }
                                setState(() {
                                  enableEdit = false;
                                });
                              },
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: ColorConst.whiteColor,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: MyText.bodySmall(
                                'Cancel',
                                color: ColorConst.mainColor,
                              ),
                            ),
                          ),
                          MySpacing.width(10),
                          Visibility(
                            visible: enableEdit == false,
                            child: MyButton(
                              onTap: () {
                                
                                setState(() {
                                  enableEdit = true;
                                });
                              },
                              elevation: 0,
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: ColorConst.mainColor,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: MyText.bodySmall(
                                'Edit',
                                color: ColorConst.whiteColor,
                              ),
                            ),
                          ),
                          MySpacing.width(10),
                          Visibility(
                            visible: enableEdit == true,
                            child: MyButton(
                              onTap: () async {
                                widget.userProfile?.birthday = birdthdayController.text;
                                widget.userProfile?.fullName = fullNameController.text;
                                // widget.userProfile?.roleId = roleController.text;
                                widget.userProfile?.gender = genderController.text;
                                widget.userProfile?.phoneNumber = phoneNumberController.text;
                                widget.userProfile?.countryName = countryController.text;
                                widget.userProfile?.bankAccount = billInfoController.text;
                                widget.userProfile?.bankName = backNameController.text;
                                dynamic updateUserApi;
                                if((widget.editSelfProfile??true)||widget.actionType == ActionType.edit)
                                  {
                                    updateUserApi = UpdateUserApi(info: widget.userProfile!);
                                  }
                                else if(widget.actionType == ActionType.create)
                                  {
                                    updateUserApi = AddUserApi(info: widget.userProfile!);
                                  }
                                if(updateUserApi!=null)
                                  {
                                    MonitorLoading().showLoading("");
                                    dynamic data = await updateUserApi.call();
                                    if(data.runtimeType == String && (data as String).isEmpty)
                                    {
                                      if(widget.editSelfProfile==true)
                                      {
                                        UserManager().deleteUserProfile();
                                        GetUserProfileInfoApi getUserProfileInfoApi= GetUserProfileInfoApi();
                                        widget.userProfile = await getUserProfileInfoApi.call();
                                      }
                                      setState(() {
                                        enableEdit = false;
                                      });
                                    }
                                    MonitorLoading().dismiss();
                                  }
                                else
                                  {
                                    setState(() {
                                      enableEdit = false;
                                    });
                                  }
                              },
                              elevation: 0,
                              padding: MySpacing.xy(20, 16),
                              backgroundColor: ColorConst.mainColor,
                              borderRadiusAll: AppStyle.buttonRadius.medium,
                              child: MyText.bodySmall(
                                'Save Change',
                                color: ColorConst.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                MySpacing.height(flexSpacing),
                Padding(
                  padding: MySpacing.x(flexSpacing / 2),
                  child: MyFlex(
                    children: [
                      MyFlexItem(
                        sizes: "lg-6",
                        child: MyCard(
                          shadow: MyShadow(elevation: 0.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText.titleMedium(
                                L10nX.getStr.user_detail,
                                fontWeight: 600,
                              ),
                              StatefulBuilder(
                                builder: (BuildContext context, void Function(void Function()) setState) { 
                                  return Center(
                                    child: InkWell(
                                        onTap: () async {
                                          if(!enableEdit)
                                          {
                                            return;
                                          }
                                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ['png', 'jpg'],
                                          );
                                          if (result == null) {
                                            return;
                                          }
                                          dio.MultipartFile file = dio.MultipartFile.fromBytes(result.files.first.bytes!.toList(growable: true), filename: result.names[0]);
                                          UploadFileApi uploadFileApi = UploadFileApi(fileInfo: UploadFileInfo(data: SubjectType.vocabulary, fileName: result.files.first.name, file: file));
                                          UploadFileResponseInfo? resultUpload = await uploadFileApi.call();
                                          if (resultUpload != null) {
                                            setState(() {
                                              widget.userProfile?.avatar = resultUpload.link;
                                            });
                                          }
                                        },
                                        child: Container(
                                            height: Dimens.size150,
                                            width: Dimens.size150,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimens.size80)
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            child: ImageManager().getImageByUrl(
                                                widget.userProfile?.avatar??"",
                                              errorBuilder: Icon(  widget.userProfile?.gender== "Male"? Icons.face:Icons.face_2, size: Dimens.size150, color: ColorConst.colorIconRed,)
                                            ))
                                    ),
                                  );
                                },
                              ),
                              MySpacing.height(20),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BuildTextField(
                                            enableEdit: enableEdit,
                                            fieldTitle: "Full Name",
                                            hintText:
                                            "Enter your Fulle Name",
                                            controller: fullNameController,),
                                      ),
                                      MySpacing.width(10),
                                    ],
                                  ),
                                  MySpacing.height(20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BuildTextField(
                                            enableEdit: (widget.editSelfProfile??true)?false:enableEdit,
                                            fieldTitle: "Role",
                                            hintText: (widget.editSelfProfile??true)? "Your role":"Enter role",
                                            controller: roleController,),
                                      ),
                                      MySpacing.width(10),
                                      Expanded(
                                        child: BuildTextField(
                                            enableEdit: enableEdit,
                                            fieldTitle: "Gender",
                                            hintText: "Enter your gender",
                                            controller: genderController,
                                        ),
                                      ),
                                      MySpacing.width(10),

                                      Expanded(
                                        child: BuildTextField(
                                          enableEdit: enableEdit,
                                          suffixIcon: Icon(Icons.calendar_month,),
                                          onTap: () {
                                            DateTimePicker.ShowDialogDatePicker(
                                              context: context,
                                              widthOfDialog: Dimens.size500,

                                              calendarDatePicker2Type: CalendarDatePicker2Type.single,
                                              initSingleDate: widget.userProfile?.getBirdDay(),
                                              onDimissCallBack: (p0, p1) {
                                                if(p1.isNotEmpty)
                                                {
                                                  widget.userProfile?.birthday = DateTimeHelper.dateFormat(date: p1.first, dateType: DateTimeHelper.yyyyMMDD);
                                                  birdthdayController.text= widget.userProfile?.birthday??"";
                                                }
                                              },
                                            );
                                          },
                                          fieldTitle: "Birthday",
                                          hintText: "Enter your birthday",
                                          controller: birdthdayController,),
                                      ),
                                    ],
                                  ),

                                  MySpacing.height(20),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: BuildTextField(
                                          enableEdit: enableEdit,
                                          fieldTitle: "Email",
                                          hintText: "Enter your email",
                                          controller: emailController,),
                                      ),
                                      MySpacing.width(10),
                                      Expanded(
                                        child: BuildTextField(
                                          enableEdit: enableEdit,
                                          fieldTitle: "Phone Number",
                                          hintText: "Enter your phone number",
                                          controller: phoneNumberController,),
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(20),
                                  BuildTextField(
                                      enableEdit: enableEdit,
                                      fieldTitle: "Country",
                                      hintText: "Enter country",
                                      controller: countryController,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      MyFlexItem(
                        sizes: "lg-6",
                        child: Column(
                          children: [
                            MyCard(
                              shadow: MyShadow(elevation: 0.5),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    "Account Infomation",
                                    fontWeight: 600,
                                  ),
                                  StatefulBuilder(builder: (context, setState) {
                                    return Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        BuildTextField(
                                          enableEdit: widget.actionType == ActionType.create,
                                          fieldTitle: "Username",
                                          hintText: "",
                                          controller: userNameController,
                                        ),
                                        MySpacing.height(20),
                                        Visibility(
                                          visible: !changePassword && enableEdit,
                                          child: MyButton(
                                            onTap: () {
                                              setState(() {
                                                changePassword =
                                                !changePassword;
                                                print(changePassword);
                                              });
                                            },
                                            elevation: 0,
                                            padding: MySpacing.xy(20, 16),
                                            backgroundColor:
                                            ColorConst.mainColor,
                                            borderRadiusAll:
                                            AppStyle.buttonRadius.medium,
                                            child: MyText.bodySmall(
                                              'Change password',
                                              color: ColorConst.whiteColor,
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: changePassword && enableEdit,
                                          child: Column(
                                            children: [
                                              buildTextField(
                                                  fieldTitle: "Old Password",
                                                  hintText:
                                                  "Enter your old password",
                                                  controller: oldPasswordController,
                                                  obscure: true),
                                              MySpacing.height(20),
                                              buildTextField(
                                                  fieldTitle:
                                                  "Change Password",
                                                  hintText:
                                                  "Enter your password",
                                                  controller: newPassWordController,
                                                  obscure: true),
                                              MySpacing.height(20),
                                              buildTextField(
                                                  fieldTitle:
                                                  "Confirm Password",
                                                  hintText:
                                                  "Comfirm your password",
                                                  controller: newPassWordAgainController,
                                                  obscure: true),
                                              MySpacing.height(20),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  MyButton(
                                                    onTap: () {
                                                      setState(() {
                                                        changePassword = !changePassword;
                                                      });
                                                    },
                                                    elevation: 5,
                                                    padding: MySpacing.xy(20, 16),
                                                    backgroundColor: ColorConst.whiteColor,
                                                    borderRadiusAll: AppStyle.buttonRadius.medium,
                                                    child: MyText.bodySmall(
                                                      L10nX.getStr.cancel,
                                                      color: ColorConst.mainColor,
                                                    ),
                                                  ),
                                                  MySpacing.width(20),
                                                  MyButton(
                                                    onTap: () async {
                                                      if(newPassWordAgainController.text.isEmpty || newPassWordController.text.isEmpty || oldPasswordController.text.isEmpty)
                                                      {
                                                        ToastUtils.showToastError("Mật khẩu không được để trống");
                                                        return;
                                                      }
                                                      if(newPassWordAgainController.text != newPassWordController.text)
                                                        {
                                                          ToastUtils.showToastError("Mật khẩu mới và xác nhập mật khẩu mới không trùng nhau");
                                                          return;
                                                        }
                                                      MonitorLoading().showLoading("");
                                                      UpdateUpdatePasswordApi updateUpdatePasswordApi = UpdateUpdatePasswordApi(
                                                        userName: widget.userProfile?.userName??"",
                                                        oldpassword: oldPasswordController.text,
                                                        newpassword: newPassWordController.text
                                                      );
                                                      dynamic data = await updateUpdatePasswordApi.call();
                                                      MonitorLoading().dismiss();
                                                      if(data.runtimeType == String && (data as String).isEmpty)
                                                        {
                                                          setState(() {
                                                            changePassword = !changePassword;
                                                          },);
                                                        }
                                                    },
                                                    elevation: 0,
                                                    padding: MySpacing.xy(20, 16),
                                                    backgroundColor: ColorConst.mainColor,
                                                    borderRadiusAll: AppStyle.buttonRadius.medium,
                                                    child: MyText.bodySmall(
                                                      L10nX.getStr.str_update,
                                                      color: ColorConst.whiteColor,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },)
                                ],
                              ),
                            ),
                            MySpacing.height(16),
                            MyCard(
                              shadow: MyShadow(elevation: 0.5),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  MyText.titleMedium(
                                    "Billing Infomation",
                                    fontWeight: 600,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      BuildTextField(
                                          enableEdit: enableEdit,
                                          fieldTitle: "Bank Account",
                                          hintText:
                                          "Enter your Bank account",
                                      ),
                                      MySpacing.height(20),
                                      BuildTextField(
                                          enableEdit: enableEdit,
                                          fieldTitle: "Bank Name",
                                          hintText: "Enter your Bank Name",),
                                      MySpacing.height(20),
                                      Visibility(
                                        visible:  enableEdit,
                                        child: MyButton(
                                          onTap: () {},
                                          elevation: 0,
                                          padding: MySpacing.xy(20, 16),
                                          backgroundColor:
                                          ColorConst.mainColor,
                                          borderRadiusAll:
                                          AppStyle.buttonRadius.medium,
                                          child: MyText.bodySmall(
                                            'Change payment method',
                                            color: ColorConst.whiteColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },)
    );
  }
  Widget buildTextField(
      {
      bool? obscure,
      bool? onShowPassword,
      bool? enableEdit,
      required String fieldTitle,
      required String hintText,
      TextEditingController? controller,
      }) {
    enableEdit??= true;
    onShowPassword ??= false;
    obscure ??= false;
    return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText.labelMedium(
              fieldTitle,
            ),
            MySpacing.height(8),
            TextFormField(
              obscureText: obscure! && !onShowPassword!,
              controller: controller??TextEditingController(),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: MyTextStyle.bodySmall(xMuted: true),
                border: outlineInputBorder,
                enabledBorder: outlineInputBorder,
                focusedBorder: focusedInputBorder,
                contentPadding: MySpacing.all(16),
                isCollapsed: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: (obscure && onShowPassword!)
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            onShowPassword = !onShowPassword!;
                          });
                        },
                        icon: Icon(
                          Icons.visibility_off,
                          size: 20,
                        ))
                    : (obscure && !onShowPassword!)
                        ? IconButton(
                            onPressed: () {
                              setState(() {
                                onShowPassword = !onShowPassword!;
                              });
                            },
                            icon: Icon(
                              Icons.visibility,
                              size: 20,
                            ))
                        : SizedBox(),
              ),
            ),
          ],
        );
      }
    );
  }

  Widget customDropDownSearch({
    required List<int> list,
    required String hintText,
    required TextEditingController? controller,
    required bool enableEdit,
    String? value,
  }) {
    return DropdownSearch<int>(
      enabled: enableEdit,
      popupProps: PopupProps.menu(
        constraints: BoxConstraints(
          maxHeight:
              (65 + list.length * 50 < 210) ? 65 + list.length * 50 : 210,
        ),
        showSearchBox: true,
        searchDelay: Duration(milliseconds: 300),
        showSelectedItems: false,
      ),
      items: list.toList(),
      // selectedItem: selectItem ?? 0,
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          enabled: enableEdit,
          hintText: "Select $hintText",
          labelText: value,
          hintTextDirection: AppTheme.textDirection,
          border: outlineInputBorder,
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
      onChanged: (value) {
        controller?.text = (value ?? 0).toString();
      },
    );
  }

  int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }
  Future<UserProfile?> getUserProfile() async{
    if(widget.editSelfProfile??true)
      {
        widget.userProfile = UserManager().getUserProfile();
      }
      fullNameController.text = widget.userProfile?.fullName??"";
      birdthdayController.text = widget.userProfile?.birthday??"";
     //roleController.text = widget.userProfile?.roleId.toString()??"";
     genderController.text = widget.userProfile?.gender??"";
     phoneNumberController.text = widget.userProfile?.phoneNumber??"";
     countryController.text = widget.userProfile?.countryName??"";
     userNameController.text = widget.userProfile?.userName??"";
     billInfoController.text = widget.userProfile?.bankAccount??"";
     backNameController.text = widget.userProfile?.bankName??"";
      emailController.text = widget.userProfile?.email??"";

    return widget.userProfile;
  }
}

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');

    return newValue.copyWith(
      text: text.isNotEmpty ? text : '',
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
