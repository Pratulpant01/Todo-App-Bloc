// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todos_filter_bloc.dart';

abstract class TodosFilterEvent extends Equatable {
  const TodosFilterEvent();

  @override
  List<Object> get props => [];
}

class UpdateFilter extends TodosFilterEvent {
  UpdateFilter();
  @override
  List<Object> get props => [];
}

class updateTodos extends TodosFilterEvent {
  final TodosFilter todosFilter;
  updateTodos({
    this.todosFilter = TodosFilter.all,
  });
  @override
  List<Object> get props => [todosFilter];
}
