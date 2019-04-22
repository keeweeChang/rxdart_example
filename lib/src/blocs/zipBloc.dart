import 'package:rxdart/rxdart.dart';

class ZipBloc {
  final _personInfo = PublishSubject<String>();
  final _personInfoList = PublishSubject<List<String>>();
  dispose() {
    _personInfo.close();
    _personInfoList.close();
  }

  ZipBloc() {
    _personInfo.scan((List<String> list, String personInfo, _) {
      list.add(personInfo);
      return list;
    }, <String>[]).pipe(_personInfoList);
  }

  Stream<String> get personInfo =>
      _personInfo.stream.doOnData((data) => print("$data"));
  Stream<List<String>> get personInfoList => _personInfoList.stream;

  fetchData(List<int> ids) {
    Observable.fromIterable(ids).flatMap((id) {
      final payObservable = Observable.fromFuture(_fetchPay(id));
      return Observable.fromFuture(_fetchPerson(id))
          .zipWith(
            payObservable,
            (String name, int pay) {
              return "$name get $pay";
            },
          )
          .onErrorReturn("-1")
          .where((value) => value != "-1");
    }).pipe(_personInfo);
  }

  testStreamError() {
    Observable.fromIterable([1, 2, 3, 4, 5]).map((int number) {
      if (number == 3) {
        throw ("test error");
      } else {
        return number;
      }
      // return number;
    }).listen((int number) {
      print("number: $number");
    }, onError: (error) {
      print("error: ${error.toString()}");
    }, onDone: () {
      print("done");
    }, cancelOnError: false);
  }

  Future<String> _fetchPerson(int id) async {
    await Future.delayed(Duration(seconds: 1 * (id + 1)));
    switch (id) {
      case 0:
        return "Peter";
      case 1:
        return "David";
      case 2:
        return "Robot";
      default:
        return "Unknown";
    }
  }

  Future<int> _fetchPay(int id) async {
    await Future.delayed(Duration(seconds: 2 * (id + 1)));
    switch (id) {
      case 0:
        return 1000;
      case 1:
        //throw Exception("David data is dead");
        return 2000;
      case 2:
        return 2500;
      default:
        return -1;
    }
  }
}
