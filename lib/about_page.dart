import 'package:flutter/material.dart';

import 'api.dart';
import 'package:flutter_demo/widgets/custom_progress_indicator.dart';
import 'utils/capitalize.dart';

class AboutPage extends StatefulWidget {
  const AboutPage();

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  _AboutPageState() {
    final Api api = Api();

    api.retrieveAboutFields().then((Map<String, dynamic> data) {
      _initAboutPage(data['author']);
    });
  }

  Map<String, dynamic> _author;

  void _initAboutPage(Map<String, dynamic> author) {
    setState(() {
      _author = author;
    });
  }

  Widget _createField(String fieldName, String value) {
    return Text('$fieldName: $value', style: Theme.of(context).textTheme.title);
  }

  Widget _getField({@required String fieldName, String value}) {
    return _createField(fieldName,
        value != null && value.isNotEmpty ? value : _author[fieldName]);
  }

  @override
  Widget build(BuildContext context) {
    if (_author == null) {
      return const CustomProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
            children: <String>['Author', 'Email', 'Website']
                .map<Widget>(
                    (String fieldName) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _getField(fieldName: fieldName),
                    ))
                .toList()),
      ),
    );
  }
}
