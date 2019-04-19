import 'package:flutter/material.dart';
import 'debounceBloc.dart';
export 'debounceBloc.dart';

class DebounceProvider extends InheritedWidget {
  final bloc;
  DebounceProvider({Key key, Widget child})
      : bloc = DebounceBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static DebounceBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(DebounceProvider) as DebounceProvider)
        .bloc;
  }
}
