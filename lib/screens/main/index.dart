import 'package:boohack/res/res.dart';
import 'package:boohack/screens/about/index.dart';
import 'package:boohack/screens/map/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:boohack/screens/main/blocs/index.dart';
import 'package:line_icons/line_icons.dart';

/// Application Home Screen
/// Displayed after [Splashscreen]
/// {@category Screens}
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  MainScreenBloc bloc;
  PageController pageController;

  List<Widget> pages = [
    Container(),
    MapScreen(),
    AboutScreen(),
  ];
  List<BottomNavigationBarItem> bottomItems = [
    buildBottomItem(LineIcons.list),
    buildBottomItem(LineIcons.map_o),
    buildBottomItem(LineIcons.info_circle),
  ];

  @override
  void initState() {
    bloc = MainScreenBloc.getInstance();
    pageController = PageController(initialPage: bloc.currentState.page);
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: bloc,
      builder: (context, state) {
        if (state.hardChange) {
          pageController.animateToPage(state.page, curve: Curves.easeInOut, duration: Duration(milliseconds: 500));
          bloc.dispatch(DoneHardChangePageMainEvent());
        }
        return Scaffold(
          body: PageView(controller: pageController, physics: NeverScrollableScrollPhysics(), children: pages),
          primary: false,
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 16,
            currentIndex: state.page,
            type: BottomNavigationBarType.fixed,
            onTap: (int _page) {
              bloc.dispatch(ChangePageMainEvent(_page));
              pageController.animateToPage(_page, curve: Curves.easeInOut, duration: Duration(milliseconds: 500));
            },
            items: bottomItems,
          ),
        );
      },
    );
  }

  static buildBottomItem(IconData icon, {center = false, text}) {
    if (center)
      return BottomNavigationBarItem(
        icon: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(color: ITColors.primaryDark, borderRadius: BorderRadius.circular(48)),
          child: Icon(
            icon,
            color: ITColors.bg,
          ),
        ),
        title: text == null ? Container() : Text(text),
      );
    else
      return BottomNavigationBarItem(
        icon: Icon(icon),
        title: text == null ? Container() : Text(text),
      );
  }
}
