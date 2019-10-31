import 'dart:math';

import 'package:boohack/blocs/blocs.dart';
import 'package:boohack/generated/i18n.dart';
import 'package:boohack/res/res.dart';
import 'package:boohack/screens/bar_info/widgets/bottom_buttons.dart';
import 'package:boohack/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'view/index.dart';

class BarInfoScreen extends StatefulWidget {
  @override
  _BarInfoScreenState createState() => _BarInfoScreenState();
}

class _BarInfoScreenState extends State<BarInfoScreen> {
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  // blocs
  BarBloc barBloc;

  //controllers
  ScrollController controller;

  @override
  void initState() {
    barBloc = BarBloc.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: barBloc,
      builder: (context, BarState state) {
        if (state?.barToPreview != null)
          return Scaffold(
            backgroundColor: ITColors.bg,
            body: Container(
              color: ITColors.bg,
              child: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 0,
                      child: IgnorePointer(
                        ignoring: true,
                        child: Container(
                          height: height * .3,
                          width: MediaQuery.of(context).size.width,
                          child: MapWidget(
                            center: state.barToPreview?.location,
                            centerZoom: 16,
                            barBloc: barBloc,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: height * .3,
                      child: SingleChildScrollView(
                          child: BarInfoView(
                        bar: state?.barToPreview,
                      )),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(color: ITColors.bg.withOpacity(.7), width: width, child: BottomButtons()),
                    ),
                  ],
                ),
              ),
            ),
          );
        else
          return Center(
            child: Container(
              child: Text(I18n.of(context).noBar),
            ),
          );
      },
    );
  }
}
