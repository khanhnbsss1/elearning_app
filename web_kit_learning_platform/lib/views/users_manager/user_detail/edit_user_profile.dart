import 'dart:io';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/helper/date_time/date_time_helper.dart';
import 'package:webkit/base/permission/permisstion.dart';
import 'package:webkit/base/widgets/time_setting/date_time_picker.dart';
import 'package:webkit/base/widgets/widget_common/widget_with_title_common.dart';
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
import 'package:webkit/services/apis/roles/models/roles_info.dart';
import 'package:webkit/services/apis/roles/update_user_role_api.dart';
import 'package:webkit/services/apis/user/get_user_detail_api.dart';
import 'package:webkit/services/apis/user/update_password_api.dart';
import 'package:webkit/services/apis/user/user_manager/add_user_api.dart';
import 'package:webkit/services/apis/user/user_manager/update_other_user_api.dart';
import 'package:webkit/services/apis/user/user_manager/update_seft_user_api.dart';
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
  late String roleId;
  late String oldRoleId;

  @override
  void initState() {
    super.initState();
    controller = Get.put(EditProfileController());
    if(widget.actionType != ActionType.view)
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
  TextEditingController positionController = TextEditingController();
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
        isScroll: false,
      child: FutureBuilder(
          future: getUserProfile(), 
          builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return SizedBox(
                child:  Center(
                  child: NoData(),
                ),
              );
            }
            widget.userProfile = snapshot.data;
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Dimens.size16, horizontal: Dimens.size24),
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
                                L10nX.getStr.edit_str,
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
                                widget.userProfile?.position = positionController.text;
                                widget.userProfile?.bankAccount = billInfoController.text;
                                widget.userProfile?.bankName = backNameController.text;
                                widget.userProfile?.email = emailController.text;
                                widget.userProfile?.roleId = roleId;
                                dynamic updateUserApi;
                                if((widget.editSelfProfile??true)){
                                  updateUserApi = UpdateSeftUserApi(info: widget.userProfile!);
                                }
                                else if(!(widget.editSelfProfile??true) && widget.actionType == ActionType.edit)
                                  {
                                    updateUserApi = UpdateOtherUserApi(info: widget.userProfile!);
                                  }
                                else if(!(widget.editSelfProfile??true) &&  widget.actionType == ActionType.create)
                                  {
                                    if(newPassWordAgainController.text != newPassWordController.text && (widget.editSelfProfile??true))
                                    {
                                      ToastUtils.showToastError("Mật khẩu mới và xác nhập mật khẩu mới không trùng nhau");
                                      return;
                                    }
                                    widget.userProfile?.password = newPassWordAgainController.text;
                                    widget.userProfile?.userName = phoneNumberController.text;
                                    updateUserApi = AddUserApi(info: widget.userProfile!);
                                  }
                                if(updateUserApi!=null)
                                  {
                                    MonitorLoading().showLoading("");
                                    dynamic data = await updateUserApi.call();
                                    if(data.runtimeType == String && (data as String).isEmpty)
                                    {
                                      if(roleId != oldRoleId && widget.userProfile!.id!=null)
                                        {
                                          UpdateUserRoleApi updateUserRoleApi = UpdateUserRoleApi(userId: widget.userProfile!.accountId!, roleId: roleId,);
                                          dynamic data = await updateUserRoleApi.call();
                                        }
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
                                L10nX.getStr.save,
                                color: ColorConst.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
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
                                               // clipBehavior: Clip.hardEdge,
                                                child: Stack(
                                                  children: [
                                                    ImageManager().getImageByUrl(
                                                        widget.userProfile?.avatar??"",
                                                        errorBuilder: Icon(  
                                                          widget.userProfile?.gender== "Male"? 
                                                          Icons.face:Icons.face_2, size: Dimens.size150, color: ColorConst.colorIconRed,)
                                                    ),
                                                    Visibility(
                                                      visible: enableEdit,
                                                      child: Align(
                                                        alignment: Alignment.topRight,
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: ColorConst.greyColor.withOpacity(0.2),
                                                            borderRadius: BorderRadius.circular(Dimens.size20)
                                                          ),
                                                            width: Dimens.size30,
                                                            height: Dimens.size30,
                                                            alignment: Alignment.center,
                                                            child: Icon(
                                                              Icons.edit, 
                                                              size: Dimens.size20, 
                                                              color: ColorConst.blackColor,)),
                                                      ),
                                                    )
                                                  ]
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
                                                hintText: "Enter your Fulle Name",
                                                controller: fullNameController,),
                                          ),
                                          MySpacing.width(20),
                                          Expanded(
                                            child: StatefulBuilder(
                                              builder: (BuildContext context, void Function(void Function()) setState) {
                                              return roleDropDownSearch(
                                                  enableEdit: (widget.editSelfProfile??true)?false:enableEdit,
                                                  onChange: (p0) {
                                                    setState(() {
                                                      roleId = p0!.id!;
                                                    });
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      MySpacing.height(20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: BuildTextField(
                                                enableEdit: enableEdit,
                                                fieldTitle: "Gender",
                                                hintText: "Enter your gender",
                                                controller: genderController,
                                            ),
                                          ),
                                          MySpacing.width(20),
                    
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
                                          MySpacing.width(20),
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
                                          fieldTitle: L10nX.getStr.positions,
                                          hintText: L10nX.getStr.positions,
                                          controller: positionController,),
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
                                      MySpacing.height(20),
                                      StatefulBuilder(builder: (context, setState) {
                                        return Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Visibility(
                                              visible: widget.userProfile?.id != null,
                                              child: BuildTextField(
                                                enableEdit: false,
                                                fieldTitle: "Username",
                                                hintText: "",
                                                controller: userNameController,
                                              ),
                                            ),
                                            MySpacing.height(20),
                                            Visibility(
                                              visible: !changePassword && enableEdit && (widget.userProfile?.id!=null),
                                              child: MyButton(
                                                onTap: () {
                                                  setState(() {
                                                    changePassword = !changePassword;
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
                                              visible: (changePassword && enableEdit) || (widget.userProfile?.id==null),
                                              child: Column(
                                                children: [
                                                  Visibility(
                                                    visible: (widget.editSelfProfile??true),
                                                    child: Column(
                                                      children: [
                                                        buildTextField(
                                                            fieldTitle: "Old Password",
                                                            hintText:
                                                            "Enter your old password",
                                                            controller: oldPasswordController,
                                                            obscure: true),
                                                        MySpacing.height(20),
                                                      ],
                                                    ),
                                                  ),
                                                  buildTextField(
                                                      fieldTitle:
                                                      "New Password",
                                                      hintText:
                                                      "Enter your new password",
                                                      controller: newPassWordController,
                                                      obscure: true),
                                                  MySpacing.height(20),
                                                  buildTextField(
                                                      fieldTitle:
                                                      "Confirm New Password",
                                                      hintText:
                                                      "Confirm your new password",
                                                      controller: newPassWordAgainController,
                                                      obscure: true),
                                                  MySpacing.height(20),
                                                  Visibility(
                                                    visible: widget.userProfile?.id!=null,
                                                    child: Row(
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
                                                            if(newPassWordAgainController.text.isEmpty || 
                                                                newPassWordController.text.isEmpty ||
                                                                (oldPasswordController.text.isEmpty && (widget.editSelfProfile??true)))
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
                                                    ),
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
                                            controller: billInfoController,
                                          ),
                                          MySpacing.height(20),
                                          BuildTextField(
                                              enableEdit: enableEdit,
                                              fieldTitle: "Bank Name",
                                              controller: backNameController,
                                              hintText: "Enter your Bank Name",),
                                          MySpacing.height(20),
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

  Widget roleDropDownSearch({
    required bool enableEdit,
    String? value,
    Function(RoleInfo?)?onChange
  }) {
    return WidgetWithColumnTitleCommon(
      title: L10nX.getStr.role_str,
      child: FutureBuilder(
        future: PermissionManager().getRoleModel(),
        builder: (context, snapshot) {
          RolesListResponseModel? rolesListResponseModel = RolesListResponseModel(content: []);
          if(snapshot.hasData){
            rolesListResponseModel = snapshot.data?? RolesListResponseModel(content: []);
          }
          RoleInfo? selectedItem;
          if(widget.userProfile?.id!=null)
            {
              if((rolesListResponseModel.content??[]).where((element) => element.id == widget.userProfile?.roleId,).isNotEmpty)
                {
                  selectedItem = (rolesListResponseModel.content??[]).firstWhere((element) => element.id == widget.userProfile?.roleId ,);
                }
            }
          
          return SizedBox(
            height: Dimens.size40,
            child: DropdownSearch<RoleInfo>(
              enabled: enableEdit,
              
              popupProps: PopupProps.menu(
                constraints: BoxConstraints(
                  maxHeight: (65 + (rolesListResponseModel.content??[]).length * 50 < 210) ? 65 + (rolesListResponseModel.content??[]).length * 50 : 210,
                ),
                showSearchBox: true,
                searchDelay: Duration(milliseconds: 300),
                showSelectedItems: false,
              ),
              items: (filter, loadProps) => (rolesListResponseModel?.content??[]).toList(),
              selectedItem: selectedItem,

              decoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  enabled: enableEdit,
                  constraints: BoxConstraints(
                    maxHeight: Dimens.size40
                  ),
                  prefixIconConstraints: BoxConstraints(
                      maxHeight: Dimens.size40
                  ),
                  hintText: "Select ${L10nX.getStr.role_str.toLowerCase()}",
                  labelText: value,
                  hintTextDirection: AppTheme.textDirection,
                  border: outlineInputBorder,
                  contentPadding: MySpacing.all(Dimens.size16),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              itemAsString: (item) => item.name??"",
              onChanged: (value) {
                if(onChange!=null)
                  {
                    onChange(value);
                  }
              },
              suffixProps: DropdownSuffixProps(
                dropdownButtonProps: DropdownButtonProps(
                  padding: EdgeInsets.zero,
                  style: ButtonStyle(
                      textStyle: WidgetStatePropertyAll(TextStyleConstant.textStyleBlack13w400,)
                  ),
                  constraints: BoxConstraints(
                    minHeight: Dimens.size20,
                    maxHeight: Dimens.size40,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
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
     positionController.text = widget.userProfile?.position??"";
     userNameController.text = widget.userProfile?.userName??"";
     billInfoController.text = widget.userProfile?.bankAccount??"";
     backNameController.text = widget.userProfile?.bankName??"";
      emailController.text = widget.userProfile?.email??"";
      oldRoleId = widget.userProfile?.roleId??'';
      roleId = widget.userProfile?.roleId??'';

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
