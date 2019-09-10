enum TaskStatus {
  none,
  progress,
  cancelled,
  completed
}

class Task {
  Task(this.title, this.status, this.detail);

  String title;
  TaskStatus status;
  String detail;
}