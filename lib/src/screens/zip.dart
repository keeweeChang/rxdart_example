import 'package:flutter/material.dart';
import '../blocs/zipProvider.dart';

class Zip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ZipProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Zip"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: _serverText(bloc),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.fetchData([0, 1, 2]);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _serverText(ZipBloc bloc) {
    return StreamBuilder(
      stream: bloc.personInfo,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        String msg;
        if (snapshot.hasData) {
          msg = snapshot.data;
        } else if (snapshot.hasError) {
          msg = "Error: ${snapshot.error.toString()}";
        } else {
          msg = "Wait data";
        }
        return Text(
          msg,
          style: TextStyle(
            fontSize: 20.0,
          ),
        );
      },
    );
  }
}
