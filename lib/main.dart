import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuuu/todo_bloc.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TodoBloc(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController taskController = TextEditingController();
  TextEditingController editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.9,
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (context, state) {
                  if (state is TodoSuccess) {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          Container(height: 2, color: Colors.green),
                      itemBuilder: (context, index) => ListTile(
                        leading: Text(index.toString()),
                        trailing: IconButton(
                          onPressed: () {
                            BlocProvider.of<TodoBloc>(context).add(
                              DeleteTask(index),
                            );
                          },
                          icon: Icon(Icons.delete),
                        ),
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Edit'),
                            content: TextField(
                              controller: editController,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 3),
                                ),
                                label: Text('Please write changes'),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  borderSide:
                                      BorderSide(color: Colors.green, width: 3),
                                ),
                              ),
                            ),
                            actions: [
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cansel'),
                              ),
                              MaterialButton(
                                onPressed: () {
                                  BlocProvider.of<TodoBloc>(context).add(
                                    PutTask(editController.value.text, index),
                                  );
                                  taskController.text = '';
                                  Navigator.pop(context);
                                },
                                child: Text('Edit'),
                              ),
                            ],
                          ),
                        ),
                        title: Text('${(state as TodoSuccess).todoBox[index]}'),
                      ),
                      itemCount: (state as TodoSuccess).todoBox.length,
                    );
                  } else if (state is TodoLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  } else {
                    return Center(child: Text('EmptY'));
                  }
                },
              ),
            ),
            // Divider(
            //   height: 3,
            //   color: Colors.green,
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.1,
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              child: TextField(
                controller: taskController,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    borderSide: BorderSide(color: Colors.green, width: 3),
                  ),
                  label: Text('Please write task'),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    borderSide: BorderSide(color: Colors.green, width: 3),
                  ),
                  suffix: IconButton(
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context)
                          .add(AddTask(taskController.value.text));
                      taskController.text = '';
                    },
                    icon: Icon(Icons.send, color: Colors.green),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
