import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGridView extends StatefulWidget {
  List<Widget> item;

  MyGridView({super.key, required this.item});

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        width: width - 250 - 32,
        height: height - 35,
        child: SingleChildScrollView(child: widget.item.first),
      ),
    );
  }
}
