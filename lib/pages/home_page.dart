import 'package:flutter/material.dart';
import 'package:flutter_final_exam/util/dialog_box.dart';
import 'package:flutter_final_exam/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _controller = TextEditingController();

  List toDoList = [
    ["Sleep", false],
    ["Eat", false],
    ["Read Book", false],
  
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([ _controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
    },);
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void editTask(index) {
    setState(() {
      toDoList.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 82, 171, 244),
        title: Center(
          child: Text('TO DO LIST')
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 82, 171, 244),
        onPressed: createNewTask,
        child: Icon(
          Icons.add,
          color: const Color.fromARGB(255, 126, 16, 8)
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset('assets/image.jpg'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: toDoList.length,
              itemBuilder: (context, index) {
                return ToDoTile(
                  taskName: toDoList[index][0],
                  taskCompleted: toDoList[index][1],
                  onChanged: (value) => checkBoxChanged(value, index),
                  deleteFunction: (context) => deleteTask(index),
                  editFunction: (context) => editTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 