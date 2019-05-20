import 'package:flutter/material.dart';
import 'addtodo.dart';
import 'home.dart';
import 'showimage.dart';
import 'addimage.dart';
import 'todoscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      initialRoute: "/",
                    routes: {
                      "/": (context) => Addpost(),
                      
                    }
      // home: MyHomePage(),
    );
  }
}
