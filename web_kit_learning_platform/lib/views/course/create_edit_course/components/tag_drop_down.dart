import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/services/apis/tags/models/tag_info.dart';
import 'package:webkit/views/tags/tag_list/components/add_tag.dart';

class TagDropDown extends StatefulWidget {
  final List<TagsInfo> allTags;
  final List<TagsInfo>? exitsTags;
  final Function(TagsInfo) onAddTags;
  final Function(TagsInfo) onRemoveTags;

  TagDropDown({required this.allTags, required this.onAddTags, required this.onRemoveTags, this.exitsTags});

  @override
  _MyDropdownButtonState createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<TagDropDown> with SingleTickerProviderStateMixin, UIMixin {
  Color color = Color.fromRGBO(163, 20, 19, 1.0);
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Dimens.size300,
                  height: Dimens.size45,
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownSearch<TagsInfo>(
                          popupProps: PopupProps.menu(
                            constraints: BoxConstraints(
                              maxHeight: (65 + widget.allTags.length * 50 < 210) ? 65 + widget.allTags.length * 50 : 210,
                            ),
                            showSearchBox: true,
                            searchDelay: Duration(seconds: 0),
                            itemBuilder: (context, item, isSelected) {
                              return ListTile(
                                title: Text(item.name??'',style: TextStyleConstant.textStyleBlack14w400,),
                              );
                            },
                            //showSelectedItems: true,
                          ),
                          items: widget.allTags,
                          itemAsString: (item) => item.name??"",
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              hintText: 'Select tags',
                              hintStyle: TextStyleConstant.textStyleBlack13w400,
                              alignLabelWithHint: true,
                              floatingLabelAlignment: FloatingLabelAlignment.center,
                              border: outlineInputBorder,
                              prefixIcon: Icon(
                                LucideIcons.book,
                                size: Dimens.size20,
                                color: ColorConst.colorIconRed,
                              ),
                              contentPadding: MySpacing.xy(Dimens.size16, Dimens.size12),
                              floatingLabelBehavior:
                              FloatingLabelBehavior.never,
                              suffixIconConstraints: BoxConstraints(
                                minHeight: Dimens.size40,
                                maxHeight: Dimens.size40,
                              ),
                            ),
                          ),
                          dropdownButtonProps: DropdownButtonProps(
                              padding: EdgeInsets.zero,
                            
                          ),
                          onChanged: (value) {
                            if(value!=null && [...(widget.exitsTags??[]).where((element) {return element.id == value.id;},)].isEmpty)
                              {
                                setState(() {
                                 // widget.exitsTags?.add(value);
                                  widget.onAddTags(value);
                              });
                              }
                      
                            },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                IconButton(onPressed: (){
                  AddTagPage(tagPageAction: TagPageAction.create,).show(context, callBack: (value) {
                    widget.onAddTags(value);
                  },);
                }, icon: Icon(Icons.add_circle_rounded, color: color,),
                )
              ]),
          SizedBox(height: 20,),
          Wrap(
            children: (widget.exitsTags??[]).map((tag) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Chip(
                deleteIconColor: color,
                label: Text(tag.name??''),
                onDeleted: () {
                  setState(() {
                    widget.onRemoveTags(tag);
                  });
                },
              ),
            )).toList(),
          ),
        ]
    );
  }
}

