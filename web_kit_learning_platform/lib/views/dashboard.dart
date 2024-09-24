import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/dashboard_controller.dart';
import 'package:webkit/helpers/utils/my_shadow.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_card.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_dotted_line.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_list_extension.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/services/apis/darh_board/dashboard_manager.dart';
import 'package:webkit/services/apis/darh_board/models/synthesisInfo.dart';
import 'package:webkit/services/apis/darh_board/models/top_courses_info.dart';
import 'package:webkit/views/layouts/layout.dart';

import '../services/apis/darh_board/models/register_month_info.dart';
import '../services/apis/darh_board/models/revenue_month_info.dart';
import '../services/apis/darh_board/models/subscription_purchases_info.dart';
import '../services/apis/darh_board/models/top_course_revenue_info.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                   contentPadding: true,
                  children: [
                    MyFlexItem(
                      child: MyFlex(
                        runAlignment: WrapAlignment.start,
                        wrapCrossAlignment: WrapCrossAlignment.start,
                        contentPadding: true,
                        children: [
                          MyFlexItem(
                              sizes: "lg-8 xl-8",
                              child: buildDataSynthesis()),
                          MyFlexItem(
                            sizes: "lg-4 xl-4",
                            child: buildNewRegisterByMonth()
                          ),
                        ],
                      ),
                    ),
                    MyFlexItem(
                      child: MyFlex(
                        runAlignment: WrapAlignment.start,
                        wrapCrossAlignment: WrapCrossAlignment.start,
                        contentPadding: true,
                        children: [
                          MyFlexItem(
                              sizes: "lg-6 xl-6",
                              child: buildRevenueByMonth()
                          ),
                          MyFlexItem(
                              sizes: "lg-6",
                              child: buildTopCourseRevenue())
                        ],
                      ),
                    ),
                    MyFlexItem(
                      child: MyFlex(
                        contentPadding: true,
                        children: [
                          MyFlexItem(
                            sizes: "lg-6",
                            child: buildTopCourseReview(),
                          ),
                          MyFlexItem(
                            sizes: "lg-6",
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: Dimens.size650,
                                minHeight: Dimens.size650,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child: buildRegisterNewest()),
                                    Gap(Dimens.size16),
                                    Expanded(
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
              MySpacing.height(flexSpacing),

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
    return Visibility(
      visible: UserManager().userContainPermission(permissionList: [
        "dashboard.get.get_datasynthesis",
      ]),
      child: MyCard(
        child: StatefulBuilder(builder: (context, setState) {
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
        },
        ),
      ),
    );
  }
  Widget buildTopCourseReview(){
    return Visibility(
      visible: UserManager().userContainPermission(permissionList: [
        "dashboard.get.get_top_courses",
      ]),
      child: MyCard(
        shadow: MyShadow(elevation: 0.5),
        padding: EdgeInsets.zero,
        child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
          return FutureBuilder(
              future: DashboardManager().getTopCourseReviewResponseModel(),
              builder: (context, snapshot) {
                TopCoursesInfoResponseModel? topCoursesInfoResponseModel;
                if (snapshot.hasData) {
                  topCoursesInfoResponseModel = snapshot.data;
                }
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: Dimens.size650,
                    maxHeight: Dimens.size650,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.size16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText.titleMedium(
                              L10nX.getStr.coure_top_review,
                              fontWeight: 600,
                            ),
                          ],
                        ),
                        MySpacing.height(16),
                        StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                          return LayoutBuilder(builder: (context, constraints) {
                            return MyContainer.bordered(
                              paddingAll: 0,
                              //width: constraints.maxWidth,
                              child: DataTable(
                                  sortAscending: true,
                                  columnSpacing: 0,
                                  onSelectAll: (_) => {},
                                  headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                                  dataRowMaxHeight: 50,
                                  columns: [
                                    DataColumn(
                                      label: SizedBox(
                                        width: Dimens.size120,
                                        child: MyText.labelLarge(
                                          L10nX.getStr.review_str,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: constraints.maxWidth  - Dimens.size220,
                                        child: MyText.labelLarge(
                                          L10nX.getStr.course_str,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width:Dimens.size100,
                                        child: MyText.labelLarge(
                                          L10nX.getStr.type,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: (topCoursesInfoResponseModel?.data??[])
                                      .mapIndexed(
                                        (index, data) => DataRow(
                                      cells: [
                                        DataCell(
                                          SizedBox(
                                            width: Dimens.size120,
                                            child: MyText.bodyMedium("${data.ratePoint}"),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: constraints.maxWidth  - Dimens.size220,
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
                                              width: Dimens.size100,
                                              child: MyText.bodyMedium("${data.mode}")),
                                        ),
                                      ],
                                    ),
                                  ).toList()),
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
        ),
      ),
    );
  }
  Widget buildTopCourseRevenue(){
    return Visibility(
      visible: UserManager().userContainPermission(permissionList: [
        "dashboard.get.get_top_course_revenue",
      ]),
      child: MyCard(
        shadow: MyShadow(elevation: 0.5),
        paddingAll: 20,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: Dimens.size450,
            maxHeight: Dimens.size450,
          ),
          child: Column(
            children: [
              StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                return FutureBuilder(
                    future: DashboardManager().getTopCourseRevenueResponseModel(),
                    builder: (context, snapshot) {
                      TopCourseRevenueResponseModel? topCoursesInfoResponseModel;
                      if (snapshot.hasData) {
                        topCoursesInfoResponseModel = snapshot.data;
                      }
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              MyText.titleMedium(
                                L10nX.getStr.coure_top_revenue,
                                fontWeight: 600,
                              ),
                            ],
                          ),
                          MySpacing.height(16),
                          StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                            return LayoutBuilder(builder: (context, constraints) {
                              return DataTable(
                                  sortAscending: true,
                                  columnSpacing: 0,
                                  horizontalMargin: 0,
                                  onSelectAll: (_) => {},
                                  headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                                  dataRowMaxHeight: 50,
                                  columns: [
                                    DataColumn(
                                      label: SizedBox(
                                        width: constraints.maxWidth  - Dimens.size300,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(child: Text(L10nX.getStr.course_str,style: TextStyleConstant.textStyleBlack16w400,)),
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: Dimens.size120,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child:Text(
                                                  L10nX.getStr.revenue,
                                                  style: TextStyleConstant.textStyleBlack16w400,)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: Dimens.size150,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child:Text(
                                                    L10nX.getStr.payment_people_number,
                                                    maxLines: 2,
                                                    style: TextStyleConstant.textStyleBlack16w400,)
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: (topCoursesInfoResponseModel?.data??[])
                                      .mapIndexed(
                                        (index, data) => DataRow(
                                      cells: [
                                        DataCell(
                                          SizedBox(
                                            width: constraints.maxWidth  - Dimens.size270,
                                            child: Expanded(child: MyText.bodyMedium("${data.courseName}")),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                            width: Dimens.size120,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Expanded(child: MyText.bodyMedium("${data.totalUser}", textAlign: TextAlign.start,)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          SizedBox(
                                              width: Dimens.size150,
                                              child: Expanded(child: MyText.bodyMedium("${data.totalAmount}"))),
                                        ),
                                      ],
                                    ),
                                  )
                                      .toList());
                            },);
                          },
                          )
                        ],
                      );
                    });
              },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRevenueByMonth(){
    return Visibility(
      visible: UserManager().userContainPermission(permissionList: [
        "dashboard.get.get_revenue_month",
      ]),
      child: MyCard(
        shadow: MyShadow(elevation: 0.5),
        paddingAll: 20,
        child: StatefulBuilder(builder: (context, setState) {
          return FutureBuilder(
            future: DashboardManager().getRevenueMonthResponseModel(),
            builder: (context, snapshot) {
              List<ChartSampleData> revenueChart2 =[];
              double max = 0;
              double revenuePreveiusMonth = 0;
              double revenueCurrentMonth = 0;
              if (snapshot.hasData) {
                RevenueMonthResponseModel? topCoursesInfoResponseModel = snapshot.data;
                String year = DateTime.now().year.toString();
                int currentMonth = DateTime.now().month;
                for(int index = 1; index<=12; index++)
                  {
                    bool checkExitMonth =false;
                    for(RevenueMonthInfo userRegistrationInfo in (topCoursesInfoResponseModel?.data??[])){
                      int? month = int.tryParse((userRegistrationInfo.month??'').split('-').last)??1;
                      int? year1 = int.tryParse((userRegistrationInfo.month??'').split('-').first)??DateTime.now().year;
                      if(month == index && year1 == DateTime.now().year)
                        {
                          if(month == currentMonth-1)
                            {
                              revenuePreveiusMonth = (userRegistrationInfo.totalAmount??0).toDouble();
                            }
                          if(month == currentMonth)
                          {
                            revenueCurrentMonth = (userRegistrationInfo.totalAmount??0).toDouble();
                          }
                          checkExitMonth = true;
                          if(max<(userRegistrationInfo.totalAmount??0))
                            {
                              max = (userRegistrationInfo.totalAmount??0).toDouble();
                            }
                          revenueChart2.add(ChartSampleData(x:"${index<10?'0$index':index}-$year", y: userRegistrationInfo.totalAmount, yValue: userRegistrationInfo.totalAmount),);
                          break;
                        }
                    }
                    
                    if(checkExitMonth==false)
                      {
                        revenueChart2.add(ChartSampleData(x:"${index<10?'0$index':index}-$year", y: 0, yValue: 0),);
                      }
                    
                  }
        
              }
              double interver =  (max/5).toInt().toDouble();
              double differentCurrentAndPreviousMonth = revenueCurrentMonth - revenuePreveiusMonth;
            return ConstrainedBox(
              constraints: BoxConstraints(
                 minHeight: Dimens.size450,
                 maxHeight: Dimens.size450,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MyText.titleMedium(
                            L10nX.getStr.revenue_month,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: 600,
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
                        sizes: "lg-4",
                        child: buildRevenueItem(
                          L10nX.getStr.current_month,
                          "$revenueCurrentMonth (${L10nX.getStr.vnd_str})",
                          differentCurrentAndPreviousMonth<0?LucideIcons.cornerRightDown:LucideIcons.cornerRightUp,
                          differentCurrentAndPreviousMonth<0?contentTheme.red:contentTheme.success,
                        ),
                      ),
                      MyFlexItem(
                        sizes: "lg-4",
                        child: buildRevenueItem(
                          L10nX.getStr.previous_month,
                          "$revenuePreveiusMonth (${L10nX.getStr.vnd_str})",
                          differentCurrentAndPreviousMonth<0?LucideIcons.cornerRightDown:LucideIcons.cornerRightUp,
                          differentCurrentAndPreviousMonth<0?contentTheme.red:contentTheme.success,
                        ),
                      ),
                      MyFlexItem(
                        sizes: "lg-4",
                        child: buildRevenueItem(
                          L10nX.getStr.trend_str,
                          "${differentCurrentAndPreviousMonth.abs()} (${L10nX.getStr.vnd_str})",
                          differentCurrentAndPreviousMonth<0?LucideIcons.cornerRightDown:LucideIcons.cornerRightUp,
                          differentCurrentAndPreviousMonth<0?contentTheme.red:contentTheme.success,
                        ),
                      ),
                    ],
                  ),
                  MySpacing.height(12),
                  const Divider(),
                  Expanded(
                    child: Padding(
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
                              interval: interver<=0?10:interver,
                              minimum: 0,
                              maximum: max)
                        ],
                        series: <CartesianSeries<ChartSampleData, String>>[
                          ColumnSeries<ChartSampleData, String>(
                              animationDuration: 2000,
                              width: 0.5,
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                              color: contentTheme.primary,
                              dataSource: revenueChart2,
                              xValueMapper: (ChartSampleData data, _) => data.x,
                              yValueMapper: (ChartSampleData data, _) => data.y,
                              name: 'Unit Sold'),
                          LineSeries<ChartSampleData, String>(
                              animationDuration: 4500,
                              animationDelay: 2000,
                              dataSource: revenueChart2,
                              xValueMapper: (ChartSampleData data, _) => data.x,
                              yValueMapper: (ChartSampleData data, _) => data.yValue,
                              yAxisName: 'yAxis1',
                              markerSettings: const MarkerSettings(isVisible: true),
                              name: 'Total Transaction')
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
              },);
        },),
      ),
    );
  }

  Widget buildRegisterNewest(){
    return Visibility(
      visible: UserManager().userContainPermission(permissionList: [
        "dashboard.get.get_user_registration",
      ]),
      child: MyCard(
        shadow: MyShadow(elevation: 0.5),
        child: StatefulBuilder(builder: (context, setState) {
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
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: Dimens.size290,
                maxHeight: Dimens.size290,
              ),
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
                    ],
                  ),
                  MySpacing.height(16),
                  Expanded(
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
        },),
      ),
    );
  }
  Widget buildSubscriptionPurchases(){
    return Visibility(
      visible: UserManager().userContainPermission(permissionList: [
        "dashboard.get.get_subscription_purchases"
      ]),
      child: MyCard(
        shadow: MyShadow(elevation: 0.5),
        child: StatefulBuilder(builder: (context, setState) {
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
              return ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: Dimens.size290,
                  maxHeight: Dimens.size290,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
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
                      ],
                    ),
                    MySpacing.height(16),
                    Expanded(
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
        },),
      ),
    );
  }

  Widget buildNewRegisterByMonth(){
    return Visibility(
      visible: UserManager().userContainPermission(permissionList: [
        "dashboard.get.get_register_month",
      ]),
      child: MyCard(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: contentTheme.dark,
        child: MyCard(
          shadow: MyShadow(elevation: 0.5),
          height: 305,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          padding: MySpacing.only(left: 24, right: 12, top: 12),
          color: contentTheme.dark,
          child: StatefulBuilder(builder: (context, setState) {
            return FutureBuilder(
              future: DashboardManager().getRegisterMonthResponseModel(), 
              builder: (context, snapshot) {
                List<ChartSampleData> revenueChart2 =[];
                double max = 0;
                double revenuePreveiusMonth = 0;
                double revenueCurrentMonth = 0;
                if (snapshot.hasData) {
                  RegisterMonthResponseModel? topCoursesInfoResponseModel = snapshot.data;
                  String year = DateTime.now().year.toString();
                  int currentMonth = DateTime.now().month;
          
          
                  for(int index = 1; index<=12; index++)
                  {
                    bool checkExitMonth =false;
                    for(RegisterMonthInfo userRegistrationInfo in (topCoursesInfoResponseModel?.data??[])){
                      int? month = int.tryParse((userRegistrationInfo.month??'').split('-').last)??1;
                      int? year1 = int.tryParse((userRegistrationInfo.month??'').split('-').first)??DateTime.now().year;
                      if(month == index && year1 == DateTime.now().year)
                      {
                        if(month == currentMonth-1)
                        {
                          revenuePreveiusMonth = (userRegistrationInfo.totalUser??0).toDouble();
                        }
                        if(month == currentMonth)
                        {
                          revenueCurrentMonth = (userRegistrationInfo.totalUser??0).toDouble();
                        }
                        checkExitMonth = true;
                        if(max<(userRegistrationInfo.totalUser??0))
                        {
                          max = (userRegistrationInfo.totalUser??0).toDouble();
                        }
                        revenueChart2.add(ChartSampleData(
                            x:"${index<10?'0$index':index}-$year", 
                            y: userRegistrationInfo.totalUser,
                            yValue: userRegistrationInfo.totalUser),);
                        break;
                      }
                    }
          
                    if(checkExitMonth==false)
                    {
                      revenueChart2.add(ChartSampleData(x:"${index<10?'0$index':index}-$year", y: 0, yValue: 0),);
                    }
          
                  }
          
                }
                double interver =  (max/5).toInt().toDouble();
                double differentCurrentAndPreviousMonth = revenueCurrentMonth - revenuePreveiusMonth;
              return Stack(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: MyText.titleMedium(
                              L10nX.getStr.report_new_registered_account,
                              color: contentTheme.light,
                              fontWeight: 600,
                            ),
                          ),
                          MySpacing.width(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
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
                                        "$revenueCurrentMonth",
                                        fontSize: 20,
                                        color: contentTheme.light,
                                      ),
                                      MySpacing.height(8),
                                      MyText.bodyMedium(
                                        L10nX.getStr.current_month,
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
                                        '${differentCurrentAndPreviousMonth.abs()}',
                                        fontSize: 20,
                                        color: contentTheme.light,
                                      ),
                                      MySpacing.height(8),
                                      MyText.bodyMedium(
                                        differentCurrentAndPreviousMonth<0?"Giảm":"Tăng",
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
                    ],
                  ),
                  MySpacing.height(16),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: SizedBox(
                        height: 180,
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          tooltipBehavior: controller.facebook,
                          primaryXAxis: CategoryAxis(
                            isVisible: true,
                            labelRotation: -45,
                            majorGridLines: const MajorGridLines(width: 0),
                            labelStyle: TextStyle(fontSize: 13, color: ColorConst.whiteColor),
                          ),
                          primaryYAxis: NumericAxis(
                              isVisible: true, 
                              labelStyle:  TextStyle(fontSize: 13, color: ColorConst.whiteColor), 
                              maximum: max,
                              minimum: 0,
                              interval: interver<=0?1:interver,
                              majorGridLines: const MajorGridLines(width: 0)),
                          series: <CartesianSeries<ChartSampleData, String>>[
                            ColumnSeries<ChartSampleData, String>(
                              width: 0.5,
                              color: contentTheme.primary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              dataSource: revenueChart2,
                              xValueMapper: (ChartSampleData data, _) => data.x,
                              yValueMapper: (ChartSampleData data, _) => data.y,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },);
          },),
        ),
      ),
    );
  }
  Widget buildRevenueItem(String currentTime, String price, IconData icon, Color iconColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              CupertinoIcons.money_dollar_circle,
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
              fontSize: Dimens.size20,
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
      shadow: MyShadow(elevation: 0),
      height: 140,
      color: color!.withOpacity(0.1),
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
                  color: color,
                  child: Icon(
                    icons,
                    color: ColorConst.whiteColor,
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
