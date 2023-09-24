part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}
class TodoLoading extends TodoState {}
class TodoError extends TodoState {
  final String message;

  TodoError(this.message);

}
class TodoSuccess extends TodoState {
  final List<String> todoBox;

  void addTask(String task){
    todoBox.add(task);
  }
  TodoSuccess(this.todoBox);
}


