import 'package:flutter/material.dart';
import 'zipBloc.dart';
export 'zipBloc.dart';

class ZipProvider extends InheritedWidget {
  final bloc;
  ZipProvider({Key key, Widget child})
      : bloc = ZipBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ZipBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ZipProvider) as ZipProvider)
        .bloc;
  }
}
