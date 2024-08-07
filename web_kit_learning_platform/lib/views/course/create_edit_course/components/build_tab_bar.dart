import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';

import '../../../../base/theme/colors_app.dart';
import '../../../../base/theme/text_stype_constant.dart';

class BuildTabBar extends StatefulWidget {
  final List<Widget> widgets;
  final List<String> titles;
  const BuildTabBar({super.key, required this.widgets, required this.titles});

  @override
  State<BuildTabBar> createState() => _BuildTabBarState();
}

class _BuildTabBarState extends State<BuildTabBar>
  with TickerProviderStateMixin, UIMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: widget.titles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // buildTabBar(),
                SizedBox(height: 60,),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      ...widget.widgets,
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: buildTabBar()),
        ],
      ),
    );
  }

  int position = 0;

  Widget buildTabBar() {
    TextStyle textStyle = TextStyleConstant.textStyleBlack15w700.copyWith(
        color: (position == 0
            ? ColorConst.textColorSelectTabBar
            : ColorConst.subtext));
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        constraints: BoxConstraints(
          maxWidth: 800,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorConst.dividerColor,width: 0.5)
        ),
        child: TabBar(
          indicatorColor: ColorConst.mainColor,
          dividerColor: Colors.transparent,
          labelColor: ColorConst.mainColor,
          indicator: BoxDecoration(border: Border(bottom: BorderSide(color: ColorConst.mainColor))),
          splashBorderRadius: BorderRadius.circular(12),
          overlayColor:
          WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
          dividerHeight: 0,
          controller: tabController,
          tabs: [
            for (String title in widget.titles)
              Tab(text: title),
          ],
        ),
      ),
    );
  }
}
