
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/base_bloc.dart';

class BasePage extends StatefulWidget {
  ScrollController scrollController = ScrollController();
  BuildContext? _context;

  BasePage({super.key});

  @override
  State<BasePage> createState(){
    return _BasePageState();
  }
}

class _BasePageState extends State<BasePage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider(
        create: (context) {
          return BaseBloc(BaseState())
            ..add(BaseInitEvent());
        },
        child: BlocConsumer<BaseBloc, BaseState>(
            listener: (context, state) {
              switch (state.blocStatus) {
                case BaseStatus.initial:
                
                  break;
                default:
                  break;
              }
            },
            builder: (BuildContext context, state) {
              widget._context = context;
              return const Scaffold(
                  body: SizedBox()
              );
            }));
  }

}