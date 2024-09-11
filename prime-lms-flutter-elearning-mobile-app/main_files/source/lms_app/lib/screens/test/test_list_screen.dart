import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lms_app/base/base_request_elearning/models/search_common_request.dart';
import 'package:lms_app/screens/test/test_screen.dart';
import 'package:lms_app/services/apis/test/get_test_list_api.dart';
import 'package:lms_app/services/apis/test/models/test_info.dart';
import 'package:lms_app/utils/next_screen.dart';
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';

import '../../constants/custom_colors.dart';

class TestListScreen extends StatefulWidget {
  const TestListScreen({super.key});

  @override
  State<TestListScreen> createState() => _TestListScreenState();
}

class _TestListScreenState extends State<TestListScreen> {

  List<TestInfo> testList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'do-test'.tr(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder(
        future: getTestList(),
        builder: (context,snapshot) {
          testList = snapshot.data??[];
          return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                itemCount: testList.length,
                shrinkWrap: true,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (BuildContext context, int index) {
                  const bool isExpanded = true;
                  return ExpansionTile(
                    tilePadding: const EdgeInsets.symmetric(horizontal: 20,),
                    collapsedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: CustomColor.border),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: CustomColor.border),
                    ),
                    maintainState: true,
                    title: Text(
                      testList[index].name??"-",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isExpanded ? Colors.blueAccent : Theme.of(context).expansionTileTheme.textColor,
                          fontSize: 17
                      ),
                    ),
                    children: [
                      ListTile(
                        onTap: () => openDialog(context, testList[index]),
                        title: Text('${'type-test'.tr()} ${testList[index].typeTest??"-"}'),
                        subtitle: Text('status').tr(),
                      )
                    ],
                    // onExpansionChanged: (bool value) => ref.read(isSectionExpnadedProvider((section.id??0).toString()).notifier).update((state) => value),
                  );
                },
              );
        }
      ),
    );
  }

  Future<List<TestInfo>> getTestList() async {
    GetTestListApi getTestListApi = GetTestListApi(searchCommonRequest: SearchCommonRequest(pageSize: 10, pageNumber: 0,));
    TestListResponseModel testListResponseModel = await getTestListApi.call();
    return testListResponseModel.content??[];
  }

  Future<void> openDialog(BuildContext context,TestInfo test) {
    return Dialogs.materialDialog(
      context: context,
      title: 'Do-test-title'.tr(),
      // msg: 'do-test-subtitle'.tr(),
      titleAlign: TextAlign.center,
      titleStyle: Theme
          .of(context)
          .textTheme
          .headlineSmall!,
      msgAlign: TextAlign.center,
      msgStyle: Theme
          .of(context)
          .textTheme
          .titleMedium,
      barrierDismissible: true,
      color: Theme
          .of(context)
          .scaffoldBackgroundColor,
      actions: <Widget>[
        IconsOutlineButton(
          onPressed: () => Navigator.pop(context),
          text: 'close'.tr(),
        ),
        IconsOutlineButton(
          onPressed: () {
            Navigator.pop(context);
            NextScreen.normal(context, TestScreen(test: test));
          },
          text: 'ready'.tr(),
          color: Theme
              .of(context)
              .primaryColor,
          textStyle:
          const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ],
    );
  }
}
