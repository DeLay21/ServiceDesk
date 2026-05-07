import 'package:flutter/material.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  @override
  void dispose() {
    super.dispose();
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
            Card(
              color: const Color.fromRGBO(230, 241, 251, 1),
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
                        const SizedBox(width: 16), //espaço
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Carla Meneses',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Complete seu perfil e se beneficie de uma experiência no aplicativo',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromRGBO(138, 155, 181, 2),
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
                      endIndent: 0,
                      color: Color.fromRGBO(197, 206, 220, 0.996),
                    ),
                    const Text(
                      'Complete seu Perfil',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(14, 51, 107, 1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25), //espaço
            Card(
              color: const Color.fromRGBO(230, 241, 251, 1),
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
                onTap: () {},
              ),
            ),
            const SizedBox(height: 10), //espaço
            Card(
              color: const Color.fromRGBO(230, 241, 251, 1),
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
                onTap: () {},
              ),
            ),
            Card(
              color: const Color.fromRGBO(230, 241, 251, 1),
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
                onTap: () {},
              ),
            ),
            const SizedBox(height: 10), // espaço
            Card(
              color: const Color.fromRGBO(230, 241, 251, 1),
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
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
