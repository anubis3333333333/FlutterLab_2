import 'dart:io';
import 'package:lib/todo.dart';
import 'package:ansicolor/ansicolor.dart';



void printMenu() {
  print('');
  print(yellowPen('ToDo список'));
  print('add    – добавить задачу');
  print('list   – показать все задачи');
  print('done   – отметить выполненной');
  print('delete – удалить задачу');
  print('exit   – выйти');
}

void addTodo(List<Todo> todos) {
  stdout.write(bluePen('Название задачи: '));
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print(redPen('Ошибка: название не может быть пустым'));
    return;
  }

  todos.add(Todo(title: input.trim()));
  print(greenPen('Задача добавлена!'));
}

void listTodos(List<Todo> todos) {
  if (todos.isEmpty) {
    print(yellowPen('Список задач пуст.'));
    return;
  }

  print('');
  for (var todo in todos) {
    print(todo); 
  }
}

void completeTodo(List<Todo> todos) {
  stdout.write('ID задачи для отметки: ');
  String? input = stdin.readLineSync();

  if (input == null) return;

  int? id = int.tryParse(input.trim());
  if (id == null) {
    print(redPen('Ошибка: введите корректное число'));
    return;
  }

  for (var todo in todos) {
    if (todo.id == id) {
      todo.complete();
      print(greenPen('Задача успешно выполнена!'));
      return;
    }
  }

  print(redPen('Задача с ID $id не найдена.'));
}

void deleteTodo(List<Todo> todos) {
  stdout.write('ID задачи для удаления: ');
  String? input = stdin.readLineSync();

  if (input == null) return;

  int? id = int.tryParse(input.trim());
  if (id == null) {
    print(redPen('Ошибка: введите корректное число'));
    return;
  }

  for (int i = 0; i < todos.length; i++) {
    if (todos[i].id == id) {
      todos.removeAt(i);
      print(greenPen('Задача успешно удалена!'));
      return;
    }
  }

  print(redPen('Задача с ID $id не найдена.'));
}

void main() {
  
  ansiColorDisabled = false;
  
  List<Todo> todos = [];
  printMenu();

  while (true) {
    stdout.write('> ');
    String? input = stdin.readLineSync();
    if (input == null) continue;
    
    String command = input.trim().toLowerCase();
    if (command.isEmpty) continue;

    switch (command) {
      case 'add':
        addTodo(todos);
        break;
      case 'list':
        listTodos(todos);
        break;
      case 'done':
        completeTodo(todos);
        break;
      case 'delete':
        deleteTodo(todos);
        break;
      case 'exit':
        print(yellowPen('До свидания!'));
        return;
      default:
        printMenu();
        print(redPen('Неизвестная команда. Попробуйте ещё раз.'));
    }
  }
}
