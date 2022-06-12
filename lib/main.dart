import 'package:bloc_practise/blocs/todos/todos_bloc.dart';
import 'package:bloc_practise/blocs/todos_filter/todos_filter_bloc.dart';
import 'package:bloc_practise/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodosBloc()
            ..add(
              LoadTodo(
                todos: [
                  Todo(
                    id: '1',
                    task: 'Sample Todo 1',
                    description: 'This is a test Todo',
                  ),
                  Todo(
                    id: '2',
                    task: 'Sample Todo 2',
                    description: 'This is a test Todo',
                  ),
                ],
              ),
            ),
        ),
        BlocProvider(
          create: (context) => TodosFilterBloc(
            todosBloc: BlocProvider.of<TodosBloc>(context),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xff000A1F),
          appBarTheme: AppBarTheme(
            color: Color(0xff000A1F),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
