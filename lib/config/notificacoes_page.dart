import 'package:flutter/material.dart';

class Notificacoes extends StatefulWidget {
  const Notificacoes({super.key});

  @override
  State<Notificacoes> createState() => _NotificacoesState();
}

class _NotificacoesState extends State<Notificacoes> {
  bool light0 = true;
  bool light1 = true;

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, //centralizar
        title: const Text(
          'Notificações',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(14, 51, 107, 1),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(
            height: 1,
            thickness: 1,
            color: Color.fromRGBO(197, 206, 220, 0.996),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sons',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Switch(
                  value: light0,
                  activeThumbColor: Colors.white,
                  activeTrackColor: Color.fromRGBO(14, 51, 107, 1),
                  inactiveThumbColor: Color.fromRGBO(14, 51, 107, 1),
                  inactiveTrackColor: Color.fromRGBO(230, 241, 251, 1),
                  onChanged: (bool value) {
                    setState(() {
                      light0 = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Som de chamada',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Switch(
                  value: light1,
                  activeThumbColor: Colors.white,
                  activeTrackColor: Color.fromRGBO(14, 51, 107, 1),
                  inactiveThumbColor: Color.fromRGBO(14, 51, 107, 1),
                  inactiveTrackColor: Color.fromRGBO(230, 241, 251, 1),
                  onChanged: (bool value) {
                    setState(() {
                      light1 = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Toque de Chamada',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(14, 51, 107, 1),
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
