part of blocs;

class NotificationEvent {
  final String message;
  NotificationEvent(this.message);
}

class NotificationState {
  final String text;
  NotificationState({this.text});
}

class ErrorState extends NotificationState {
  ErrorState(String text) : super(text: text);
}

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  static NotificationBloc _instance;
  static NotificationBloc getInstance() {
    if (_instance == null) _instance = NotificationBloc();
    return _instance;
  }

  @override
  NotificationState get initialState => NotificationState();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    yield NotificationState(text: event.message);
  }
}
