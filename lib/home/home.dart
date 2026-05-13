import 'package:flutter/material.dart';
import 'package:servicedesk/login/login_page.dart';
import 'package:servicedesk/config/notificacoes_page.dart';
import 'package:servicedesk/config/config_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(padding: EdgeInsets.all(20),
        child: Column(
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    'Isaac Kerllon',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                                Text(
                                    'Seja Bem-Vindo(a)!',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Color.fromRGBO(27, 79, 138, 1),
                                        fontWeight: FontWeight.bold,
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            children: [
                                IconButton(
                                    onPressed: () {
                                        Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const Notificacoes()),
                                        );
                                    },
                                    icon: Icon(Icons.notifications, color: Colors.black, size: 35,),
                                ),
                                IconButton(
                                    onPressed: () {
                                        Navigator.push(
                                            context, 
                                            MaterialPageRoute(builder: (context) => ConfigPage()),
                                        );
                                    },
                                    icon: Icon(Icons.settings, color: Colors.black, size: 35,)
                                ),
                            ],
                        )
                    ],
                ),
                SizedBox(height: 20,),

                TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.tune),
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color.fromRGBO(232, 238, 247,1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                        ),
                    ),
                )
            ],
        ),
        ),
    );
  }
}
