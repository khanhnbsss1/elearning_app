import 'package:flutter/material.dart';

class ProgressionBar extends StatefulWidget {
  final Color activeColor, inactiveColor;
  final double progress, height, width, radius;

  const ProgressionBar(
      {this.activeColor = Colors.blue,
        this.inactiveColor = Colors.grey,
        this.progress = 1,
        this.height = 1,
        this.width = 100,
        this.radius = 4});

  @override
  State<ProgressionBar> createState() => _ProgressionBarState();
}

class _ProgressionBarState extends State<ProgressionBar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
        child: Stack(
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              width: widget.width * widget.progress,
              height: widget.height,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius:
                  BorderRadius.all(Radius.circular(widget.radius))),
            )
          ],
        ),
      ),
    );
  }
}
