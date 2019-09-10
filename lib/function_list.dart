import 'package:flutter/material.dart';

import 'custom_view.dart';
import 'function_tile.dart';
import 'task.dart';

const double _padding = 8.0;
const String _mainFunctionName = 'Start';

class FunctionList extends StatelessWidget {
  const FunctionList({@required this.onTap, @required this.viewList});

  final ValueChanged<CustomView> onTap;
  final List<CustomView> viewList;

  CustomView _createViewWithProps(int index, Map<String, dynamic> props) {
    final CustomView target = viewList[index];

    return CustomView.from(target)..addViewProps(props);
  }

  Widget _buildMainContent(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Container(
          height: 110.0,
          child: FlatButton(
              color: Theme.of(context).primaryColor,
              splashColor: Theme.of(context).splashColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              onPressed: () => onTap(_createViewWithProps(
                  0, <String, dynamic>{'status': TaskStatus.progress})),
              child: Column(
                children: <Widget>[
                  Icon(Icons.domain, size: 80.0),
                  Text(_mainFunctionName,
                      style: Theme.of(context).textTheme.title)
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
        color: Theme.of(context).secondaryHeaderColor,
        padding: const EdgeInsets.symmetric(horizontal: _padding),
        child: _buildSubContent(orientation));

    return Container(
        color: Theme.of(context).backgroundColor,
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
