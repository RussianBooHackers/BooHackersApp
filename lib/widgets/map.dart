import 'dart:ui' as ui;

import 'package:boohack/generated/i18n.dart';
import 'package:boohack/models/bar.dart';
import 'package:boohack/blocs/blocs.dart';
import 'package:boohack/res/res.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  final LatLng center;
  final double centerZoom;
  final BarBloc barBloc;
  final LatLng selfPosition;
  final void Function(GoogleMapController) onMapCreate;
  final void Function(CameraPosition) onCameraMove;
  final void Function() onCameraIdle;
  final String styleAsset;
  MapWidget({
    Key key,
    @required this.center,
    @required this.barBloc,
    this.selfPosition,
    this.styleAsset = 'assets/map/style.txt',
    this.onCameraMove,
    this.onCameraIdle,
    this.onMapCreate,
    this.centerZoom,
  }) : super(key: key);

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  LatLng get center => widget.center;
  double get centerZoom => widget.centerZoom;
  BarBloc get barBloc => widget.barBloc;
  DialogBloc get dialogBloc => DialogBloc.getInstance();
  LatLng get selfPosition => widget.selfPosition;
  NotificationBloc get notificationBloc => NotificationBloc.getInstance();
  String get styleAsset => widget.styleAsset;
  Function get onMapCreate => widget.onMapCreate;
  Function get onCameraMove => widget.onCameraMove;
  Function get onCameraIdle => widget.onCameraIdle;

  BitmapDescriptor selfMarkerBitmap;
  BitmapDescriptor primaryMarkerBitmap;
  BitmapDescriptor choosedMarkerBitmap;

  List<Marker> markers = [];

  String _mapStyle;
  CameraPosition _initialCameraPosition;

  GoogleMapController mapController;

  @override
  void initState() {
    buildSelfBitmap().then((bitmap) => setState(() => selfMarkerBitmap = bitmap));
    buildBarBitmap(ITColors.primary).then((bitmap) => setState(() => primaryMarkerBitmap = bitmap));
    buildBarBitmap(Colors.blue).then((bitmap) => setState(() => choosedMarkerBitmap = bitmap));
    _initialCameraPosition = CameraPosition(target: center, zoom: centerZoom != null ? centerZoom : 11.1);
    super.initState();
    rootBundle.loadString(styleAsset).then((string) {
      _mapStyle = string;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: barBloc,
      builder: (context, BarState barBlocState) {
        return GoogleMap(
          onCameraMove: (CameraPosition position) => onCameraMove != null ? onCameraMove(position) : () => {},
          onCameraIdle: () => onCameraIdle != null ? onCameraIdle() : () => {},
          initialCameraPosition: _initialCameraPosition,
          onMapCreated: (GoogleMapController _controller) async {
            mapController = _controller;
            _controller.setMapStyle(_mapStyle);
            if (onMapCreate != null) onMapCreate(_controller);
          },
          compassEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          markers: buildMarkers(barBlocState.bars, barBlocState.barToPreview),
          polylines: barBlocState.route == null ? Set() : Set.from([barBlocState.route]),
        );
      },
    );
  }

  Set<Marker> buildMarkers(List<Bar> bars, Bar previewBar) {
    var list = [
      ...List.generate(bars.length, (index) {
        if (bars[index]?.location != null && primaryMarkerBitmap != null)
          return Marker(
            markerId: MarkerId(bars[index].id.toString()),
            consumeTapEvents: true,
            icon: primaryMarkerBitmap,
            position: bars[index]?.location,
            onTap: () {
              mapController.animateCamera(CameraUpdate.newLatLngZoom(bars[index].location, 14));
              barBloc.dispatch(
                BarPreviewEvent(bar: bars[index]),
              );
            },
          );
        return Marker(markerId: MarkerId(""));
      }),
      if (previewBar?.location != null && choosedMarkerBitmap != null)
        Marker(
            markerId: MarkerId(previewBar.id.toString()),
            consumeTapEvents: true,
            icon: choosedMarkerBitmap,
            position: previewBar.location,
            onTap: () {
              mapController.animateCamera(CameraUpdate.newLatLngZoom(previewBar.location, 14));
              barBloc.dispatch(BarPreviewEvent(bar: previewBar));
            }),
      if (selfPosition != null && selfMarkerBitmap != null)
        Marker(
          markerId: MarkerId("self"),
          position: selfPosition,
          consumeTapEvents: true,
          icon: selfMarkerBitmap,
        )
    ].toSet();
    return list;
  }

  buildSelfBitmap() async {
    var pictureRecorder = ui.PictureRecorder();
    var canvas = Canvas(pictureRecorder);
    var paint = Paint();
    paint.isAntiAlias = true;
    paint.color = ITColors.primaryDark;
    canvas.drawCircle(
        Offset(ui.window.devicePixelRatio * 5, ui.window.devicePixelRatio * 5), ui.window.devicePixelRatio * 5, paint);
    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(ui.window.devicePixelRatio * 5, ui.window.devicePixelRatio * 5), ui.window.devicePixelRatio * 3, paint);
    var pic = pictureRecorder.endRecording();
    ui.Image img =
        await pic.toImage((ui.window.devicePixelRatio * 20).toInt(), (ui.window.devicePixelRatio * 20).toInt());
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
  }

  buildBarBitmap(Color color) async {
    var pictureRecorder = ui.PictureRecorder();
    var size = ui.window.devicePixelRatio;
    var canvas = Canvas(pictureRecorder);
    var paint = Paint()
      ..color = color
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size * 5, size * 5), size * 5, paint);
    canvas.drawPath(getTrianglePath(size * 10, size * 20), paint);
    var pic = pictureRecorder.endRecording();
    ui.Image img = await pic.toImage((size * 20).toInt(), (size * 20).toInt());
    var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(x * .07, y * .38)
      ..lineTo(x * .94, y * .38)
      ..lineTo(x * .5, y * .66)
      ..lineTo(x * .07, y * .38);
  }
}
