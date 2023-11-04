import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:our_task/data/database.dart';
import 'package:our_task/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the Hive box
  final _mybox = Hive.box('todo');

  TodoDatabase todoDatabase = TodoDatabase();

  @override
  void initState() {
    //if this is the first time opening the app then create the initial data

    if (_mybox.get('todoList') == null) {
      todoDatabase.createInitialData();
      todoDatabase.updateDatabase();
    }
    super.initState();
  }

  String word = "";

  void checkboxChanged(bool value, int index) {
    setState(() {
      todoDatabase.todoList[index][1] = !todoDatabase.todoList[index][1];
    });
  }

//create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.yellow[200],
            title: const Text("Add a new task"),
            content: TextField(
              decoration: InputDecoration(
                hintText: "Enter task name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

              // i want to only add to the list when the person clicks add

              onChanged: (value) {
                setState(() {
                  word = value;
                });
              },
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      todoDatabase.todoList.add([word, false]);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text("TO DO"),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoDatabase.todoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoDatabase.todoList[index][0],
            taskCompleted: todoDatabase.todoList[index][1],
            onChanged: (value) => checkboxChanged(value!, index),
            deleteFunction: (BuildContext) => setState(() {
              todoDatabase.todoList.removeAt(index);
              todoDatabase.updateDatabase();
            }),
          );
        },
      ),
    );
  }
}
