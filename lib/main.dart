import 'package:flutter/material.dart';
import 'package:servicedesk/login/login_page.dart';

void main() {
  runApp(const ServiceDesk());
}

class ServiceDesk extends StatelessWidget {
  const ServiceDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromRGBO(27, 79, 138, 1)),
      home: LoginPage(),
    );
  }
}