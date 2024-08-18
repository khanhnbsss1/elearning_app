import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webkit/base/base.export.dart';

import 'components/colornotifier.dart';
import 'deshboard/landing_page.dart';

class LandingPageSplash extends StatefulWidget {
  const LandingPageSplash({super.key});

  @override
  State<LandingPageSplash> createState() => _LandingPageSplashState();
}

class _LandingPageSplashState extends State<LandingPageSplash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(
      const Duration(milliseconds: 10),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  const LandingPageScreen(),
          ),
        );
      },
    );
  }
  late ColorNotifier notifier;
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    return Scaffold(
      backgroundColor: notifier.whitecolor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/splashImage/preloader.gif'),
            const SizedBox(height: 20,),
            Text(L10nX.getStr.app_name,style: TextStyleConstant.textStyleBlack28w700),
          ],
        ),
      ),
    );
  }
}
