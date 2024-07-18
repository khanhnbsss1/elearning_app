import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../base/theme/colors_app.dart';
import '../../../../controller/ui/add_course_controller.dart';
import '../../../../helpers/theme/app_theme.dart';
import '../../../../helpers/widgets/my_spacing.dart';
import '../../../../helpers/widgets/my_text.dart';
import '../../../../helpers/widgets/my_text_style.dart';


class ModeOptionWidget extends StatefulWidget {
  final String? mode;
  final void Function(String?) onChanged;

  ModeOptionWidget({required this.mode, required this.onChanged,});
  @override
  _ModeOptionWidget createState() => _ModeOptionWidget();
}

class _ModeOptionWidget extends State<ModeOptionWidget> {

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
                    });
                    widget.onChanged(value);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListTile(
                enabled: widget.mode == 'PREMIUM',
                title: const Text('PREMIUM'),
                leading: Radio<String>(
                  value: 'PREMIUM',
                  groupValue: _mode,
                  onChanged: (String? value) {
                    setState(() {
                      _mode = value;
                    });
                    widget.onChanged(value);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                child: Container(
                  color: ColorConst.whiteColor,
                  child: TextFormField(
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
