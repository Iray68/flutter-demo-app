import 'package:flutter/material.dart';

import 'api.dart';
import 'task.dart';
import 'widgets/custom_progress_indicator.dart';

class TodoList extends StatefulWidget {
  TodoList(Map<String, dynamic> props) {
    if (props != null) {
      status = props['status'];
    } else {
      status = null;
    }
  }

  TaskStatus status;

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  _TodoListState();

  List<Task> _taskList;
  final Api _api = Api();
  final EdgeInsets _padding = const EdgeInsets.all(8.0);

  @override
  void didUpdateWidget(TodoList oldWidget) {
    if (oldWidget.status != widget.status) {
      _retrieveList();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _retrieveList();

    super.initState();
  }

  void _retrieveList() {
    _api.retrieveTodoList(widget.status).then((List<Task> taskList) {
      _initTaskList(taskList);
    });
  }

  void _initTaskList(List<Task> taskList) {
    setState(() {
      _taskList = taskList;
    });
  }

  Widget _createField(String text) {
    return Padding(
      padding: _padding,
      child: Text(text, style: Theme.of(context).textTheme.title),
    );
  }

  Widget _buildCard(Task task) {
    final bool isInProgress = task.status == TaskStatus.progress;

    Icon icon;

    switch (task.status) {
      case TaskStatus.progress:
        icon = Icon(Icons.golf_course);
        break;
      case TaskStatus.completed:
        icon = Icon(Icons.playlist_add_check);
        break;
      case TaskStatus.cancelled:
        icon = Icon(Icons.not_interested);
        break;
      default:
        icon = Icon(Icons.new_releases);
        break;
    }

    return Card(
      child: Scaffold(
        body: Padding(
          padding: _padding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  _createField(task.title),
                  _createField(task.detail),
                ],
              ),
              Padding(
                padding: _padding,
                child: icon,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(isInProgress
              ? Icons.check
              : Icons.touch_app),
          mini: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_taskList == null) {
      return const CustomProgressIndicator();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount:
            MediaQuery.of(context).orientation == Orientation.portrait ? 1 : 2,
        childAspectRatio: 3,
        children: _taskList.map<Widget>((Task task) {
          return _buildCard(task);
        }).toList(),
      ),
    );
  }
}
