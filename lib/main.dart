import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:project/todos/view/todos_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
         primarySwatch: Colors.blue,
        ),
        home: const TodosPage(),
      ),
    );
  }
}

