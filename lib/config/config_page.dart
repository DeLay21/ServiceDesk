import 'package:flutter/material.dart';
import 'package:servicedesk/config/detalhes_perfil.dart';
import 'package:servicedesk/config/gerenc_senha.dart';
import 'package:servicedesk/config/notificacoes_page.dart';
import 'package:servicedesk/config/politica_page.dart';
import 'package:servicedesk/login/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  String _nome = '';
  bool _perfilCompleto = false;
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarPerfil();
  }

  Future<void> _carregarPerfil() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .get();

    setState(() {
      _nome = doc['nome'] ?? '';
      _perfilCompleto = (doc['sexo'] ?? '').toString().isNotEmpty;
      _carregando = false;
    });
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, //centralizar
        title: const Text(
          'Configuração',
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
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _carregando
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Card(
                    color: const Color.fromRGBO(232, 238, 247, 1),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.person,
                                size: 80,
                                color: Color.fromRGBO(14, 51, 107, 1),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _nome, // ← nome do Firebase
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black,
                                      ),
                                    ),
                                    if (!_perfilCompleto)
                                      const Text(
                                        'Complete seu perfil e se beneficie de uma experiência no aplicativo',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromRGBO(
                                            138,
                                            155,
                                            181,
                                            2,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            height: 20,
                            thickness: 1,
                            indent: 20,
                            color: Color.fromRGBO(197, 206, 220, 0.996),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DetalhesPerfil(),
                                ),
                              ).then((_) => _carregarPerfil());
                            },
                            mouseCursor: SystemMouseCursors.click,
                            hoverColor: Colors.transparent,
                            child: Text(
                              _perfilCompleto
                                  ? 'Ver Perfil'
                                  : 'Complete seu perfil',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(14, 51, 107, 1),
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            const SizedBox(height: 25), //espaço
            Card(
              color: const Color.fromRGBO(232, 238, 247, 1),
              elevation: 0,
              //margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ListTile(
                title: Text(
                  'Gerenciar Senha',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(14, 51, 107, 1),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(14, 51, 107, 1),
                  size: 16,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GerencSenha(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), //espaço
            Card(
              color: const Color.fromRGBO(232, 238, 247, 1),
              elevation: 0,
              //margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ListTile(
                title: Text(
                  'Política De Privacidade',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(14, 51, 107, 1),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(14, 51, 107, 1),
                  size: 16,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PoliticaPrivacidade(),
                    ),
                  );
                },
              ),
            ),
            Card(
              color: const Color.fromRGBO(232, 238, 247, 1),
              elevation: 0,
              //margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ListTile(
                title: Text(
                  'Notificações',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(14, 51, 107, 1),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(14, 51, 107, 1),
                  size: 16,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Notificacoes(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10), // espaço
            Card(
              color: const Color.fromRGBO(232, 238, 247, 1),
              elevation: 0,
              //margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
              child: ListTile(
                title: Text(
                  'Desconectar',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(14, 51, 107, 1),
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromRGBO(14, 51, 107, 1),
                  size: 16,
                ),
                onTap: () async {
                  await FirebaseAuth.instance
                      .signOut(); // desloga do Firebase
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
