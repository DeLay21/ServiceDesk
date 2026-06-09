import 'package:flutter/material.dart';
import 'package:servicedesk/login/login_page.dart';
import 'package:servicedesk/login/cadastro_page.dart';
import 'package:servicedesk/login/esqueci_senha_page.dart';
import 'package:servicedesk/login/redefinir_senha_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ServiceDesk());
}

class ServiceDesk extends StatelessWidget {
  const ServiceDesk({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromRGBO(27, 79, 138, 1),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/cadastro': (context) => CadastroPage(),
        '/esqueci': (context) => EsqueciSenhaPage(),
        '/redefinir': (context) => RedefinirSenhaPage(),
      },
    );
  }
}
