// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


import '../helper/colornotifier.dart';
import '../mediaquery/mq.dart';

class bookticket extends StatefulWidget {
  const bookticket({super.key});

  @override
  State<bookticket> createState() => _bookticketState();
}

class _bookticketState extends State<bookticket> {
  late ColorNotifier notifier;

  final Uri _url = Uri.parse('https://www.youtube.com/watch?v=35npVaFGHMY&ab_channel=HugoMoussy');

  bool playHover = false;
  bool buttonHover = false;

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    notifier = Provider.of<ColorNotifier>(context, listen: true);
    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return LayoutBuilder(builder: (context, constraints) {
      return book(constraints);
    },);
  }
  Widget book(constraints){
    return Column(
      children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: SizedBox(
              width: constraints.maxWidth < 1100 ? constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Some good reason',style: TextStyle(fontFamily: 'gilroymed',fontSize: 18,color: notifier.blackcolor),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Text('Trips,experiences and\nplaces. All in one service',style: TextStyle(fontFamily: 'gilroysemi',fontSize: constraints.maxWidth < 550 ? 26 : 42,color: notifier.blackcolor,),overflow: TextOverflow.ellipsis),),
                      constraints.maxWidth < 900 ? const SizedBox() : SizedBox(
                        height: 45,
                        child:  ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                            backgroundColor: MaterialStateProperty.all(buttonHover ? Colors.indigoAccent.shade700 : notifier.buttoncolor),
                          ),
                          onHover: (value) {
                            setState(() {
                              buttonHover = value;
                            });
                          },
                          onPressed: () {

                          }, child: const Text('book now',style: TextStyle(fontSize: 16,fontFamily: 'gilroysemi',color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  constraints.maxWidth < 900 ? InkWell(
                      onTap: () {

                      },
                      onHover: (value) {
                        setState(() {
                          buttonHover = value;
                        });
                      },
                      child:  AnimatedContainer(
                        height: 45,
                        width: width / 1,
                        duration: const Duration(milliseconds: 200,),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                              backgroundColor: MaterialStateProperty.all(buttonHover ? Colors.indigoAccent.shade700 : notifier.buttoncolor),
                            ),
                            onPressed: () {

                            }, child: const Text('Book Now',style: TextStyle(fontSize: 16,fontFamily: 'gilroysemi',color: Colors.white),)),
                      )
                  ) : const SizedBox(),
                ],
              )
            ),
          ),
       SizedBox(height: constraints.maxWidth < 550 ? 20 : 50),
       SizedBox(
         height: constraints.maxWidth < 1050 ? constraints.maxWidth / 2 : constraints.maxWidth / 2.3,
         width: constraints.maxWidth < 1100 ? constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
         child: Stack(
             children: [
               Center(
                 child:  ClipRRect(
                   borderRadius: BorderRadius.circular(constraints.maxWidth < 1050 ? 20 : 20),
                   child: Image.asset('assets/deshboard/videobg.png',
                     filterQuality: FilterQuality.high,
                     width: constraints.maxWidth < 1100 ? constraints.maxWidth / 1 : constraints.maxWidth < 1200 ? constraints.maxWidth / 1.09 : constraints.maxWidth / 1.2,
                     fit: BoxFit.fill,
                   ),
                 ),
               ),
               Center(
                 child: InkWell(
                   onTap: () {
                     setState(() {
                       _launchUrl();
                     });
                   },
                   onHover: (value) {
                     setState(() {
                       playHover = value;
                     });
                   },
                   child: playHover ? SvgPicture.asset('assets/deshboard/playCircle.svg',height: 70,) : SvgPicture.asset('assets/deshboard/playCircle2.svg',height: 70,),
                 ),
               ),
             ],
           ),
       ),
      ],
    );
  }
}
