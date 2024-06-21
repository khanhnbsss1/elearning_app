// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/colornotifier.dart';
import '../mediaquery/mq.dart';

class browsecategory extends StatefulWidget {
  const browsecategory({super.key});

  @override
  State<browsecategory> createState() => _browsecategoryState();
}

class _browsecategoryState extends State<browsecategory> {

  late ColorNotifier notifier;
  PageController pg = PageController();
  int a = 4;

  bool isHover = false;
  bool isHover2 = false;
  bool scroll = false;

  List<bool> hoverborder = [false,false,false,false,false,false,false,false,false,false];
  List categoryreach = ['256.356','333.356','124.246','443.111','333.356','256.356','333.356','124.246','124.246','443.111'];
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
      return browse(constraints);
    },);
  }
  Widget browse(constraints){
    return Column(
      children: [
        Text('Super easy booking',style: TextStyle(fontFamily: 'gilroysemi',color: notifier.blackcolor,fontSize: constraints.maxWidth < 550 ? 28 : constraints.maxWidth < 900 ? 36 : 48,),),
        Text("Redefines the luxury",style: TextStyle(fontFamily: 'gilroymed',fontSize: constraints.maxWidth < 900 ? 18 : 26,color: notifier.subgreycolor),),
        SizedBox(height: constraints.maxWidth < 550 ? 20 : 50,),
        Padding(padding: EdgeInsets.only(left:constraints.maxWidth < 550 ? 10 : constraints.maxWidth < 800 ? 50 : constraints.maxWidth < 1300 ? 100 : scroll ? 50 : 150),
            child: SizedBox(
              height: 252,
              child: ListView.builder(
                controller: pg,
                itemCount: categoryreach.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: constraints.maxWidth < 800 ? constraints.maxWidth / 1.7 : constraints.maxWidth < 1300 ? constraints.maxWidth/ 4 : constraints.maxWidth / 6,
                        decoration: BoxDecoration(
                          color: hoverborder[index] ? Colors.transparent : notifier.whitecolor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: (hoverborder[index] || constraints.maxWidth < 550 ) ? (notifier.isDark ? notifier.whitecolor : Colors.grey.shade300) : (notifier.isDark ? Colors.transparent : notifier.lightgreycolor))
                        ),
                        child:InkWell(
                          onTap: () {
                          },
                          onHover: (value) {
                            setState(() {
                              hoverborder[index] = value;
                            });
                          },
                          child:  Padding(padding: const EdgeInsets.only(left: 30,top: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 25,
                                  width:  70,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: notifier.sugestionbutton,
                                  ),
                                  child: Text(categoryreach[index],style: TextStyle(fontFamily: 'gilroysemi',fontSize: 14 ,color: notifier.blackcolor),),
                                ),
                                const SizedBox(height: 75,),
                                Image.asset('assets/Icons/buildingtreeicon.png',height: 20,color: notifier.isDark ? const Color(0xFFFCFCFD) :  notifier.subgreycolor),
                                const SizedBox(height: 30,),
                                Text('City house',style: TextStyle(fontFamily: 'gilroysemi',fontSize: 18 ,color: notifier.blackcolor)),
                                const SizedBox(height: 7,),
                                Text('Small description',style: TextStyle(fontFamily: 'gilroysemi',fontSize: 12 ,color: notifier.subgreycolor)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20,),
                    ],
                  );
                },),
            ),
        ),
        SizedBox(height: constraints.maxWidth < 550 ? 20 : 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2,
                    color: (isHover) ? notifier.sugestionbutton : Colors.transparent),
              ),
              child: InkWell(
                  onTap: () {pg.animateTo(double.parse("${a}00"),
                      curve: const FlippedCurve(Easing.legacy),
                      duration: const Duration(seconds: 1));
                  setState(() {
                    a = a - 4;
                    if(scroll == true){
                      scroll = false;
                    }
                  });
                  },
                  onHover: (val){
                    setState(() {
                      isHover = val;
                    });
                  },
                  child: Padding(padding: const EdgeInsets.all(13),
                    child: Image.asset(
                      'assets/Icons/arrowlefticon.png',
                      width: 15,
                        color: notifier.subgreycolor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 2,
                    color: (isHover2) ? notifier.sugestionbutton : Colors.transparent),
              ),
              child: InkWell(
                  onTap: () {pg.animateTo(double.parse("${a}00"),
                      curve: const FlippedCurve(Easing.legacy),
                      duration: const Duration(seconds: 1));
                  setState(() {
                    a = a + 4;
                    if(scroll == false) {
                      scroll = true;
                    }
                  });
                  },
                  onHover: (val){
                    setState(() {
                      isHover2 = val;
                    });
                  },
                  child: Padding(padding: const EdgeInsets.all(13),
                    child: Image.asset(
                      'assets/Icons/arrowrighticon.png',
                      width: 15,
                      color: notifier.subgreycolor,
                    ),
                  )
              ),
            ),
          ],
        )
      ],
    );
  }
}
