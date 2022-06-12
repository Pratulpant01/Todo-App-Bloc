import 'package:bloc_practise/blocs/todos/todos_bloc.dart';
import 'package:bloc_practise/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:bloc_practise/todo_model.dart';
import 'package:bloc_practise/todosfilter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
          bottom: TabBar(
              onTap: (tabIndex) {
                switch (tabIndex) {
                  case 0:
                    BlocProvider.of<TodosFilterBloc>(context).add(
                      updateTodos(
                        todosFilter: TodosFilter.pending,
                      ),
                    );

                    break;
                  case 1:
                    BlocProvider.of<TodosFilterBloc>(context).add(
                      updateTodos(
                        todosFilter: TodosFilter.completed,
                      ),
                    );

                    break;
                }
              },
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.pending,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.add_task,
                  ),
                ),
              ]),
        ),
        body: TabBarView(children: [
          _todos("Pending To Dos"),
          _todos("Completed To Dos"),
        ]),
      ),
    );
  }
}

BlocConsumer<TodosFilterBloc, TodosFilterState> _todos(String title) {
  return BlocConsumer<TodosFilterBloc, TodosFilterState>(
    listener: ((context, state) {
      if (state is TodosFilterLoaded) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff000A1F),
            content: Text(
              'There are ${state.filteredTodos.length} To dos in your list',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }),
    builder: (context, state) {
      if (state is TodosFilterLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is TodosFilterLoaded) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.filteredTodos.length,
                itemBuilder: (context, index) {
                  return _todoCard(context, state.filteredTodos[index]);
                },
              )
            ],
          ),
        );
      } else {
        return Text('Something Went Wrong');
      }
    },
  );
}

Card _todoCard(BuildContext context, Todo todo) {
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
                onPressed: () {
                  context.read<TodosBloc>().add(
                        UpdateTodo(
                          todo: todo.copyWith(
                            isCompleted: true,
                          ),
                        ),
                      );
                },
                icon: Icon(
                  Icons.add_task,
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<TodosBloc>().add(
                        DeleteTodo(todo: todo),
                      );
                },
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
