import 'package:flutter/material.dart';

class EsqueciSenhaPage extends StatefulWidget {
  const EsqueciSenhaPage({super.key});

  @override
  State<EsqueciSenhaPage> createState() => _EsqueciSenhaPageState();
}

class _EsqueciSenhaPageState extends State<EsqueciSenhaPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Esqueci a senha')),
    );
  }
}