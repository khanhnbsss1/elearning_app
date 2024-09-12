import 'package:flutter/material.dart';

class ProgressionBar extends StatefulWidget {
  final Color? activeColor, inactiveColor;
  final double? progress, height, width, radius;

  const ProgressionBar(
      {this.activeColor = Colors.blue,
        this.inactiveColor = Colors.grey,
        required this.progress,
        this.height,
        this.width,
        this.radius});

  @override
  State<ProgressionBar> createState() => _ProgressionBarState();
}

class _ProgressionBarState extends State<ProgressionBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width??200,
        height: widget.height??20,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(widget.radius??12))),
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              width: (widget.width??200) * (widget.progress??0),
              height: widget.height,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius:
                  BorderRadius.all(Radius.circular(widget.radius??12))),
            )
          ],
        ),
      ),
    );
  }
}
