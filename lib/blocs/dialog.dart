part of blocs;

class DialogEvent {}

class OpenDialogEvent extends DialogEvent {
  OpenDialogEvent({this.confirm, this.text});
  final Function confirm;
  final String text;
}

class CloseDialogEvent extends DialogEvent {}

class DialogState {}

class OpenedDialogState extends DialogState {
  OpenedDialogState({this.confirm, this.text});
  final Function confirm;
  final String text;
}

class ClosedDialogState extends DialogState {}

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  static DialogBloc _instance;
  static DialogBloc getInstance() {
    if (_instance == null) _instance = DialogBloc();
    return _instance;
  }

  DialogState get initialState => new ClosedDialogState();

  @override
  Stream<DialogState> mapEventToState(
    DialogEvent event,
  ) async* {
    if (event is OpenDialogEvent) {
      yield OpenedDialogState(confirm: event.confirm, text: event.text);
    }
    if (event is CloseDialogEvent) {
      yield ClosedDialogState();
    }
  }
}
