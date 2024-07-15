
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  const PaginationWidget({super.key});

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  int? page = 1;
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 0,
      children: List<Widget>.generate(10,
            (int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: SizedBox(
              height: 30,
              width: 30,
              child: FloatingActionButton(
                mini: true,
                shape: CircleBorder(
                    side: BorderSide(style: BorderStyle.solid)),
                foregroundColor: isSelected? Colors.white : Colors.black,
                backgroundColor: isSelected? Colors.blue : Colors.grey, // change text color
                onPressed: () {
                  setState(() {
                    isSelected =!isSelected;
                  });
                },
                child: Text('${index + 1}'),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}


