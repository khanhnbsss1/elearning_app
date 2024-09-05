import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/base/base.export.dart';
import 'package:lms_app/models/user/UserProfile.dart';

import '../base/widgets/common/alert_dialog/loading.common.dart';
import '../base/widgets/my_button.dart';
import '../base/widgets/toast_common/toast_utils.dart';
import '../constants/custom_colors.dart';
import '../services/apis/user/user_manager/update_password_api.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.userProfile});

  final UserProfile userProfile;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    bool changePassword = false;
    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPassWordController = TextEditingController();
    TextEditingController newPassWordAgainController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('change-password'.tr(),
        style: Theme.of(context).textTheme.titleLarge,),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("old-password".tr()),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: CustomColor.container,
              child: TextFormField(
                controller: oldPasswordController,
                decoration: InputDecoration(
                  hintText: "enter-old-password".tr(),
                  border: InputBorder.none,
                  contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text("new-password".tr()),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: CustomColor.container,
              child: TextFormField(
                controller: newPassWordController,
                decoration: InputDecoration(
                  hintText: "enter-new-password".tr(),
                  border: InputBorder.none,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text("confirm-password".tr()),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: CustomColor.container,
              child: TextFormField(
                controller: newPassWordAgainController,
                decoration: InputDecoration(
                  hintText: "confirm-new-password".tr(),
                  border: InputBorder.none,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  elevation: 5,
                  child: Text('cancel'.tr(), style: const TextStyle(
                    color: Colors.white,
                  ),),
                ),
                const SizedBox(
                  width: 10,
                ),
                MyButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  onTap: () async {
                    if(newPassWordAgainController.text.isEmpty ||
                        newPassWordController.text.isEmpty ||
                        oldPasswordController.text.isEmpty )
                    {
                      ToastUtils.showToastError("password-empty".tr());
                      return;
                    }
                    if(newPassWordAgainController.text != newPassWordController.text)
                    {
                      ToastUtils.showToastError("password-not-match".tr());
                      return;
                    }
                    UpdateUpdatePasswordApi updateUpdatePasswordApi = UpdateUpdatePasswordApi(
                        userName: widget.userProfile.userName??"",
                        oldpassword: oldPasswordController.text,
                        newpassword: newPassWordController.text
                    );
                    dynamic data = await updateUpdatePasswordApi.call();
                    if(data.runtimeType == String && (data as String).isEmpty)
                    {
                      setState(() {
                        changePassword = !changePassword;
                      },);
                    }
                  },
                  elevation: 0,
                  child: Text('confirm'.tr(), style: const TextStyle(
                    color: Colors.white,
                  ),),
                ),
              ],
            ),],
        ),
      ),
    );
  }
}
