import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:webkit/base/base.export.dart';
import 'package:webkit/controller/ui/dialogs_controller.dart';
import 'package:webkit/helpers/extensions/string.dart';
import 'package:webkit/helpers/theme/app_style.dart';
import 'package:webkit/helpers/theme/app_theme.dart';
import 'package:webkit/helpers/utils/ui_mixins.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb.dart';
import 'package:webkit/helpers/widgets/my_breadcrumb_item.dart';
import 'package:webkit/helpers/widgets/my_button.dart';
import 'package:webkit/helpers/widgets/my_container.dart';
import 'package:webkit/helpers/widgets/my_flex.dart';
import 'package:webkit/helpers/widgets/my_flex_item.dart';
import 'package:webkit/helpers/widgets/my_spacing.dart';
import 'package:webkit/helpers/widgets/my_text.dart';
import 'package:webkit/helpers/widgets/responsive.dart';
import 'package:webkit/views/layouts/layout.dart';

class Dialogs extends StatefulWidget {
  const Dialogs({Key? key}) : super(key: key);

  @override
  State<Dialogs> createState() => _DialogsState();
}

class _DialogsState extends State<Dialogs>
    with SingleTickerProviderStateMixin, UIMixin {
  late DialogsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(DialogsController());
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
                      L10nX.getStr.dialogs,
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: L10nX.getStr.ui.toUpperCase()),
                        MyBreadcrumbItem(name: L10nX.getStr.dialogs, active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(
                      sizes: "lg-7 md-12",
                      child: MyContainer(
                        child: Column(
                          children: [
                            MyText.titleMedium(
                              L10nX.getStr.type_size.capitalizeWords,
                              fontWeight: 600,
                              letterSpacing: 0,
                            ),
                            const Divider(
                              height: 50,
                            ),
                            Wrap(
                              spacing: flexSpacing / 2,
                              runSpacing: flexSpacing / 2,
                              children: [
                                MyButton(
                                  onTap: _showAlertDialog,
                                  elevation: 0,
                                  padding: MySpacing.xy(40, 20),
                                  backgroundColor:
                                      contentTheme.primary.withAlpha(30),
                                  borderRadiusAll: AppStyle.buttonRadius.medium,
                                  child: MyText.bodySmall(L10nX.getStr.alert,
                                    color: contentTheme.primary,
                                  ),
                                ),
                                MyButton(
                                  onTap: _showStandardDialog,
                                  elevation: 0,
                                  padding: MySpacing.xy(40, 20),
                                  backgroundColor:
                                      contentTheme.success.withAlpha(30),
                                  borderRadiusAll: AppStyle.buttonRadius.medium,
                                  child: MyText.bodySmall(L10nX.getStr.standard,
                                    color: contentTheme.success,
                                  ),
                                ),
                                MyButton(
                                  onTap: _showFullWidthDialog,
                                  elevation: 0,
                                  padding: MySpacing.xy(40, 20),
                                  backgroundColor:
                                      contentTheme.warning.withAlpha(30),
                                  borderRadiusAll: AppStyle.buttonRadius.medium,
                                  child: MyText.bodySmall(L10nX.getStr.full_width.capitalizeWords,
                                    color: contentTheme.warning,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    MyFlexItem(
                        sizes: "lg-7 md-12",
                        child: MyContainer(
                          child: Column(
                            children: [
                              MyText.titleMedium(L10nX.getStr.positions,
                                fontWeight: 600,
                                letterSpacing: 0,
                              ),
                              const Divider(
                                height: 50,
                              ),
                              Wrap(
                                spacing: flexSpacing / 2,
                                runSpacing: flexSpacing / 2,
                                children: [
                                  MyButton(
                                    onTap: _showLeftDialog,
                                    elevation: 0,
                                    padding: MySpacing.xy(40, 20),
                                    backgroundColor:
                                        contentTheme.primary.withAlpha(30),
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      L10nX.getStr.left,
                                      color: contentTheme.primary,
                                    ),
                                  ),
                                  MyButton(
                                    onTap: _showTopDialog,
                                    elevation: 0,
                                    padding: MySpacing.xy(40, 20),
                                    backgroundColor:
                                        contentTheme.success.withAlpha(30),
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      L10nX.getStr.top,
                                      color: contentTheme.success,
                                    ),
                                  ),
                                  MyButton(
                                    onTap: _showRightDialog,
                                    elevation: 0,
                                    padding: MySpacing.xy(40, 20),
                                    backgroundColor:
                                        contentTheme.warning.withAlpha(30),
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      L10nX.getStr.right,
                                      color: contentTheme.warning,
                                    ),
                                  ),
                                  MyButton(
                                    onTap: _showBottomDialog,
                                    elevation: 0,
                                    padding: MySpacing.xy(40, 20),
                                    backgroundColor:
                                        contentTheme.info.withAlpha(30),
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      L10nX.getStr.bottom,
                                      color: contentTheme.info,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: "lg-7 md-12",
                        child: MyContainer(
                          child: Column(
                            children: [
                              MyText.titleMedium(
                                L10nX.getStr.other,
                                fontWeight: 600,
                                letterSpacing: 0,
                              ),
                              const Divider(
                                height: 50,
                              ),
                              Wrap(
                                spacing: flexSpacing / 2,
                                runSpacing: flexSpacing / 2,
                                children: [
                                  MyButton(
                                    onTap: _showStaticDialog,
                                    elevation: 0,
                                    padding: MySpacing.xy(40, 20),
                                    backgroundColor:
                                        contentTheme.primary.withAlpha(30),
                                    borderRadiusAll:
                                        AppStyle.buttonRadius.medium,
                                    child: MyText.bodySmall(
                                      L10nX.getStr.static,
                                      color: contentTheme.primary,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: MyText.labelLarge(L10nX.getStr.confirmation),
            content: MyText.bodySmall(
                "A small river named Duden flows by their place and supplies it with the necessary regelialia."),
            actions: [
              MyButton.rounded(
                onTap: () {
                  Navigator.pop(context);
                },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: theme.colorScheme.secondaryContainer,
                child: MyText.labelMedium(
                  L10nX.getStr.close,
                  color: theme.colorScheme.onSecondaryContainer,
                ),
              ),
              MyButton.rounded(
                onTap: () {
                  Navigator.pop(context);
                },
                elevation: 0,
                padding: MySpacing.xy(20, 16),
                backgroundColor: theme.colorScheme.primary,
                child: MyText.labelMedium(
                  L10nX.getStr.save,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ],
          );
        });
  }

  void _showStandardDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child:
                        MyText.labelLarge(L10nX.getStr.dialog_title.capitalizeWords),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.bodySmall(controller.dummyTexts[0]),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          child: MyText.labelMedium(
                            L10nX.getStr.close,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        MySpacing.width(16),
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            L10nX.getStr.save,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showFullWidthDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: MySpacing.all(16),
                  child: MyText.labelLarge(L10nX.getStr.dialog_title.capitalizeWords),
                ),
                const Divider(height: 0, thickness: 1),
                Padding(
                  padding: MySpacing.all(16),
                  child: MyText.bodySmall(controller.dummyTexts[1]),
                ),
                const Divider(height: 0, thickness: 1),
                Padding(
                  padding: MySpacing.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MyButton.rounded(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: theme.colorScheme.secondaryContainer,
                        child: MyText.labelMedium(
                          L10nX.getStr.close,
                          color: theme.colorScheme.onSecondaryContainer,
                        ),
                      ),
                      MySpacing.width(16),
                      MyButton.rounded(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        elevation: 0,
                        padding: MySpacing.xy(20, 16),
                        backgroundColor: theme.colorScheme.primary,
                        child: MyText.labelMedium(
                          L10nX.getStr.save,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _showRightDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            insetPadding: MySpacing.fromLTRB(
                MediaQuery.of(context).size.width - 350, 0, 0, 0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child:
                        MyText.labelLarge(L10nX.getStr.right_dialog.capitalizeWords),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.bodySmall(
                      controller.dummyTexts[2],
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          child: MyText.labelMedium(
                            L10nX.getStr.close,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        MySpacing.width(16),
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            L10nX.getStr.save,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showBottomDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            insetPadding: MySpacing.fromLTRB(
                0, MediaQuery.of(context).size.height - 350, 0, 0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child:
                        MyText.labelLarge(L10nX.getStr.bottom_dialog.capitalizeWords),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.bodySmall(
                      controller.dummyTexts[3],
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          child: MyText.labelMedium(
                            L10nX.getStr.close,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        MySpacing.width(16),
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            L10nX.getStr.save,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showTopDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            insetPadding: MySpacing.fromLTRB(
                0, 0, 0, MediaQuery.of(context).size.height - 350),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.labelLarge(L10nX.getStr.top_dialog.capitalizeWords),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.bodySmall(
                      controller.dummyTexts[4],
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          child: MyText.labelMedium(
                            L10nX.getStr.close,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        MySpacing.width(16),
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            L10nX.getStr.save,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showLeftDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            insetPadding: MySpacing.fromLTRB(
                0, 0, MediaQuery.of(context).size.width - 350, 0),
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.labelLarge(L10nX.getStr.left_dialog),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.bodySmall(
                      controller.dummyTexts[5],
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          child: MyText.labelMedium(
                            L10nX.getStr.close,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        MySpacing.width(16),
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            L10nX.getStr.save,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showStaticDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            child: SizedBox(
              width: 400,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      children: [
                        Expanded(
                            child: MyText.labelLarge(
                                L10nX.getStr.static_dialog.capitalizeWords)),
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              LucideIcons.x,
                              size: 20,
                              color: theme.colorScheme.onSurface
                                  .withOpacity(0.5),
                            ))
                      ],
                    ),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: MyText.bodySmall(controller.dummyTexts[0]),
                  ),
                  const Divider(height: 0, thickness: 1),
                  Padding(
                    padding: MySpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.secondaryContainer,
                          child: MyText.labelMedium(
                            L10nX.getStr.close,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                        ),
                        MySpacing.width(16),
                        MyButton.rounded(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          elevation: 0,
                          padding: MySpacing.xy(20, 16),
                          backgroundColor: theme.colorScheme.primary,
                          child: MyText.labelMedium(
                            L10nX.getStr.save,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
