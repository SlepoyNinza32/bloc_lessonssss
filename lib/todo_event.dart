part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class AddTask extends TodoEvent{
final String task;
  AddTask(this.task);
}
class PutTask extends TodoEvent{
  final String task;
  final int index;

  PutTask(this.task, this.index);
}
class DeleteTask extends TodoEvent{
  final int index;

  DeleteTask(this.index);
}