import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'custom_view.dart';

const double _rowHeight = 100.0;
final BorderRadius _borderRadius = BorderRadius.circular(30.0);

class FunctionTile extends StatelessWidget {
  const FunctionTile({
    Key key,
    @required this.view,
    @required this.onTap,
  })  : assert(view != null),
        assert(onTap != null),
        super(key: key);

  final CustomView view;
  final ValueChanged<CustomView> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: Theme.of(context).primaryColor,
          splashColor: Theme.of(context).primaryColor,
          onTap: () => onTap(view),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    view.iconLocation,
                    size: 60.0,
                  ),
                ),
                Center(
                  child: Text(
                    view.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
