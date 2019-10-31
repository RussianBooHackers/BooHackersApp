part of blocs;

class SelfState {
  SelfState({this.position});
  final LatLng position;
}

class SelfEvent {}

class UpdatePosition extends SelfEvent {}

class SetPosition extends SelfEvent {
  SetPosition(this.position);
  final LatLng position;
}

class SelfBloc extends Bloc<SelfEvent, SelfState> {
  static SelfBloc _instance;
  static SelfBloc getInstance() {
    if (_instance == null) _instance = SelfBloc();
    return _instance;
  }

  SelfState get initialState => SelfState();

  @override
  Stream<SelfState> mapEventToState(
    SelfEvent event,
  ) async* {
    if (event is UpdatePosition) {
      bool premission = await ln.Location().hasPermission();
      if (!premission) await ln.Location().requestPermission();
      ln.LocationData location = await ln.Location().getLocation().catchError(
            (onError) => NotificationBloc.getInstance().dispatch(
              NotificationEvent('Не удалось определить местоположение'),
            ),
          );
      yield SelfState(
        position: LatLng(location.latitude, location.longitude),
      );
    }
    if (event is SetPosition) {
      yield SelfState(
        position: event.position,
      );
    }
  }
}
