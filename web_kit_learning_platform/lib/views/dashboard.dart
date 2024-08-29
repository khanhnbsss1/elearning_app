import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_widget_cache.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/base/instance_mananger/filter_manager.dart';
import 'package:webkit/controller/dashboard_controller.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_dotted_line.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_list_extension.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/my_text_style.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/images.dart';
import 'package:webkit/services/apis/darh_board/dashboard_manager.dart';
import 'package:webkit/services/apis/darh_board/models/synthesisInfo.dart';
import 'package:webkit/services/apis/darh_board/models/top_courses_info.dart';
import 'package:webkit/views/layouts/layout.dart';

import '../services/apis/darh_board/models/subscription_purchases_info.dart';
import '../services/apis/darh_board/models/user_registration_info.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage> with SingleTickerProviderStateMixin, UIMixin {
  late DashboardController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DashboardController());
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      L10nX.getStr.dashboard,
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  runAlignment: WrapAlignment.start,
                  wrapCrossAlignment: WrapCrossAlignment.start,
                  // contentPadding: false,
                  children: [
                    MyFlexItem(
                      child: MyFlex(
                        runAlignment: WrapAlignment.start,
                        wrapCrossAlignment: WrapCrossAlignment.start,
                        contentPadding: false,
                        children: [
                          /*MyFlexItem(
                            sizes: "lg-3",
                            child: MyCard(
                              shadow: MyShadow(elevation: 0.5),
                              child: Column(
                                children: [
                                  MyContainer(
                                    color: contentTheme.warning.withAlpha(28),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Icon(
                                                LucideIcons.alertTriangle,
                                                size: 20,
                                                color: contentTheme.warning,
                                              ),
                                              MySpacing.width(8),
                                              Expanded(
                                                child: MyText.bodyMedium(
                                                  L10nX.getStr.you_not_register_course,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            AppPages.routeName(Routes.courseList);
                                          },
                                          child: MyText.bodyMedium(
                                            L10nX.getStr.register,
                                            fontWeight: 600,
                                            decoration: TextDecoration.underline,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  MySpacing.height(16),
                                  MyFlex(
                                    contentPadding: false,
                                    children: [
                                      MyFlexItem(
                                        sizes: "lg-6",
                                        child: MyContainer(
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: L10nX.getStr.register_course_or_contact_to_you_teacher,
                                                    style: MyTextStyle.bodyMedium(fontSize: 16),
                                                    *//*                                   children:  <TextSpan>[
                                                      TextSpan(text: 'Free trial,', style: baseStyle.copyWith(fontWeight: FontWeight.bold)),
                                                      TextSpan(text: "to 'Premium plan'"),
                                                    ],*//*
                                                  ),
                                                ),
                                              ),
                                              MySpacing.height(16),
                                              MyButton(
                                                onTap: () {
                                                  AppPages.routeName(Routes.courseList);
                                                },
                                                elevation: 0,
                                                padding: MySpacing.xy(8, 12),
                                                backgroundColor: contentTheme.primary,
                                                borderRadiusAll: AppStyle.buttonRadius.medium,
                                                child: MyText.bodySmall(
                                                  L10nX.getStr.register_now,
                                                  fontSize: 12,
                                                  color: contentTheme.onPrimary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      MyFlexItem(
                                        sizes: "lg-6",
                                        child: Image.asset(
                                          Images.dashboard[0],
                                          height: 205,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                          MyFlexItem(
                              sizes: "lg-8",
                              child: buildDataSynthesis()),
                          MyFlexItem(
                            sizes: "lg-4",
                            child: MyCard(
                              shadow: MyShadow(elevation: 0.5),
                              height: 305,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              padding: MySpacing.only(left: 24, right: 12, top: 12),
                              color: contentTheme.dark,
                              child: Stack(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              MyText.titleMedium(
                                                "New Visitors",
                                                color: contentTheme.light,
                                                fontWeight: 600,
                                              ),
                                              MySpacing.width(8),
                                              MyContainer(
                                                padding: MySpacing.xy(12, 2),
                                                color: contentTheme.success,
                                                child: MyText.bodyMedium(
                                                  "Active",
                                                  fontSize: 12,
                                                  color: contentTheme.onSuccess,
                                                ),
                                              )
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                LucideIcons.moveRight,
                                                size: 16,
                                                color: contentTheme.light,
                                              ))
                                        ],
                                      ),
                                      MySpacing.height(16),
                                      Row(
                                        children: [
                                          MyDottedLine(
                                            height: 50,
                                            dottedLength: 1,
                                            color: Colors.grey.shade400,
                                            child: Padding(
                                              padding: MySpacing.xy(12, 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MyText.bodyMedium(
                                                    "\$5,943",
                                                    fontSize: 20,
                                                    color: contentTheme.light,
                                                  ),
                                                  MySpacing.height(8),
                                                  MyText.bodyMedium(
                                                    "New Followers",
                                                    color: contentTheme.light,
                                                    fontWeight: 600,
                                                    muted: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          MySpacing.width(16),
                                          MyDottedLine(
                                            height: 50,
                                            dottedLength: 1,
                                            color: Colors.grey.shade400,
                                            child: Padding(
                                              padding: MySpacing.xy(12, 8),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MyText.bodyMedium(
                                                    "150,000",
                                                    fontSize: 20,
                                                    color: contentTheme.light,
                                                  ),
                                                  MySpacing.height(8),
                                                  MyText.bodyMedium(
                                                    "Followers Goal",
                                                    color: contentTheme.light,
                                                    fontWeight: 600,
                                                    muted: true,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  MySpacing.height(16),
                                  Positioned(
                                    right: 0,
                                    left: 0,
                                    top: 100,
                                    child: SfCartesianChart(
                                      plotAreaBorderWidth: 0,
                                      tooltipBehavior: controller.facebook,
                                      primaryXAxis: CategoryAxis(
                                        isVisible: false,
                                        majorGridLines: const MajorGridLines(width: 0),
                                        labelStyle: const TextStyle(fontSize: 0),
                                      ),
                                      primaryYAxis: NumericAxis(isVisible: false, labelStyle: const TextStyle(fontSize: 0), majorGridLines: const MajorGridLines(width: 0)),
                                      series: <CartesianSeries<ChartSampleData, int>>[
                                        ColumnSeries<ChartSampleData, int>(
                                          width: 0.5,
                                          color: contentTheme.primary,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          dataSource: controller.facebookChart,
                                          xValueMapper: (ChartSampleData data, _) => data.x,
                                          yValueMapper: (ChartSampleData data, _) => data.y,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    MyFlexItem(
                      child: MyFlex(
                        runAlignment: WrapAlignment.start,
                        wrapCrossAlignment: WrapCrossAlignment.start,
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                              sizes: "lg-8 xl-8",
                              child: buildResponseTimeByLocation()
                          ),
                          MyFlexItem(
                              sizes: "lg-4",
                              child: MyCard(
                                shadow: MyShadow(elevation: 0.5),
                                paddingAll: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        MyText.titleMedium(
                                          "Cost BreakDown",
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: 600,
                                        ),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              LucideIcons.moveRight,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                    SfCircularChart(
                                      tooltipBehavior: TooltipBehavior(enable: true),
                                      series: <CircularSeries>[
                                        DoughnutSeries<ChartSampleData, String>(
                                            radius: '80%',
                                            explode: true,
                                            explodeOffset: '10%',
                                            dataSource: controller.circleChart,
                                            pointColorMapper: (ChartSampleData data, _) => data.pointColor,
                                            xValueMapper: (ChartSampleData data, _) => data.x,
                                            yValueMapper: (ChartSampleData data, _) => data.y,
                                            dataLabelSettings: const DataLabelSettings(isVisible: true)),
                                      ],
                                    ),
                                    // MySpacing.height(12),
                                    Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [MyText.titleMedium("Top Channel"), MyText.titleMedium("Value")],
                                        ),
                                        MySpacing.height(12),
                                        buildCircleChartData(const Color.fromRGBO(9, 0, 136, 1), "Salary", "\$41,458"),
                                        MySpacing.height(8),
                                        buildCircleChartData(const Color.fromRGBO(147, 0, 119, 1), "Bill", "\$48,125"),
                                        MySpacing.height(8),
                                        buildCircleChartData(const Color.fromRGBO(228, 0, 124, 1), "Marketing", "\$19,458"),
                                        MySpacing.height(8),
                                        buildCircleChartData(const Color.fromRGBO(255, 189, 57, 1), "Other", "\$10,589"),
                                      ],
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    MyFlexItem(
                      child: MyFlex(
                        contentPadding: false,
                        children: [
                          MyFlexItem(
                            sizes: "lg-6",
                            child: buildTopCourseReview(),
                          ),
                          MyFlexItem(
                            sizes: "lg-6",
                            child: SizedBox(
                              height: Dimens.size630,
                              child: MyFlex(
                                  children: [
                                    MyFlexItem(
                                      child: buildRegisterNewest(),
                                    ),
                                    MyFlexItem(
                                      child: buildSubscriptionPurchases(),
                                    ),
                                  ],
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCircleChartData(Color color, String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            MyContainer.rounded(
              paddingAll: 4,
              color: color,
            ),
            MySpacing.width(8),
            MyText.bodyMedium(name)
          ],
        ),
        MyText.bodyMedium(price),
      ],
    );
  }
  Widget buildDataSynthesis(){
    return StatefulBuilder(builder: (context, setState) {
      return  FutureBuilder(
        future: DashboardManager().getSynthesisInfoResponseModel(),
        builder: (context, snapshot) {
          SynthesisSummaryInfo? synthesisSummaryInfo;
          if (snapshot.hasData) {
            synthesisSummaryInfo = snapshot.data;
          }
          return MyFlex(
            runAlignment: WrapAlignment.start,
            wrapCrossAlignment: WrapCrossAlignment.start,
            contentPadding: true,
            children: [
              MyFlexItem(
                sizes: "lg-4",
                child: buildCard(
                  color: contentTheme.pink,
                  icons: LucideIcons.user,
                  accountType: "${L10nX.getStr.sum_str} ${L10nX.getStr.user_str.toLowerCase()}",
                  price: (synthesisSummaryInfo?.totalUser ?? 0).toString(),
                  // month: ""
                ),
              ),
              MyFlexItem(
                sizes: "lg-4",
                child: buildCard(
                  color: contentTheme.primary,
                  icons: FontAwesomeIcons.chalkboardTeacher,
                  accountType: "${L10nX.getStr.sum_str} ${L10nX.getStr.author_str.toLowerCase()}",
                  price: (synthesisSummaryInfo?.totalAuthor ?? 0).toString(),
                ),
              ),
              MyFlexItem(
                sizes: "lg-4",
                child: buildCard(
                  color: contentTheme.success,
                  icons: Icons.app_registration,
                  accountType: "${L10nX.getStr.sum_str} ${L10nX.getStr.register.toLowerCase()}",
                  price: (synthesisSummaryInfo?.totalEnroll ?? 0).toString(),
                ),
              ),
              MyFlexItem(
                sizes: "lg-4",
                child: buildCard(
                  color: contentTheme.primary,
                  icons: Icons.payment,
                  accountType: L10nX.getStr.purchased_payment_str,
                  price: (synthesisSummaryInfo?.totalPurchase ?? 0).toString(),
                ),
              ),
              MyFlexItem(
                sizes: "lg-4",
                child: buildCard(
                  color: contentTheme.pink,
                  icons: Icons.my_library_books,
                  accountType: "${L10nX.getStr.sum_str} ${L10nX.getStr.course_str.toLowerCase()}",
                  price: (synthesisSummaryInfo?.totalCourse ?? 0).toString(),
                ),
              ),
              MyFlexItem(
                sizes: "lg-4",
                child: buildCard(
                  color: Colors.amber,
                  icons: Icons.reviews,
                  accountType: "${L10nX.getStr.sum_str} ${L10nX.getStr.review_str.toLowerCase()}",
                  price: (synthesisSummaryInfo?.totalReview ?? 0).toString(),
                ),
              ),
            ],
          );
        },
      );
    },);
  }
  Widget buildTopCourseReview(){
    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return FutureBuilder(
          future: DashboardManager().getTopCourseResponseModel(),
          builder: (context, snapshot) {
            TopCoursesInfoResponseModel? topCoursesInfoResponseModel;
            if (snapshot.hasData) {
              topCoursesInfoResponseModel = snapshot.data;
            }
            return MyCard(
              shadow: MyShadow(elevation: 0.5),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: Dimens.size630,
                  maxWidth: Dimens.size700
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText.titleMedium(
                          L10nX.getStr.coure_top_review,
                          fontWeight: 600,
                        ),
                        Row(
                          children: [
                            PopupMenuButton(
                              onSelected: controller.onSelectedTimeDesign,
                              itemBuilder: (BuildContext context) {
                                return [
                                  "Year",
                                  "Month",
                                  "Week",
                                  "Day",
                                  "Hours",
                                ].map((behavior) {
                                  return PopupMenuItem(
                                    value: behavior,
                                    height: 32,
                                    child: MyText.bodySmall(
                                      behavior.toString(),
                                      color: theme.colorScheme.onSurface,
                                      fontWeight: 600,
                                    ),
                                  );
                                }).toList();
                              },
                              color: theme.cardTheme.color,
                              child: MyContainer.bordered(
                                padding: MySpacing.xy(12, 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyText.labelMedium(
                                      controller.selectedTimeDesign.toString(),
                                      color: theme.colorScheme.onSurface,
                                    ),
                                    Icon(
                                      LucideIcons.chevronDown,
                                      size: 22,
                                      color: theme.colorScheme.onSurface,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    MySpacing.height(16),
                    StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                      return LayoutBuilder(builder: (context, constraints) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: MyContainer.bordered(
                            paddingAll: 0,
                            width: constraints.maxWidth,
                            child: DataTable(
                                sortAscending: true,
                                columnSpacing: 0,
                                onSelectAll: (_) => {},
                                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                                dataRowMaxHeight: 50,
                                columns: [
                                  DataColumn(
                                    label: SizedBox(
                                      width: Dimens.size80,
                                      child: MyText.labelLarge(
                                        L10nX.getStr.review_str,
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.labelLarge(
                                      L10nX.getStr.course_str,
                                    ),
                                  ),
                                  DataColumn(
                                    label: MyText.labelLarge(
                                      L10nX.getStr.type,
                                    ),
                                  ),
                                ],
                                rows: (topCoursesInfoResponseModel?.data??[])
                                    .mapIndexed(
                                      (index, data) => DataRow(
                                    cells: [
                                      DataCell(
                                        SizedBox(
                                          width: Dimens.size80,
                                          child: MyText.bodyMedium("${data.ratePoint}"),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                          width: constraints.maxWidth  - Dimens.size100 *2,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Expanded(child: MyText.bodyMedium("${data.name}", textAlign: TextAlign.start,)),
                                            ],
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        SizedBox(
                                            width: Dimens.size80,
                                            child: MyText.bodyMedium("${data.mode}")),
                                      ),
                                    ],
                                  ),
                                )
                                    .toList()),
                          ),
                        );
                      },);
                    },
                    )
                  ],
                ),
              ),
            );
          });
    },
    );
  }
  Widget buildResponseTimeByLocation(){
    return StatefulBuilder(builder: (context, setState) {
      return MyCard(
        shadow: MyShadow(elevation: 0.5),
        paddingAll: 0,
        child: Column(
          children: [
            Padding(
              padding: MySpacing.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: MyText.titleMedium(
                      L10nX.getStr.coure_top_review,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: 600,
                    ),
                  ),
                  PopupMenuButton(
                    onSelected: controller.onSelectedTimeByLocation,
                    itemBuilder: (BuildContext context) {
                      return ["Year", "Month", "Week", "Day", "Hours"].map((behavior) {
                        return PopupMenuItem(
                          value: behavior,
                          height: 32,
                          child: MyText.bodySmall(
                            behavior.toString(),
                            color: theme.colorScheme.onSurface,
                            fontWeight: 600,
                          ),
                        );
                      }).toList();
                    },
                    color: theme.cardTheme.color,
                    child: MyContainer.bordered(
                      padding: MySpacing.xy(12, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyText.labelMedium(
                            controller.selectedTimeByLocation.toString(),
                            color: theme.colorScheme.onSurface,
                          ),
                          Icon(
                            LucideIcons.chevronDown,
                            size: 22,
                            color: theme.colorScheme.onSurface,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            MySpacing.height(12),
            MyFlex(
              children: [
                MyFlexItem(
                  sizes: "lg-3",
                  child: buildResponseTimeByLocationData(
                    "Current Week",
                    "\$1859.52",
                    LucideIcons.cornerRightUp,
                    contentTheme.success,
                  ),
                ),
                MyFlexItem(
                  sizes: "lg-3",
                  child: buildResponseTimeByLocationData(
                    "Previous Week",
                    "\$1568",
                    LucideIcons.cornerRightDown,
                    contentTheme.red,
                  ),
                ),
                MyFlexItem(
                  sizes: "lg-3",
                  child: buildResponseTimeByLocationData(
                    "Conversation",
                    "5.68%",
                    LucideIcons.cornerRightUp,
                    contentTheme.success,
                  ),
                ),
                MyFlexItem(
                  sizes: "lg-3",
                  child: buildResponseTimeByLocationData(
                    "Customers",
                    "80K",
                    LucideIcons.cornerRightDown,
                    contentTheme.red,
                  ),
                ),
              ],
            ),
            MySpacing.height(12),
            const Divider(),
            Padding(
              padding: MySpacing.all(16),
              child: SfCartesianChart(
                primaryXAxis: CategoryAxis(),
                tooltipBehavior: controller.chart,
                axes: <ChartAxis>[
                  NumericAxis(
                      numberFormat: NumberFormat.compact(),
                      majorGridLines: const MajorGridLines(width: 0),
                      opposedPosition: true,
                      name: 'yAxis1',
                      interval: 1000,
                      minimum: 0,
                      maximum: 7000)
                ],
                series: <CartesianSeries<ChartSampleData, String>>[
                  ColumnSeries<ChartSampleData, String>(
                      animationDuration: 2000,
                      width: 0.5,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                      color: contentTheme.primary,
                      dataSource: controller.chartData,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.y,
                      name: 'Unit Sold'),
                  LineSeries<ChartSampleData, String>(
                      animationDuration: 4500,
                      animationDelay: 2000,
                      dataSource: controller.chartData,
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.yValue,
                      yAxisName: 'yAxis1',
                      markerSettings: const MarkerSettings(isVisible: true),
                      name: 'Total Transaction')
                ],
              ),
            ),
          ],
        ),
      );
    },);
  }

  Widget buildRegisterNewest(){
    return StatefulBuilder(builder: (context, setState) {
     return FutureBuilder(
        future: DashboardManager().getUserRegistrationModel(), 
        builder: (context, snapshot) {
          
          List<ChartSampleData> revenueChart2 =[];
          if (snapshot.hasData) {
            UserRegistrationInfoResponseModel? topCoursesInfoResponseModel = snapshot.data;
            for(UserRegistrationInfo userRegistrationInfo in (topCoursesInfoResponseModel?.data??[])){
              revenueChart2.add(ChartSampleData(x: userRegistrationInfo.dateValue, y: userRegistrationInfo.total),);
            }
          }
        return MyCard(
          shadow: MyShadow(elevation: 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: MySpacing.x(8),
                    child: MyText.titleMedium(
                      L10nX.getStr.registered_user,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: 600,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        LucideIcons.moveRight,
                        size: 20,
                      ))
                ],
              ),
              MySpacing.height(16),
              SizedBox(
                height: 250,
                child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  tooltipBehavior: controller.revenue,
                  primaryXAxis: CategoryAxis(
                    majorGridLines: const MajorGridLines(width: 0),
                    labelRotation: -75,
                  ),
                  primaryYAxis: NumericAxis(
                    // majorGridLines:
                    // const MajorGridLines(width: 0),
                  ),
                  series: <CartesianSeries>[
                    SplineSeries<ChartSampleData, String>(
                      color: const Color(0xff0acf97),
                      name: S.of(context).registered_user,
                      dataSource: revenueChart2,
                      markerSettings: const MarkerSettings(isVisible: true),
                      xValueMapper: (ChartSampleData data, _) => data.x,
                      yValueMapper: (ChartSampleData data, _) => data.y,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },);
    },);
  }
  Widget buildSubscriptionPurchases(){
    return StatefulBuilder(builder: (context, setState) {
      return FutureBuilder(
        future: DashboardManager().getSubscriptionPurchasesInfoResponseModel(),
        builder: (context, snapshot) {

          List<ChartSampleData> revenueChart2 =[];
          if (snapshot.hasData) {
            SubscriptionPurchasesInfoResponseModel? topCoursesInfoResponseModel = snapshot.data;
            for(SubscriptionPurchasesInfo userRegistrationInfo in (topCoursesInfoResponseModel?.data??[])){
              revenueChart2.add(ChartSampleData(x: userRegistrationInfo.dateValue, y: userRegistrationInfo.totalAmount),);
            }
          }
          return MyCard(
            shadow: MyShadow(elevation: 0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: MySpacing.x(8),
                      child: MyText.titleMedium(
                        L10nX.getStr.purchased_payment_str,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: 600,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          LucideIcons.moveRight,
                          size: 20,
                        ))
                  ],
                ),
                MySpacing.height(16),
                SizedBox(
                  height: 250,
                  child: SfCartesianChart(
                    plotAreaBorderWidth: 0,
                    tooltipBehavior: controller.revenue,
                    primaryXAxis: CategoryAxis(
                      majorGridLines: const MajorGridLines(width: 0),
                      labelRotation: -75,
                    ),
                    primaryYAxis: NumericAxis(
                      // majorGridLines:
                      // const MajorGridLines(width: 0),
                    ),
                    series: <CartesianSeries>[
                      SplineSeries<ChartSampleData, String>(
                        color: const Color(0xff0acf97),
                        name: S.of(context).purchased_payment_str,
                        dataSource: revenueChart2,
                        markerSettings: const MarkerSettings(isVisible: true),
                        xValueMapper: (ChartSampleData data, _) => data.x,
                        yValueMapper: (ChartSampleData data, _) => data.y,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },);
    },);
  }

  Widget buildResponseTimeByLocationData(String currentTime, String price, IconData icon, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LucideIcons.circleDotDashed,
              size: 16,
            ),
            MySpacing.width(8),
            MyText.bodyMedium(
              currentTime,
            ),
          ],
        ),
        MySpacing.height(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText.bodyLarge(
              price,
              fontSize: 20,
              fontWeight: 600,
              muted: true,
            ),
            MySpacing.width(8),
            Icon(
              icon,
              size: 16,
              color: iconColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCard({
    Color? color,
    IconData? icons,
    String? accountType,
    String? price,
    IconData? trendingIcon,
    Color? trendingIconColor,
    String? percentage,
    String? month,
  }) {
    return MyCard(
      shadow: MyShadow(elevation: 0.5),
      height: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText.bodyLarge(
            accountType ?? "",
            fontSize: 15,
            fontWeight: 600,
          ),
          Gap(Dimens.size16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText.bodyLarge(
                      price ?? "",
                      fontWeight: 600,
                      fontSize: 20,
                    ),
                  ],
                ),
                Gap(Dimens.size30),
                MyContainer(
                  height: 70,
                  width: 70,
                  paddingAll: 0,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  color: color?.withAlpha(30),
                  child: Icon(
                    icons,
                    color: color,
                  ),
                ),
                /*Row(
                  children: [
                    Icon(
                      trendingIcon,
                      color: trendingIconColor,
                      size: 16,
                    ),
                    MySpacing.width(8),
                    MyText.bodyMedium(
                      "$percentage",
                    ),
                    MySpacing.width(8),
                    Expanded(
                      child: MyText.bodyMedium(
                        month??"",
                        overflow: TextOverflow.ellipsis,
                        muted: true,
                      ),
                    ),
                  ],
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
