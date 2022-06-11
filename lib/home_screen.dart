import 'package:bloc_practise/blocs/todos/todos_bloc.dart';
import 'package:bloc_practise/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoading) {
          return CircularProgressIndicator();
        }
        if (state is TodosLoaded) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Bloc Pattern To Dos'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddToDo(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        'Pending To Dos..',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          return _todoCard(state.todos[index]);
                        })
                  ]),
            ),
          );
        } else {
          return Text('Something Went Wrong');
        }
      },
    );
  }
}

Card _todoCard(Todo todo) {
  return Card(
    margin: EdgeInsets.only(bottom: 8.0, top: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '#${todo.id}: ${todo.task}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_task,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.cancel,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}
