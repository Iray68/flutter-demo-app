import 'package:flutter/material.dart';

import 'custom_view.dart';
import 'function_tile.dart';

const double _padding = 8.0;
const String _mainFunctionName = 'Task List';

class FunctionList extends StatelessWidget {
  const FunctionList(
      {@required this.onTap, @required this.viewList});

  final ValueChanged<CustomView> onTap;
  final List<CustomView> viewList;

  Widget _buildMainContent(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Container(
          height: 110.0,
          child: FlatButton(
              splashColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () => onTap(viewList[0]),
              child: Column(
                children: <Widget>[
                  Icon(Icons.edit, size: 80.0),
                  Text(_mainFunctionName, style: Theme.of(context).textTheme.title)
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildSubContent(Orientation orientation) {
    if (orientation == Orientation.portrait) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: _padding),
        itemCount: viewList.length,
        itemBuilder: (BuildContext context, int index) => FunctionTile(
          view: viewList[index],
          onTap: onTap,
        ),
      );
    } else {
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 3,
        children: viewList.map((CustomView view) {
          return FunctionTile(
            view: view,
            onTap: onTap,
          );
        }).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Orientation orientation = MediaQuery.of(context).orientation;

    final Widget listView = Container(
        padding: const EdgeInsets.symmetric(horizontal: _padding),
        child: _buildSubContent(orientation));

    return Container(
        child: Column(
      children: <Widget>[
        Expanded(
          child: _buildMainContent(context),
          flex: 1,
        ),
        Expanded(
          child: listView,
          flex: (orientation == Orientation.portrait) ? 3 : 1,
        )
      ],
    ));
  }
}