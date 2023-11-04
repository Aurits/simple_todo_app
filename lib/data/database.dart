import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];
  //reference the box
  final _mybox = Hive.box('todo');

  //create initial list first time openning the app
  void createInitialData() {
    todoList = [
      ['Buy milk', false],
      ['Buy eggs', false],
      ['Buy bread', false],
    ];
  }

  //load data from the database
  void loadData() {
    todoList = _mybox.get('todoList');
  }

  //update the database
  void updateDatabase() {
    _mybox.put('todoList', todoList);
  }
}
