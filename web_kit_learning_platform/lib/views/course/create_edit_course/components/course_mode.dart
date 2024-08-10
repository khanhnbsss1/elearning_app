import 'package:flutter/material.dart';
import 'package:webkit/base/base.export.dart';
import '../../../../helpers/widgets/my_spacing.dart';

class ModeOptionWidget extends StatefulWidget {
  final String? mode;
  final void Function(String?) onModeChanged;
  final void Function(int?) onPaymentChanged;
  bool? disablePremiumMode;
  bool? disablePayment;

  ModeOptionWidget(
      {required this.mode,
      required this.onModeChanged,
      required this.onPaymentChanged,
      this.disablePayment,
      this.disablePremiumMode}) {
    disablePayment ??= false;
    disablePremiumMode ??= false;
  }

  @override
  _ModeOptionWidget createState() => _ModeOptionWidget();
}

class _ModeOptionWidget extends State<ModeOptionWidget> {
  TextEditingController controller = new TextEditingController();
  String? _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.mode ?? 'PREMIUM';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('${L10nX.getStr.payment_str}: *',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyleConstant.textStyleBlack13w500.copyWith(fontWeight: FontWeight.w600)),
        MySpacing.height(4),
        Row(
          children: [
            Expanded(
              flex: 3,
              child: ListTile(
                title:  Text(L10nX.getStr.free_str),
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
            (widget.disablePremiumMode != true)
                ? Expanded(
                    flex: 4,
                    child: ListTile(
                      title:  Text(L10nX.getStr.premium_str),
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
                  )
                : SizedBox(),
            /*Expanded(
              flex: 3,
              child: (widget.disablePayment != true)
                  ? SizedBox(
                      child: Container(
                        color: ColorConst.whiteColor,
                        child: TextFormField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          inputFormatters: [ 
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
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
                          onChanged: (value) {
                            widget.onPaymentChanged(value as int?);
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
            ),*/
          ],
        ),
      ],
    );
  }
}
