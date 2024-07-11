import 'package:flutter/material.dart';

import '../../../base/theme/colors_app.dart';
import '../../../helpers/theme/app_theme.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';

enum Mode { FREE, PREMIUM }

class ModeOptionWidget extends StatefulWidget {
  @override
  _ModeOptionWidget createState() => _ModeOptionWidget();
}

class _ModeOptionWidget extends State<ModeOptionWidget> {
  String? _selectedOption = 'Free';
  bool _isPremium = false;
  final _paymentController = TextEditingController();
  Mode? _mode = Mode.FREE;

  @override
  Widget build(BuildContext context) {
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
                leading: Radio<Mode>(
                  value: Mode.FREE,
                  groupValue: _mode,
                  onChanged: (Mode? value) {
                    setState(() {
                      _mode = value;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: ListTile(
                title: const Text('PREMIUM'),
                leading: Radio<Mode>(
                  value: Mode.PREMIUM,
                  groupValue: _mode,
                  onChanged: (Mode? value) {
                    setState(() {
                      _mode = value;
                    });
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
                    controller: _paymentController,
                    enabled: _mode == Mode.PREMIUM,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.attach_money,
                        color: (_mode == Mode.PREMIUM)
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
