import 'package:flutter/material.dart';

import 'api.dart';
import 'custom_view.dart';
import 'function_list.dart';
import 'list_route.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    _viewList = Api.getAllFunctions()
        .map((String name) => CustomView(name, Icons.storage))
        .toList();

    print(_viewList);
  }

  List<CustomView> _viewList;

  void _toView(CustomView view) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
          builder: (BuildContext context) => ListRoute(
                initialView: view,
                viewList: _viewList,
                title: widget.title,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_viewList == null) {
      return Center(
        child: Container(
          height: 80.0,
          width: 80.0,
          child: const CircularProgressIndicator(),
        ),
      );
    }

    final Widget listTile = FunctionList(
      viewList: _viewList,
      onTap: _toView,
    );

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: listTile);
  }
}
