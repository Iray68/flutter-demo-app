import 'package:flutter/material.dart';

import 'backdrop.dart';
import 'custom_view.dart';
import 'function_list.dart';

class ListRoute extends StatefulWidget {
  const ListRoute(
      {@required this.viewList,
      @required this.title,
      @required this.initialView});

  final List<CustomView> viewList;
  final String title;
  final CustomView initialView;

  @override
  State<StatefulWidget> createState() {
    return _ListRouteState();
  }
}

class _ListRouteState extends State<ListRoute> {
  CustomView _currentView;

  @override
  void initState() {
    _currentView = widget.initialView;
    super.initState();
  }

  void _onMenuTap(CustomView view) {
    setState(() {
      _currentView = view;
    });
  }

  Widget _router(CustomView view) {
    switch(view.name) {
      case 'SubList1':
        return Text('Welcome');
        break;
      default:
        return Text('This is ${view.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
        currentView: _currentView == null ? widget.viewList[0] : _currentView,
        frontPanel: _router(_currentView),
        backPanel: FunctionList(onTap: _onMenuTap, viewList: widget.viewList),
        frontTitle: Text(widget.title),
        backTitle: const Text('Select'));
  }
}
