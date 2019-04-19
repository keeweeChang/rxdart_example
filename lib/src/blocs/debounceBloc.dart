import 'package:rxdart/rxdart.dart';

class DebounceBloc {
  final _like = BehaviorSubject<bool>();
  final _likeToServer = PublishSubject<bool>();
  Stream<bool> get like => _like.stream;
  Stream<bool> get likeToSever => _likeToServer.stream;
  Bloc() {
    _like.debounce(Duration(seconds: 1)).pipe(_likeToServer);
  }

  void pressLike() {
    bool current = _like.value ?? false;
    _like.sink.add(!current);
  }

  dispose() {
    _like.close();
    _likeToServer.close();
  }
}