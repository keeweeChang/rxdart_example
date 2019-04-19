import 'package:flutter/material.dart';
import '../blocs/debounceProvider.dart';

class Debounce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = DebounceProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Debounce"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: _serverText(bloc),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.pressLike();
        },
        child: _buildIcon(bloc),
      ),
    );
  }

  Widget _serverText(DebounceBloc bloc) {
    return StreamBuilder(
      stream: bloc.likeToSever,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        String msg;
        if (snapshot.hasData) {
          msg = "Server get ${snapshot.data}";
        } else {
          msg = "Server wait data";
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

  Widget _buildIcon(DebounceBloc bloc) {
    return StreamBuilder(
      stream: bloc.like,
      initialData: false,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return Icon(snapshot.data ? Icons.favorite : Icons.favorite_border);
        }
      },
    );
  }
}
