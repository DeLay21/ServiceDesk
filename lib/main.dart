import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(const ServiceDesk());
}

class ServiceDesk extends StatelessWidget {
  const ServiceDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Color.fromRGBO(27, 79, 138, 1)),
    );
  }
}
