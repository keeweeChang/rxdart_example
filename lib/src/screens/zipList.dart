import 'package:flutter/material.dart';
import '../blocs/zipProvider.dart';

class ZipList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ZipProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Zip"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: _serverList(bloc),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.fetchData([0, 1, 2]);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _serverList(ZipBloc bloc) {
    return StreamBuilder(
      stream: bloc.personInfoList,
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (!snapshot.hasData) {
          return Text("Wait Data");
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error.toString()}");
        } else {
          return _buildList(snapshot.data);
        }
      },
    );
  }

  Widget _buildList(List<String> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _buildItem(data[index]);
      },
    );
  }

  Widget _buildItem(String personInfo) {
    return Column(
      children: <Widget>[
        Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            personInfo,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        Divider(),
      ],
    );
  }
}
