import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms_app/base/widgets/toast_common/toast_utils.dart';
import 'package:lms_app/models/user_model.dart';
import 'package:lms_app/screens/home/home_view.dart';
import 'package:lms_app/screens/tabs/profile_tab/profile_tab.dart';
import 'package:lms_app/services/firebase_service.dart';
import 'package:lms_app/services_elearning/apis/user/get_user_detail_api.dart';
import 'package:lms_app/theme/theme_provider.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:lms_app/utils/snackbars.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../components/user_avatar.dart';
import '../constants/custom_colors.dart';
import '../controller_elearning/edit_profile_controller.dart';
import '../models_elearning/user/UserProfile.dart';
import '../providers/user_data_provider.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key, required this.user});

  final UserProfile user;

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late EditProfileController editProfileController;
  final _btnController = RoundedLoadingButtonController();
  final formKey = GlobalKey<FormState>();
  bool initController = false;
  XFile? _selectedImageFile;
  String? _imageUrl;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    if (!initController) {
      editProfileController = EditProfileController(userProfile: widget.user);
      editProfileController.onInit();
    };
  }

  Future _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (image != null) {
      _selectedImageFile = image;
      setState(() {});
    }
  }

  Future<String?> _getUserImage() async {
    if (_selectedImageFile != null) {
      final String? imageUrl =
          await FirebaseService().uploadImageToHosting(_selectedImageFile!);
      return imageUrl;
    } else {
      return widget.user.imageUrl;
    }
  }

  UserModel _userData(String? imageUrl) {
    UserModel userModel = UserModel(
      id: widget.user.id.toString(),
      email: widget.user.email!,
      name: editProfileController.basicValidator.getController('name')!.text,
      imageUrl: imageUrl,
      updatedAt: DateTime.now().toUtc(),
    );
    return userModel;
  }

  _handleUpdate() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      _btnController.start();
      bool check = await editProfileController.onUpdate();
      // final String? imageUrl = await _getUserImage();
      // // await FirebaseService().updateUserProfile(_userData(imageUrl));
      // await ref.read(userDataProvider.notifier).getData();
      // Navigator.pop(context, true);
      _btnController.reset();
      if (check) {
        await ref.read(userDataProvider.notifier).getData();
        setState(() => _selectedImageFile = null);
        Navigator.pop(context);
        openSnackbar(context, 'Profile updated');
      } else {
        openSnackbar(context, 'Profile failed');
      }
    }
  }

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
          }
        ),
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
                    imageFile: _selectedImageFile,
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
              const SizedBox(height: 10),
              const Text('Bank name'),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('bank_name'),
                  decoration: const InputDecoration(
                    hintText: 'Enter your bank name',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Bank account'),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('bank_account'),
                  decoration: const InputDecoration(
                    hintText: 'Enter your bank account',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Identity id'),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('identity_id'),
                  decoration: const InputDecoration(
                    hintText: 'Enter your identity id',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Phone number'),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: isDarkMode
                    ? CustomColor.containerDark
                    : CustomColor.container,
                child: TextFormField(
                  controller: editProfileController.basicValidator
                      .getController('phone_number'),
                  decoration: const InputDecoration(
                    hintText: 'Enter your phone number',
                    border: InputBorder.none,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
