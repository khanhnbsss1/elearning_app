import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../helpers/theme/app_theme.dart';
import '../../../helpers/utils/ui_mixins.dart';
import '../../../helpers/widgets/my_text_style.dart';

class TagDropDown extends StatefulWidget {
  final List<String> tags; // List of tags

  TagDropDown({required this.tags});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<TagDropDown> with SingleTickerProviderStateMixin, UIMixin {
  List<String> selectedValues = [];
  Color color = Color.fromRGBO(163, 20, 19, 1.0);
  List<String> listOfTag = [];
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  child: DropdownButtonFormField(
                    menuMaxHeight: 500,
                    dropdownColor: theme.cardTheme.color,
                    decoration: InputDecoration(
                      label: Text('Select tags'),
                      labelStyle:
                      MyTextStyle.bodySmall(xMuted: true),
                      border: outlineInputBorder,
                      prefixIcon: Icon(
                        LucideIcons.tag,
                        size: 20,
                        // color: color,
                      ),
                      contentPadding: EdgeInsets.all(16),
                      isCollapsed: true,
                      floatingLabelBehavior:
                      FloatingLabelBehavior.never,
                    ),
                    items: widget.tags.map((tag) => DropdownMenuItem(
                      enabled: !selectedValues.contains(tag),
                      value: tag,
                      child: !selectedValues.contains(tag) ? Text(tag) : Text(tag),
                    )).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        (!selectedValues.contains(value) ? selectedValues.add(value!) : selectedValues.remove(value));
                      });
                    },
                    hint: Text('Select tags'),
                  ),
                ),
                SizedBox(width: 10,),
                IconButton(onPressed: (){
                  _addTagDialog();
                }, icon: Icon(Icons.add_circle_rounded, color: color,),
                )
              ]),
          SizedBox(height: 20,),
          Wrap(
            children: selectedValues.map((tag) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                deleteIconColor: color,
                label: Text(tag),
                onDeleted: () {
                  setState(() {
                    selectedValues.remove(tag);
                  });
                },
              ),
            )).toList(),
          ),
        ]
    );
  }

  void _addTagDialog() {
    final tagController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Add tags'),
        content: TextFormField(
          controller: tagController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: 'Add tag',
              labelStyle: MyTextStyle.bodySmall(xMuted: true),
              border: outlineInputBorder,
              contentPadding: EdgeInsets.all(16),
              isCollapsed: true,
              floatingLabelBehavior:
              FloatingLabelBehavior.never),
        ),
        actions: [
          TextButton(
            child: Text('Close', style: TextStyle(color: color),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Spacer(),

          TextButton(
            child: Text('Add tag', style: TextStyle(color: color),),
            onPressed: () {
              if (tagController.text.isNotEmpty) {
                if (widget.tags.contains(tagController.text)) {
                  _showErrorDialog('Tag already exists');
                } else {
                  setState(() {
                    widget.tags.add(tagController.text);
                  });
                  Navigator.of(context).pop();
                }
              } else {
                _showErrorDialog('Please enter a valid tag');
              }
            },
          ),
        ],
      ),
    );
  }


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}



// class TagDropDown extends StatefulWidget {
//   final List<String> tags; // List of tags
//
//   TagDropDown({required this.tags});
//
//   @override
//   _MyDropdownButtonState createState() => _MyDropdownButtonState();
// }
//
// class _MyDropdownButtonState extends State<TagDropDown> with SingleTickerProviderStateMixin, UIMixin {
//   List<String> selectedValues = [];
//   Color color = Color.fromRGBO(163, 20, 19, 1.0);
//   List<String> listOfTag = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: 200,
//                 child: DropdownSearch<String>(
//                   popupProps: PopupProps.dialog(
//                     dialogProps: DialogProps(
//
//                     ),
//                   showSearchBox: true,
//                   ),
//                   dropdownDecoratorProps: DropDownDecoratorProps(
//                     dropdownSearchDecoration: InputDecoration(
//                     border: outlineInputBorder,
//                     hintText: 'Select tags',
//                     prefixIcon: Icon(
//                       LucideIcons.tag,
//                       size: 20,
//                     ),
//                     contentPadding: EdgeInsets.all(16),
//                     isCollapsed: true,
//                     floatingLabelBehavior: FloatingLabelBehavior.never,
//                   ),
//                    ),
//                   onChanged: (String? value) {
//                     setState(() {
//                       (!selectedValues.contains(value) ? selectedValues.add(
//                           value!) : selectedValues.remove(value));
//                     });
//                   },
//                   items: widget.tags,
//                 )
//               ),
//               SizedBox(width: 10,),
//               IconButton(onPressed: (){
//                 _addTagDialog();
//               }, icon: Icon(Icons.add_circle_rounded, color: color,),
//               )
//             ],
//           ),
//           SizedBox(height: 20,),
//           Wrap(
//             children: selectedValues.map((tag) => Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: Chip(
//                 deleteIconColor: color,
//                 label: Text(tag),
//                 onDeleted: () {
//                   setState(() {
//                     selectedValues.remove(tag);
//                   });
//                 },
//               ),
//             )).toList(),
//           ),
//         ]
//     );
//   }
//
//   void _addTagDialog() {
//     final tagController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Add tags'),
//         content: TextFormField(
//           controller: tagController,
//           keyboardType: TextInputType.text,
//           decoration: InputDecoration(
//               labelText: 'Add tag',
//               labelStyle: MyTextStyle.bodySmall(xMuted: true),
//               border: outlineInputBorder,
//               contentPadding: EdgeInsets.all(16),
//               isCollapsed: true,
//               floatingLabelBehavior:
//               FloatingLabelBehavior.never),
//         ),
//         actions: [
//           TextButton(
//             child: Text('Close', style: TextStyle(color: color),),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//           Spacer(),
//
//           TextButton(
//             child: Text('Add tag', style: TextStyle(color: color),),
//             onPressed: () {
//               if (tagController.text.isNotEmpty) {
//                 if (widget.tags.contains(tagController.text)) {
//                   _showErrorDialog('Tag already exists');
//                 } else {
//                   setState(() {
//                     widget.tags.add(tagController.text);
//                   });
//                   Navigator.of(context).pop();
//                 }
//               } else {
//                 _showErrorDialog('Please enter a valid tag');
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//
//   void _showErrorDialog(String message) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         content: Text(message),
//         actions: [
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }