import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class LoadingView extends StatelessWidget {
  final double size;
  final Color color;
  const LoadingView(
      {super.key, this.size = 20, this.color = Colors.red});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitThreeBounce(
      color: color,
      size: size,
    ));
  }
}
