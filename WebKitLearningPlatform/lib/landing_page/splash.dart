import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'deshboard/deshboard.dart';
import 'helper/colornotifier.dart';

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
      const Duration(seconds: 3),
          () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  const DeshScreen(),
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
            Text('Kuku.io',style: TextStyle(fontSize: 28,fontFamily: 'gilroybold',color: notifier.blackcolor),),
          ],
        ),
      ),
    );
  }
}
