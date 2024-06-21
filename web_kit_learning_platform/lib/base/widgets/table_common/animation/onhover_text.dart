import 'package:flutter/material.dart';

// Cách sử dụng
// OnHover( builder: (bool isHovered) {
// final color = isHovered ? Colors.red : ColorConst.blackColor;
// return child);

class OnHoverText extends StatefulWidget {

  final Widget Function(bool isHovered) builder;

  const OnHoverText({super.key, required this.builder});

  @override
  OnHoverTextState createState() => OnHoverTextState();
}

class OnHoverTextState extends State<OnHoverText> {

  bool isHovered = false;
  @override
  Widget build(BuildContext context) {

    final hovered = Matrix4.identity()..translate(0,-5,0);
    final transform = isHovered ? hovered : Matrix4.identity();

    return MouseRegion(
      onEnter: (_)=> onEntered(true),
      onExit: (_)=> onEntered(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: transform,
        child: widget.builder(isHovered),
      ),
    );
  }

  void onEntered(bool isHovered){
    setState(() {
      this.isHovered = isHovered;
    });
  }
}