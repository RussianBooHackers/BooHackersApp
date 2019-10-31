part of blocs;

abstract class InitEvent {}

class InitInitEvent extends InitEvent {}


class ForceInitEvent extends InitEvent {}

enum InitState { notInitedLoading, noUser, loading, inited }

class InitBloc extends Bloc<InitEvent, InitState> {
  static InitBloc _instance;
  static InitBloc getInstance() {
    if (_instance == null) _instance = InitBloc();
    return _instance;
  }

  @override
  InitState get initialState => InitState.notInitedLoading;

  @override
  Stream<InitState> mapEventToState(InitEvent event) async* {
    if (event is InitInitEvent) {
      yield InitState.notInitedLoading;
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      if (Platform.isAndroid)
        debugDefaultTargetPlatformOverride = TargetPlatform.android;
      else
        debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
      await init();
      rootBundle.loadString('assets/map/style.txt');
        yield InitState.noUser;
    }
    if (event is ForceInitEvent) yield InitState.inited;
  }

  init() async {
    await DataBase().open();
    initializeDateFormatting();
    Api.init();
  }

}
