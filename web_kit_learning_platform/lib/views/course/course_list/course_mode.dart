import 'package:flutter/material.dart';

import '../../../helpers/theme/app_theme.dart';
import '../../../helpers/widgets/my_spacing.dart';
import '../../../helpers/widgets/my_text.dart';
import '../../../helpers/widgets/my_text_style.dart';

class ModeOptionWidget extends StatefulWidget {
  @override
  _ModeOptionWidget createState() => _ModeOptionWidget();
}

class _ModeOptionWidget extends State<ModeOptionWidget> {
  String? _selectedOption = 'Free';
  bool _isPremium = false;
  final _paymentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MyText.labelMedium(
          'Payment',
        ),
        MySpacing.height(4),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                dropdownColor: theme.cardTheme.color,
                decoration: InputDecoration(
                  labelText: 'Select Option',
                  labelStyle: MyTextStyle.bodySmall(xMuted: true),
                  border: OutlineInputBorder(),
                  contentPadding: MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                value: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                    _isPremium = value == 'Premium';
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'Free',
                    child: Text('Free'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Premium',
                    child: Text('Premium'),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: _paymentController,
                enabled: _isPremium,
                decoration: InputDecoration(
                  labelText: 'Payment Information',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}