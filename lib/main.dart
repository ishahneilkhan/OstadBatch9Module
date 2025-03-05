import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_crud_app/providers/post_provider.dart';
import 'package:flutter_crud_app/screens/home_screen.dart';
import 'package:flutter_crud_app/services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostProvider(ApiService()),
      child: MaterialApp(
        title: 'Flutter CRUD App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HomeScreen(),
      ),
    );
  }
}
