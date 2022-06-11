// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;
  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted = false,
    this.isCancelled = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        task,
        description,
        isCancelled,
        isCompleted,
      ];

  Todo copyWith({
    String? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  static List<Todo> todos = [
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
  ];
}
