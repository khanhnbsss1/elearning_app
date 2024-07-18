
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/services/apis/course/course_fillter/models/course_filtter_info.dart';

class FilterCoursePopupMenu extends StatefulWidget {
  FilterCoursePopupMenu({super.key, this.onSelect});
  Function(CourseFilterInfo)? onSelect;
  @override
  State<FilterCoursePopupMenu> createState() => _FilterCoursePopupMenuState();
}

class _FilterCoursePopupMenuState extends State<FilterCoursePopupMenu> {
  CourseFilterInfo? selectedItem;
  late CourseFilterListInfo courseFilterListInfo;
  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InstanceManager().getFilterCourse(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(!snapshot.hasData) {
          return Icon(Icons.filter_alt_outlined, size: Dimens.size30,);
        }
        courseFilterListInfo = snapshot.data as CourseFilterListInfo;
       return SizedBox(
         child: PopupMenuButton<CourseFilterInfo>(
           initialValue: selectedItem,
            tooltip: "",
            icon: Icon(Icons.filter_alt_outlined, size: Dimens.size30, color: ColorConst.colorIconGrays,),
           onSelected: (CourseFilterInfo item) {
           },
           itemBuilder: (context) {
             return getListFitterMenuItem(data: courseFilterListInfo.data??[], onSelect: (p0) {
               setState(() {
                 selectedItem = p0;
                 if(widget.onSelect!=null)
                 {
                   widget.onSelect!(p0);
                 }
               });
             },);
           },
         ),
       );
      },
    );
  }
  List<PopupMenuItem<CourseFilterInfo>> getListFitterMenuItem({required List<CourseFilterInfo> data, Function(CourseFilterInfo)? onSelect}){
    List<PopupMenuItem<CourseFilterInfo>> list = [];
    for(CourseFilterInfo courseFilterInfo in data)
      {
        GlobalKey? key = GlobalKey(debugLabel: courseFilterInfo.name.toString());
        PopupMenuItem<CourseFilterInfo> popupMenuItem = PopupMenuItem<CourseFilterInfo>(
          key:  key,
          value: courseFilterInfo,
          onTap: () {
            if(onSelect!=null)
              {
                onSelect(courseFilterInfo);
              }
          },
            child: StatefulBuilder(
              builder: (BuildContext context, void Function(void Function()) setState) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(courseFilterInfo.name??"", style: TextStyleConstant.textStyleBlack14w400,),
                    Visibility(
                        visible: (courseFilterInfo.subFilter??[]).isNotEmpty,
                        child: Row(
                          children: [
                            Gap(Dimens.size10),
                            InkWell(
                              onTap: () {
                                final  renderBox = key.currentContext!.findRenderObject() as RenderBox ;
                                final position = renderBox.localToGlobal(Offset.zero);
                                showMenu(
                                    context: context,
                                    useRootNavigator: true,
                                    position: RelativeRect.fromLTRB(position.dx, position.dy, MediaQuery.of(context).size.width -position.dx, 0),
                                    items: getListSubFilterMenuItem(
                                      data: courseFilterInfo.subFilter??[],
                                      onSelect: (p0) {
                                        courseFilterInfo.selectSubFilter= p0;
                                        if(onSelect!=null)
                                          {
                                            onSelect(courseFilterInfo);
                                          }
                                      },)
                                );
                              },
                              child: Icon(Icons.arrow_forward_ios_outlined, size: Dimens.size15, color: ColorConst.colorIconGrays,),
                            )
                          ],
                        )),

                  ],
                );
              },
            ),
        );
        list.add(popupMenuItem); 
      }
    return list;
  }
  List<PopupMenuItem<SubFilterInfo>> getListSubFilterMenuItem({required List<SubFilterInfo> data, Function(SubFilterInfo)? onSelect}){
    List<PopupMenuItem<SubFilterInfo>> list = [];
    for(SubFilterInfo courseFilterInfo in data)
    {
      PopupMenuItem<SubFilterInfo> popupMenuItem = PopupMenuItem<SubFilterInfo>(
        value: courseFilterInfo,
        onTap: () {
          if(onSelect!=null)
          {
            onSelect(courseFilterInfo);
          }
        },
        child: Text(courseFilterInfo.name??"", style: TextStyleConstant.textStyleBlack14w400,),
      );
      list.add(popupMenuItem);
    }
    return list;
  }

}
