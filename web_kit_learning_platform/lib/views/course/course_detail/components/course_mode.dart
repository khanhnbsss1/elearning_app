import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter/services.dart';
import '../../../../base/theme/colors_app.dart';
import '../../../../controller/ui/add_course_controller.dart';
import '../../../../helpers/theme/app_theme.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text.dart';
import '../../../../helpers/widgets/my_text_style.dart';


class ModeOptionWidget extends StatefulWidget {
  final String? mode;
  final void Function(String?) onModeChanged;
  final void Function(int?) onPaymentChanged;
  bool disablePremiumMode = false;
  bool disablePayment = false;

  ModeOptionWidget({required this.mode, required this.onModeChanged, required this.onPaymentChanged,required this.disablePayment, required this.disablePremiumMode});
  @override
  _ModeOptionWidget createState() => _ModeOptionWidget();
}

class _ModeOptionWidget extends State<ModeOptionWidget> {
  TextEditingController controller = new TextEditingController();
  String? _mode;
  @override
  void initState() {
    super.initState();
    _mode = widget.mode??'PREMIUM';
  }
  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<AddCourseController>();

    // return widget.mode == Mode.PREMIUM ?
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyText.labelMedium(
          'Payment *',
        ),
        MySpacing.height(4),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ListTile(
                title: const Text('FREE'),
                leading: Radio<String>(
                  value: 'FREE',
                  groupValue: _mode,
                  onChanged: (String? value) {
                    setState(() {
                      _mode = value;
                      widget.onModeChanged(value);
                    });
                  },
                ),
              ),
            ),
            (widget.disablePremiumMode != true) ? Expanded(
              flex: 4,
              child: ListTile(
                title: const Text('PREMIUM'),
                leading: Radio<String>(
                  value: 'PREMIUM',
                  groupValue: _mode,
                  onChanged: (String? value) {
                    setState(() {
                      _mode = value;
                      widget.onModeChanged(value);
                    });
                  },
                ),
              ),
            ) : SizedBox(),
              Expanded(
              flex: 3,
              child: (widget.disablePayment != true) ? SizedBox(
                child: Container(
                  color: ColorConst.whiteColor,
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    enabled: _mode == 'PREMIUM',
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: (_mode == 'PREMIUM')
                            ? Colors.black87
                            : Colors.black12,
                      ),
                      labelText: 'Payment',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value){
                      widget.onPaymentChanged(value as int?);
                    },
                  ),
                ),
              ): SizedBox(),
            ) ,
          ],
        ),
      ],
    );
  }
}
