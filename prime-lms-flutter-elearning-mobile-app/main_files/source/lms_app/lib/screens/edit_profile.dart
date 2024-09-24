import 'dart:typed_data';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms_app/base/author/user_helper.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/theme/theme_provider.dart';
import 'package:lms_app/utils/snackbars.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../components/user_avatar.dart';
import '../constants/custom_colors.dart';
import '../controller_elearning/edit_profile_controller.dart';
import '../models/user/UserProfile.dart';
import '../providers/user_data_provider.dart';
import '../services/apis/upload_file/models/upload_file_info.dart';
import '../services/apis/upload_file/upload_file_api.dart';

class EditProfile extends ConsumerStatefulWidget {
  final Function(bool)? onUpdate;

  const EditProfile({super.key, required this.user, this.onUpdate});

  final UserProfile user;

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late EditProfileController editProfileController;
  final _btnController = RoundedLoadingButtonController();
  final formKey = GlobalKey<FormState>();
  bool initController = false;
  Uint8List? _selectedImageFile;
  String? avatarId;
  String? _imageUrl;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    if (!initController) {
      editProfileController = EditProfileController(userProfile: widget.user);
      editProfileController.onInit();
      _imageUrl = widget.user.avatar;
    }
    selectedValue = editProfileController.basicValidator.getController('gender')!.text;
  }

  final List<String> items = [
    'Male',
    'Female',
    'Other',
  ];
  String? selectedValue;


  Future _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg']);
    MultipartFile file = MultipartFile.fromBytes(
        result!.files.first.bytes!,
        filename: result.names[0]);
    UploadAvatarApi uploadAvatarApi = UploadAvatarApi(
        fileInfo: UploadFileInfo(
            data: SubjectType.avatar,
            fileName: result.files.first.name,
            file: file));
    UploadFileResponseInfo? resultUpload = await uploadAvatarApi.call();
    if (resultUpload != UploadFileResponseInfo()) {
      setState(() {
        _imageUrl = resultUpload?.link!;
        editProfileController.basicValidator.getController('file_id')!.text = resultUpload!.id.toString();
      });
    } else {
      ToastUtils.showSnackBar(context, "Upload avatar failed");
    }
  }

  _handleUpdate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _btnController.start();
      bool check = await editProfileController.onUpdate();
      _btnController.reset();
      if (check) {
        setState(() => _selectedImageFile = null);
        widget.onUpdate!(true);
        Navigator.pop(context);
        ToastUtils.showToast('profile-updated'.tr());
      } else {
        ToastUtils.showToast('profile-failed'.tr());
      }
    }
  }

  List<String> genderList = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context)),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RoundedLoadingButton(
            controller: _btnController,
            elevation: 0,
            animateOnTap: false,
            color: Theme.of(context).primaryColor,
            child: Text(
              'update',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ).tr(),
            // onPressed: () => _handleUpdate(),
            onPressed: () {
              _handleUpdate();
            }),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: InkWell(
                  onTap: () => _pickImage(),
                  child: UserAvatar(
                    imageUrl: _imageUrl,
                    imageByte: _selectedImageFile,
                    iconSize: 40,
                    radius: 120,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text('name').tr(),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('fullname'),
                  decoration: InputDecoration(
                    hintText: 'enter-name'.tr(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Name is required';
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('gender').tr(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: isDarkMode
                              ? CustomColor.containerDark
                              : CustomColor.container,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              hint: Text(
                                'Select Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: items
                                  .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item.tr(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                  ),
                                ),
                              ))
                                  .toList(),
                              value: selectedValue == "" ? null : selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValue = value;
                                  editProfileController.basicValidator.getController('gender')!.text = value!;
                                });
                              },
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                                width: 140,
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('birthday').tr(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: isDarkMode
                              ? CustomColor.containerDark
                              : CustomColor.container,
                          child: TextFormField(
                            controller: editProfileController.basicValidator
                                .getController('birthday'),
                            decoration: InputDecoration(
                              suffix: InkWell(
                                  child: const Icon(
                                    Icons.calendar_month,
                                    size: 16,
                                  ),
                                  onTap: () async {
                                    _selectDate(context);
                                  }),
                              hintText: 'birthday'.tr(),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text('email').tr(),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('email'),
                  decoration: InputDecoration(
                    hintText: 'email'.tr(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('your-website').tr(),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('website'),
                  decoration: InputDecoration(
                    hintText: 'website'.tr(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('facebook').tr(),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('facebook'),
                  decoration: InputDecoration(
                    hintText: 'facebook'.tr(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),const SizedBox(height: 10),
              const Text('youtube').tr(),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('youtube'),
                  decoration: InputDecoration(
                    hintText: 'youtube'.tr(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),const SizedBox(height: 10),
              const Text('twitter').tr(),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('twitter'),
                  decoration: InputDecoration(
                    hintText: 'twitter'.tr(),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              // const Text('Bank name'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   color: isDarkMode
              //       ? CustomColor.containerDark
              //       : CustomColor.container,
              //   child: TextFormField(
              //     controller: editProfileController.basicValidator
              //         .getController('bank_name'),
              //     decoration: const InputDecoration(
              //       hintText: 'Enter your bank name',
              //       border: InputBorder.none,
              //       contentPadding:
              //           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 10),
              // const Text('Bank account'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   color: isDarkMode
              //       ? CustomColor.containerDark
              //       : CustomColor.container,
              //   child: TextFormField(
              //     controller: editProfileController.basicValidator
              //         .getController('bank_account'),
              //     decoration: const InputDecoration(
              //       hintText: 'Enter your bank account',
              //       border: InputBorder.none,
              //       contentPadding:
              //           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 10),
              // const Text('Identity id'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   color: isDarkMode
              //       ? CustomColor.containerDark
              //       : CustomColor.container,
              //   child: TextFormField(
              //     controller: editProfileController.basicValidator
              //         .getController('identity_id'),
              //     decoration: const InputDecoration(
              //       hintText: 'Enter your identity id',
              //       border: InputBorder.none,
              //       contentPadding:
              //           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 10),
              // const Text('Country name'),
              // const SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   color: isDarkMode
              //       ? CustomColor.containerDark
              //       : CustomColor.container,
              //   child: TextFormField(
              //     controller: editProfileController.basicValidator
              //         .getController('country_name'),
              //     decoration: const InputDecoration(
              //       hintText: 'Enter your country name',
              //       border: InputBorder.none,
              //       contentPadding:
              //           EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final List<DateTime?>? picked = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
        selectedDayHighlightColor: Colors.blue,
        closeDialogOnCancelTapped: true,
        firstDayOfWeek: 1,
        weekdayLabelTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        controlsTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        daySplashColor: Colors.transparent,
        centerAlignModePicker: true,
        customModePickerIcon: const SizedBox(),
      ),
      dialogSize: const Size(350, 300),
      borderRadius: BorderRadius.circular(15),
      dialogBackgroundColor: Colors.white,
    );
    if (picked != null && picked.isNotEmpty && picked[0] != null) {
      final DateFormat formatter = DateFormat('yyyy/MM/dd');
      final String formattedDate = formatter.format(picked[0]!);
      setState(() {
        editProfileController.basicValidator.getController('birthday')!.text =
            formattedDate;
      });
    }
  }
}
