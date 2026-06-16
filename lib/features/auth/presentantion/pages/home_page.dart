import 'package:flutter/material.dart';

import '../../data/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _authService = AuthService();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: (){
          _authService.logout();
        }, icon: Icon(Icons.logout))
      ],),
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}
