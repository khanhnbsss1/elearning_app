import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/apps/contact/edit_profile_controller.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/images.dart';
import 'package:webkit/views/apps/contacts/build_text_field.dart';
import 'package:webkit/views/layouts/layout.dart';

class EditUserProfile extends StatefulWidget {
  EditUserProfile({super.key, this.userProfile, this.actionType}){
    actionType??=ActionType.view;
  }
  UserProfile ?userProfile;
  ActionType? actionType;

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
  }

  final ImagePicker picker = ImagePicker();

  XFile? imageFile;
  bool changePassword = false;

  int? year;
  int? month;
  int? day;
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController dayController = TextEditingController();

  bool enableEdit = false;

  @override
  Widget build(BuildContext context) {
    UserProfile? userProfile = UserManager().getUserProfile();
    String fullName = userProfile?.fullName ?? "";
    String firstName = fullName
        .split(" ")
        .sublist(0, fullName.split(" ").length - 1)
        .join(" ");
    String lastName = fullName.split(" ").last;
    return Layout(
      showBackButton: true,
      child: Column(
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
                        onTap: () {
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
                        onTap: () {
                          setState(() {
                            enableEdit = false;
                          });
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
                          "User Infomation",
                          fontWeight: 600,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              imageFile = await picker.pickImage(
                                  source: ImageSource.gallery);
                              debugPrint(
                                  "imageFile!.path --------------------->>> ${imageFile!.path}");
                              setState(() {});
                            },
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                imageFile == null
                                    ? MyContainer.rounded(
                                    height: 150,
                                    width: 150,
                                    paddingAll: 0,
                                    clipBehavior: Clip
                                        .antiAliasWithSaveLayer,
                                    child: Image.asset(
                                      Images.avatars[0],
                                      fit: BoxFit.cover,
                                    ))
                                    : MyContainer.rounded(
                                  paddingAll: 0,
                                  clipBehavior: Clip
                                      .antiAliasWithSaveLayer,
                                  child: Image.file(
                                      File(imageFile!.path),
                                      fit: BoxFit.cover),
                                ),
                              ],
                            ),
                          ),
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
                                      fieldTitle: "First Name",
                                      hintText:
                                      "Enter your First Name",
                                      value: firstName),
                                ),
                                MySpacing.width(10),
                                Expanded(
                                  child: BuildTextField(
                                      enableEdit: enableEdit,
                                      fieldTitle: "Last Name",
                                      hintText:
                                      "Enter your Last Name",
                                      value: lastName),
                                ),
                              ],
                            ),
                            MySpacing.height(20),
                            BuildTextField(
                                enableEdit: enableEdit,
                                fieldTitle: "Identity Id",
                                hintText: "Enter your Identity",
                                value: userProfile?.identityId ?? ""),
                            MySpacing.height(20),
                            Row(
                              children: [
                                Expanded(
                                  child: BuildTextField(
                                      enableEdit: enableEdit,
                                      fieldTitle: "Role",
                                      hintText: "Enter your role",
                                      value: userProfile?.typeName ??
                                          "User"),
                                ),
                                MySpacing.width(10),
                                Expanded(
                                  child: BuildTextField(
                                      enableEdit: enableEdit,
                                      fieldTitle: "Gender",
                                      hintText: "Enter your gender",
                                      value: userProfile?.gender ??
                                          "Male"),
                                ),
                              ],
                            ),
                            MySpacing.height(20),
                            MyText.labelMedium("Birthday"),
                            MySpacing.height(4),
                            Row(
                              children: [
                                Expanded(
                                  child: customDropDownSearch(
                                    list: List<int>.generate(
                                      DateTime.now().year - 1970 + 1,
                                          (int index) =>
                                      DateTime.now().year - index,
                                    ),
                                    hintText: 'Year',
                                    controller: yearController,
                                    enableEdit: enableEdit,
                                  ),
                                ),
                                MySpacing.width(16),
                                ValueListenableBuilder(
                                  valueListenable: yearController,
                                  builder: (context, value, child) {
                                    return Expanded(
                                      child: customDropDownSearch(
                                        list: List<int>.generate(12,
                                                (int index) => 1 + index),
                                        hintText: 'Month',
                                        controller: monthController,
                                        enableEdit: enableEdit,
                                      ),
                                    );
                                  },
                                ),
                                MySpacing.width(16),
                                ValueListenableBuilder(
                                    valueListenable: monthController,
                                    builder: (context, value, child) {
                                      return Expanded(
                                        child: customDropDownSearch(
                                          list: (yearController.text
                                              .isNotEmpty &&
                                              monthController.text
                                                  .isNotEmpty)
                                              ? List<int>.generate(
                                              getDaysInMonth(
                                                  int.parse(
                                                      yearController
                                                          .text),
                                                  int.parse(
                                                      monthController
                                                          .text)),
                                                  (int index) =>
                                              1 + index)
                                              : [],
                                          hintText: 'Day',
                                          controller: dayController,
                                          enableEdit: enableEdit,
                                        ),
                                      );
                                    }),
                              ],
                            ),
                            MySpacing.height(20),
                            BuildTextField(
                                enableEdit: enableEdit,
                                fieldTitle: "Phone Number",
                                hintText: "Enter your phone number",
                                value:
                                userProfile?.phoneNumber ?? ""),
                            MySpacing.height(20),
                            BuildTextField(
                                enableEdit: enableEdit,
                                fieldTitle: "Country",
                                hintText: "Enter country",
                                value:
                                userProfile?.countryName ?? ""),
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
                            Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                BuildTextField(
                                  enableEdit: enableEdit,
                                  fieldTitle: "Username",
                                  hintText: "",
                                  value:
                                  userProfile?.userName ?? "",
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
                                          value: "",
                                          obscure: true),
                                      MySpacing.height(20),
                                      buildTextField(
                                          fieldTitle:
                                          "Change Password",
                                          hintText:
                                          "Enter your password",
                                          value: "",
                                          obscure: true),
                                      MySpacing.height(20),
                                      buildTextField(
                                          fieldTitle:
                                          "Confirm Password",
                                          hintText:
                                          "Comfirm your password",
                                          value: "",
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
                                              'Cancel',
                                              color: ColorConst.mainColor,
                                            ),
                                          ),
                                          MySpacing.width(20),
                                          MyButton(
                                            onTap: () {
                                              setState(() {

                                              });
                                            },
                                            elevation: 0,
                                            padding: MySpacing.xy(20, 16),
                                            backgroundColor: ColorConst.mainColor,
                                            borderRadiusAll: AppStyle.buttonRadius.medium,
                                            child: MyText.bodySmall(
                                              'Update password',
                                              color: ColorConst.whiteColor,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
                                    value: userProfile?.bankAccount ??
                                        ""),
                                MySpacing.height(20),
                                BuildTextField(
                                    enableEdit: enableEdit,
                                    fieldTitle: "Bank Name",
                                    hintText: "Enter your Bank Name",
                                    value:
                                    userProfile?.bankName ?? ""),
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
      ),
    );
  }
  Widget buildTextField(
      {
      bool? obscure,
      bool? onShowPassword,
      bool? enableEdit,
      required String fieldTitle,
      required String hintText,
      required String value}) {
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
              initialValue: value,
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
