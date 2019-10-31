import 'dart:async';

import 'package:boohack/api/api.dart';
import 'package:boohack/blocs/blocs.dart';
import 'package:boohack/models/models.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as ln;

class MapProvider {
  MapProvider({@required this.barBloc, @required this.selfBloc, this.findController});

  // blocs
  final BarBloc barBloc;
  final SelfBloc selfBloc;
  final TextEditingController findController;
  // controllers
  GoogleMapController controller;

  //other
  StreamSubscription locationSubscr;
  LatLngBounds lastBounds;
  CameraPosition lastPosition;

  subscribeOnLocation(StreamSubscription locationSubscr) {
    locationSubscr = ln.Location().onLocationChanged().listen((ln.LocationData currentLocation) {
      selfBloc.dispatch(
        SetPosition(
          LatLng(currentLocation.latitude, currentLocation.longitude),
        ),
      );
    });
  }

  void onMapCreate(GoogleMapController _controller) {
    controller = _controller;
  }

  void onCameraIdle() async {
    if (lastBounds == null) {
      lastBounds = await controller.getVisibleRegion();
    }
    List<Bar> bars = await BarApi.all();
    barBloc.dispatch(FetchBarEvent(bars: bars, bounds: lastBounds));
  }

  animateToBar(Bar bar) {
    if (lastPosition?.zoom == null) return;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: bar.location, zoom: lastPosition?.zoom),
      ),
    );
  }

  onCameraMove(CameraPosition position) async {
    lastPosition = position;
    lastBounds = await controller.getVisibleRegion();
  }

  animateToLocation() {
    if (selfBloc?.currentState?.position == null) {
      selfBloc.dispatch(UpdatePosition());
    } else {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: selfBloc?.currentState?.position, zoom: 15.1),
        ),
      );
    }
  }
}
