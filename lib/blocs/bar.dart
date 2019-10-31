part of blocs;

enum LoadStatus { loading, loaded, error }

abstract class BarEvent {}

class FetchBarEvent extends BarEvent {
  final List<Bar> bars;
  final LatLngBounds bounds;
  FetchBarEvent({this.bounds, this.bars});
}

class UpdateSelfLocationBarEvent extends BarEvent {
  final LatLng location;
  UpdateSelfLocationBarEvent(this.location);
}

class SetFilterEvent extends BarEvent {
  SetFilterEvent(this.filter);
  final List<String> filter;
}

class BarPreviewEvent extends BarEvent {
  final Bar bar;
  BarPreviewEvent({this.bar});
}

class FindProductsEvent extends BarEvent {
  final String findString;
  FindProductsEvent(this.findString);
}

class BuildRouteEvent extends BarEvent {
  final LatLng myLocation;
  BuildRouteEvent(this.myLocation);
}

class DestroyRouteEvent extends BarEvent {
  DestroyRouteEvent();
}

class BarState {
  Bar barToPreview;
  List<Bar> bars = [];
  String findString;
  LoadStatus loadStatus = LoadStatus.loaded;
  Polyline route;

  BarState();

  BarState copyWith({
    List<Bar> bars,
    Bar barToPreview,
    String findString,
    LoadStatus loadStatus,
    Polyline route,
  }) {
    return BarState()
      ..barToPreview = barToPreview ?? this.barToPreview
      ..bars = bars ?? this.bars
      ..findString = findString ?? this.findString
      ..loadStatus = loadStatus ?? this.loadStatus
      ..route = route ?? this.route;
  }
}

class BarBloc extends Bloc<BarEvent, BarState> {
  static BarBloc _instance;
  static BarBloc getInstance() {
    if (_instance == null) _instance = BarBloc();
    return _instance;
  }

  @override
  BarState get initialState => BarState();
  NotificationBloc notificationBloc = NotificationBloc.getInstance();

  @override
  Stream<BarState> mapEventToState(BarEvent event) async* {
    if (event is FetchBarEvent) {
      if (event.bars != null && event.bars.length > 0) {
        if (currentState.barToPreview == null)
          yield currentState.copyWith(
            barToPreview: currentState.barToPreview ?? event.bars.first,
            bars: event.bars,
          );
        else
          yield currentState.copyWith(bars: event.bars);
      } else
        yield currentState.copyWith(bars: []);
      yield currentState.copyWith(loadStatus: LoadStatus.loaded);
    }

    if (event is BarPreviewEvent) yield currentState.copyWith(barToPreview: event?.bar);
    if (event is DestroyRouteEvent) {
      yield BarState()
        ..barToPreview = currentState.barToPreview
        ..bars = currentState.bars
        ..findString = currentState.findString
        ..loadStatus = currentState.loadStatus
        ..route = null;
    }
    if (event is BuildRouteEvent) {
      yield currentState.copyWith(route: await getRoute(event.myLocation, currentState.barToPreview.location));
    }
  }

  Future<Polyline> getRoute(LatLng position, LatLng bar) async {
    List<LatLng> points = [];
    Response<dynamic> data = await (new Dio())
        .get(
            "https://route.api.here.com/routing/7.2/calculateroute.json?app_id=Bq3kB3NYLmccVbOlRTeW&app_code=F9RaU4irG-_A2c2QGOCipw&waypoint0=geo!${position.latitude},${position.longitude}&waypoint1=geo!${bar.latitude},${bar.longitude}&mode=fastest;car;traffic:enabled")
        .catchError((e) {});
    for (var point in data.data['response']['route'][0]['leg'][0]['maneuver'])
      points.add(LatLng(point["position"]["latitude"], point["position"]["longitude"]));
    return Polyline(polylineId: PolylineId(""), points: points, color: ITColors.primary.withOpacity(0.8), width: 7);
  }
}
