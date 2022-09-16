// this package facilitates building a material-style app
import 'package:flutter/material.dart';

void main() {
  runApp(Todo());
}

class Todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // displays the TodoList widget
    return MaterialApp(home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  // tracks todo list state
  @override
  _TodoListState createState() => _TodoListState();
}

// we use a stateful widget rather than a stateless one in order to support adding/deleting todos
class _TodoListState extends State<TodoList> {
  // save data added to todo list
  final List<String> _todoList = <String>[];
  // text field to enter todos
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // adds AppBar and ListView widgets to page
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(children: _getItems()),
      // adds items to the todo list
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add or delete item',
          child: Icon(Icons.change_circle)),
    );
  }

  // adds todos to _todoList
  void _addTodoItem(String title) {
    // the setState function notifies our app that the state has changed when we add a todo
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  // deletes todos from _todoList
  void _deleteTodoItem(String title) {
    // the setState function notifies our app that the state has changed when we delete a todo
    setState(() {
      _todoList.remove(title);
    });
    _textFieldController.clear();
    print(_todoList);
  }

  // populates the list view
  Widget _buildTodoItem(String title) {
    return ListTile(title: Text(title));
  }

  // displays a dialog for the users to input todos
  Future<AlertDialog> _displayDialog(BuildContext context) async {
    // shows the dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add or delete task'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              // button to add todos
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              // button to delete todos
              TextButton(
                child: const Text('DELETE'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteTodoItem(_textFieldController.text);
                },
              )
            ],
          );
        // the .then handles the response of the showDialog function which is asynchronous
        }).then((value) => value ?? false);;
  }
  // iterates through todo list titles and adds widgets for each todo
  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}