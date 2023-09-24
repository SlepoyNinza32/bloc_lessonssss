import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'todo_event.dart';

part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    List<String> tasks = [];
    on<TodoEvent>((event, emit) {});
    on<AddTask>((event, emit) {
      tasks.add(event.task);

      emit(TodoSuccess(tasks));
    });
    on<PutTask>((event, emit) {
      //tasks.add(event.task);
      tasks.insert(event.index, event.task);
      //tasks[event.index] = event.task;
      //emit(TodoLoading());
      emit(TodoSuccess(tasks));
    });
    on<DeleteTask>((event, emit) {
      //tasks.add(event.task);
      tasks.removeAt(event.index);
      emit(TodoSuccess(tasks));
    });
  }
}
