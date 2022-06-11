import 'package:bloc_practise/blocs/todos/todos_bloc.dart';
import 'package:bloc_practise/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToDo extends StatelessWidget {
  AddToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDescription = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add to Dos'),
      ),
      body: BlocListener<TodosBloc, TodosState>(
        listener: (context, state) {
          if (state is TodosLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("To Do Added Successfuly"),
              ),
            );
          }
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                _inputField('ID', controllerId),
                _inputField('Task', controllerTask),
                _inputField('Description', controllerDescription),
                ElevatedButton(
                  onPressed: () {
                    var todo = Todo(
                      id: controllerId.text,
                      task: controllerTask.text,
                      description: controllerDescription.text,
                    );
                    context.read<TodosBloc>().add(AddTodo(todo: todo));
                  },
                  child: Text('Add Todo'),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_inputField(String label, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '${label}:',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(
        height: 50,
        margin: EdgeInsets.only(
          bottom: 10,
        ),
        width: double.infinity,
        child: TextFormField(
          controller: controller,
        ),
      )
    ],
  );
}
