class Todo {
  static int _counter = 0;
  final int id;
  final String title;
  bool isDone;
  Todo({required this.title})
      : id = ++_counter,
        isDone = false;
  String get status => isDone ? 'выполнено' : 'в процессе';
  void complete() {
    isDone = true;
  }
  @override
  String toString() {
    String mark = isDone ? '[x]' : '[ ]';
    return '$mark $id. $title ($status)';
  }
}
