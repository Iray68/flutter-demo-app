import 'package:flutter/material.dart';

class CustomView {
  CustomView(this.name, this.iconLocation, {this.props});

  final String name;
  final IconData iconLocation;

  Map<String, dynamic> props = <String, dynamic>{};

  static CustomView from(CustomView view) {
    return CustomView(view.name, view.iconLocation);
  }

  CustomView addViewProps(Map<String, dynamic> other) {
    if (props == null) {
      props = other;
    } else {
      props.addAll(other);
    }

    return this;
  }

  Map<String, dynamic> getProps() {
    return props;
  }
}
