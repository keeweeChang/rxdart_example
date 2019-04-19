import 'package:flutter/material.dart';
import 'debounce.dart';
import '../blocs/debounceProvider.dart';
import '../blocs/zipProvider.dart';
import 'zip.dart';
import 'zipList.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RxDart"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView(
          children: _buildList(context),
        ),
      ),
    );
  }

  List<Widget> _buildList(context) {
    final list = <Widget>[];
    list.add(_buildTile("debounce", () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DebounceProvider(
                  child: Debounce(),
                ),
          ));
    }));
    list.add(_buildTile("zip", () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ZipProvider(
                  child: Zip(),
                ),
          ));
    }));
    list.add(_buildTile("zipList", () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ZipProvider(
                  child: ZipList(),
                ),
          ));
    }));
    return list;
  }

  Widget _buildTile(String title, Function() tap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: tap,
      child: Column(
        children: <Widget>[
          Container(
            height: 60,
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
