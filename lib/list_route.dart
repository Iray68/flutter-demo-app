import 'package:flutter/material.dart';

import 'about_page.dart';
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
    print('props: ${view.getProps()}');
    switch(view.name) {
      case 'SubList1':
        return const Text('Welcome');
        break;
      case 'About':
        return const AboutPage();
      default:
        return Text('This is ${view.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Backdrop(
        currentView: _currentView ?? widget.viewList[0],
        frontPanel: _router(_currentView),
        backPanel: FunctionList(onTap: _onMenuTap, viewList: widget.viewList),
        frontTitle: Text(widget.title),
        backTitle: const Text('Select'));
  }
}
