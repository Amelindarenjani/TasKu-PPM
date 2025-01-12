import 'package:belajar_mobile/components/dialog_box.dart';
import 'package:belajar_mobile/components/todo_tile.dart';
import 'package:belajar_mobile/data/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    // if this is the first time, create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exisst data
      db.loadData();
    }
    super.initState();
  }

  final textController = TextEditingController();
  final FocusNode textFocusNode = FocusNode();

  void _onChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([textController.text, false]);
      textController.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  void createNewList() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: textController,
          focusNode: textFocusNode,
          onSave: saveNewTask,
          onCancel: () {
            Navigator.of(context).pop();
            textController.clear();
          },
        );
      },
      barrierDismissible: true,
    ).then((_) {
      textController.clear();
    });

    // focusing the textfield
    Future.delayed(const Duration(milliseconds: 100), () {
      textFocusNode.requestFocus();
    });
  }

  void editTask(int index) {
    textController.text = db.toDoList[index][0];
    showDialog(
            context: context,
            builder: (context) {
              return DialogBox(
                  controller: textController,
                  focusNode: textFocusNode,
                  onSave: () {
                    setState(() {
                      db.toDoList[index][0] = textController.text;
                      textController.clear();
                    });
                    Navigator.of(context).pop();
                  },
                  onCancel: () {
                    Navigator.of(context).pop();
                    textController.clear();
                  });
            },
            barrierDismissible: true)
        .then((_) {
      textController.clear();
    });
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
        onPressed: () {
          return createNewList();
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;

          return Center(
              child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isMobile ? double.infinity : 600,
            ),
            child: ListView.builder(
              itemCount: db.toDoList.length,
              itemBuilder: (context, index) {
                return TodoTile(
                    taskName: db.toDoList[index][0],
                    taskChanged: db.toDoList[index][1],
                    onChanged: (value) => _onChanged(value, index),
                    editFunction: (context) => editTask(index),
                    delFunction: (context) => deleteTask(index));
              },
            ),
          ));
        },
      ),
    );
  }
}
