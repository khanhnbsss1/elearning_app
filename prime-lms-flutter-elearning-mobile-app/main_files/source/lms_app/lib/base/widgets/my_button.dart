// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

enum MyButtonType { elevated, outlined, text }

class MyButton extends StatefulWidget {
  final MyButtonType? buttonType;

  final ButtonStyle? style;

  final void Function()? onTap;

  final bool? disabled;
  final bool? block;
  final bool soft;

  final WidgetStateProperty<EdgeInsetsGeometry>? msPadding;
  final EdgeInsetsGeometry? padding;

  final WidgetStateProperty<double>? msElevation;
  final double? elevation;

  final WidgetStateProperty<EdgeInsetsGeometry>? msShape;
  final OutlinedBorder? shape;
  final BorderRadiusGeometry? borderRadius;
  final double? borderRadiusAll;

  final WidgetStateProperty<Color>? msBackgroundColor;
  final Color? backgroundColor;

  final WidgetStateProperty<BorderSide>? msSide;
  final BorderSide? side;
  final Color borderColor;

  final MaterialTapTargetSize? tapTargetSize;

  final WidgetStateProperty<Color>? msShadowColor;
  final Color? shadowColor;

  final Color? splashColor;

  final Widget child;

  MyButton(
      {
        super.key,
        this.onTap,
        required this.child,
        this.msPadding,
        this.padding,
        this.msShape,
        this.shape,
        this.borderRadius,
        this.borderRadiusAll = 0,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.elevated,
        this.style,
        this.msShadowColor,
        this.msSide,
        this.side,
        this.borderColor = Colors.transparent,
        this.disabled = false,
        this.block = false,
        this.soft = false,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});

  MyButton.rounded(
      {super.key,
        required this.onTap,
        required this.child,
        this.msPadding,
        this.padding,
        this.msShape,
        this.shape,
        this.borderRadius,
        this.borderRadiusAll,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.elevated,
        this.style,
        this.block = false,
        this.msSide,
        this.disabled = false,
        this.side,
        this.soft = false,
        this.borderColor = Colors.transparent,
        this.msShadowColor,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});

  MyButton.small(
      {super.key,
        required this.onTap,
        required this.child,
        this.msPadding,
        this.padding = const EdgeInsets.fromLTRB(8, 4, 8, 4),
        this.msShape,
        this.shape,
        this.borderRadius,
        this.borderRadiusAll,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.elevated,
        this.style,
        this.block = false,
        this.msSide,
        this.soft = false,
        this.disabled = false,
        this.side,
        this.borderColor = Colors.transparent,
        this.msShadowColor,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});

  MyButton.medium(
      {
        super.key,
        required this.onTap,
        required this.child,
        this.msPadding,
        this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 16),
        this.msShape,
        this.block = false,
        this.shape,
        this.soft = false,
        this.borderRadius,
        this.borderRadiusAll,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.elevated,
        this.style,
        this.msSide,
        this.disabled = false,
        this.side,
        this.borderColor = Colors.transparent,
        this.msShadowColor,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});

  MyButton.text(
      {super.key,
        required this.onTap,
        required this.child,
        this.msPadding,
        this.padding = const EdgeInsets.all(0),
        this.msShape,
        this.block = false,
        this.shape,
        this.soft = false,
        this.borderRadius,
        this.borderRadiusAll,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.text,
        this.style,
        this.msSide,
        this.disabled = false,
        this.side,
        this.borderColor = Colors.transparent,
        this.msShadowColor,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});

  MyButton.block(
      {super.key,
        required this.onTap,
        required this.child,
        this.msPadding,
        this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 16),
        this.msShape,
        this.block = true,
        this.shape,
        this.soft = false,
        this.borderRadius,
        this.borderRadiusAll,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.elevated,
        this.style,
        this.msSide,
        this.disabled = false,
        this.side,
        this.borderColor = Colors.transparent,
        this.msShadowColor,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});

  MyButton.outlined(
      {super.key,
        required this.onTap,
        required this.child,
        this.msPadding,
        this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 16),
        this.msShape,
        this.soft = false,
        this.shape,
        this.borderRadius,
        this.borderRadiusAll,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.outlined,
        this.style,
        this.msSide,
        this.block = false,
        this.side,
        this.disabled = false,
        this.borderColor = Colors.transparent,
        this.msShadowColor,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});

  MyButton.large(
      {super.key,
        required this.onTap,
        required this.child,
        this.msPadding,
        this.padding = const EdgeInsets.fromLTRB(36, 20, 36, 20),
        this.msShape,
        this.shape,
        this.soft = false,
        this.borderRadius,
        this.borderRadiusAll,
        this.msBackgroundColor,
        this.backgroundColor,
        this.buttonType = MyButtonType.elevated,
        this.style,
        this.disabled = false,
        this.msSide,
        this.side,
        this.block = false,
        this.borderColor = Colors.transparent,
        this.msShadowColor,
        this.msElevation,
        this.elevation = 4,
        this.shadowColor,
        this.tapTargetSize = MaterialTapTargetSize.padded,
        this.splashColor});


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyButtonState();
  }
}
class MyButtonState extends State<MyButton>{
  @override
  Widget build(BuildContext context) {
    Widget button;
    Color bgColor = widget.backgroundColor ?? Theme.of(context).colorScheme.primary;

    if (widget.buttonType == MyButtonType.outlined) {
      button = OutlinedButton(
        onPressed: () {
          if(widget.onTap!=null)
          {
            widget.onTap!();
          }
        },
        style: widget.style ??
            ButtonStyle(
                tapTargetSize: widget.tapTargetSize,
                side: widget.msSide ??
                    WidgetStateProperty.all(widget.side ??
                        BorderSide(
                          color:
                          widget.soft ? widget.borderColor.withAlpha(100) : widget.borderColor,
                          width: widget.soft ? 0.8 : 1,
                        )),
                overlayColor: WidgetStateProperty.all(
                    widget.splashColor ?? (bgColor.withAlpha(40))),
                backgroundColor: widget.soft
                    ? WidgetStateProperty.all(widget.borderColor.withAlpha(40))
                    : null,
                foregroundColor:
                WidgetStateProperty.all(widget.borderColor.withAlpha(40)),
                shadowColor:
                widget.msShadowColor ?? WidgetStateProperty.all(widget.shadowColor),
                padding: widget.msPadding ?? WidgetStateProperty.all(widget.padding),
                shape: WidgetStateProperty.all(widget.shape ??
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          widget.borderRadiusAll ?? 4),
                    ))),
        child: widget.child,
      );
    } else if (widget.buttonType == MyButtonType.elevated) {
      button = ElevatedButton(
          style: widget.style ??
              ButtonStyle(
                  tapTargetSize: widget.tapTargetSize,
                  visualDensity: VisualDensity.compact,
                  elevation:widget. msElevation ??
                      WidgetStateProperty.resolveWith<double>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) {
                            return 0;
                          } else if (states.contains(WidgetState.pressed))
                            return widget.elevation! * 2;
                          else if (states.contains(WidgetState.hovered))
                            return widget.elevation! * 1.5;
                          return widget.elevation!;
                        },
                      ),
                  backgroundColor: widget.msBackgroundColor ??
                      WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled))
                            return bgColor.withAlpha(100);
                          return bgColor;
                        },
                      ),
                  shadowColor: widget.msShadowColor ??
                      WidgetStateProperty.all(widget.shadowColor ?? bgColor),
                  padding: widget.msPadding ?? WidgetStateProperty.all(widget.padding),
                  overlayColor: WidgetStateProperty.all(widget.splashColor ??
                      (Theme.of(context).colorScheme.onPrimary.withAlpha(36))),
                  shape: WidgetStateProperty.all(widget.shape ??
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(widget.borderRadiusAll ??
                            4),
                      ))),
          onPressed: () {
            if(widget.onTap!=null)
            {
              widget.onTap!();
            }
          },
          child:widget.child);
    } else {
      button = TextButton(
        style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(
                widget.splashColor ?? (bgColor.withAlpha(40))),
            padding: widget.msPadding ?? WidgetStateProperty.all(widget.padding),
            // visualDensity: VisualDensity.standard,

            tapTargetSize: widget.tapTargetSize),
        onPressed: () {
          if(widget.onTap!=null)
          {
            widget.onTap!();
          }
        },
        child: widget.child,
      );
    }

    return widget.block!
        ? Row(
      children: [
        Expanded(child: button),
      ],
    ) : button;
  }


}
