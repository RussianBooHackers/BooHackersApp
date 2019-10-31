import 'package:animator/animator.dart';
import 'package:boohack/blocs/blocs.dart';
import 'package:boohack/models/models.dart';
import 'package:boohack/res/res.dart';
import 'package:boohack/screens/map/provider.dart';
import 'package:boohack/screens/map/widgets/location.dart';
import 'package:boohack/screens/map/widgets/bar_info.dart';
import 'package:boohack/widgets/loading.dart';
import 'package:boohack/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapView extends StatefulWidget {
  const MapView({Key key, @required this.provider}) : super(key: key);
  final MapProvider provider;

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapProvider get provider => widget.provider;
  BarBloc get barBloc => provider.barBloc;
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;
  PanelController panelController = PanelController();

  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.vertical(top: Radius.circular(16.0));
    return WillPopScope(
      onWillPop: () async {
        if (panelController.isPanelOpen()) {
          panelController.close();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: SlidingUpPanel(
          controller: panelController,
          parallaxEnabled: true,
          parallaxOffset: 0.8,
          minHeight: 192,
          maxHeight: height - 208,
          borderRadius: radius,
          defaultPanelState: PanelState.CLOSED,
          panel: BlocBuilder(
            bloc: barBloc,
            builder: (context, BarState state) {
              return Container(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    if (state.barToPreview != null) ...[
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 16),
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                              color: ITColors.secondaryText.withOpacity(.2), borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      BarInfo(bar: state.barToPreview),
                      Divider(
                        height: 2,
                      ),
                    ] else
                      Container(
                        height: 180,
                        child: Center(child: ITLoading()),
                      )
                  ],
                ),
              );
            },
          ),
          body: BlocBuilder(
            bloc: barBloc,
            builder: (context, BarState state) {
              return Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: MapWidget(
                      barBloc: barBloc,
                      center: provider.selfBloc.currentState.position,
                      selfPosition: provider.selfBloc.currentState.position,
                      onMapCreate: provider.onMapCreate,
                      onCameraMove: provider.onCameraMove,
                      onCameraIdle: provider.onCameraIdle,
                    ),
                  ),
                  Positioned(
                    bottom: 310 + MediaQuery.of(context).viewPadding.bottom,
                    right: 12,
                    child: Container(
                      margin: EdgeInsets.only(left: 8, bottom: 8),
                      child: LocationWidget(
                        onTap: provider.animateToLocation,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
