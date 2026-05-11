import 'package:flutter/material.dart';

class DetalhesPerfil extends StatefulWidget {
  const DetalhesPerfil({super.key});

  @override
  State<DetalhesPerfil> createState() => _DetalhesPerfilState();
}

class _DetalhesPerfilState extends State<DetalhesPerfil> {
  @override
  void dispose() {
    super.dispose();
  }

  void _salvar() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, //centralizar
        title: const Text(
          'Detalhes do Perfil',
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Color.fromRGBO(0, 168, 120, 1),
            foregroundColor: Colors.white,
          ),
          onPressed: _salvar,
          child: const Text('Salvar'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // alinhamento a esquerda
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: const Color.fromRGBO(230, 241, 251, 1),
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Color.fromRGBO(14, 51, 107, 1),
                ),
              ),
            ),
            const Text(
              'Nome',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              //controller: _emailController,
              decoration: InputDecoration(
                //labelText: 'Qual é seu nome?',
                filled: true,
                fillColor: Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Email',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              //controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                //labelText: 'Qual é seu Email?',
                filled: true,
                fillColor: Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Sexo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              //controller: _emailController,
              decoration: InputDecoration(
                //labelText: 'Qual é seu nome?',
                filled: true,
                fillColor: Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Data de Nascimento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              //controller: _emailController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                //labelText: 'Qual é seu Email?',
                filled: true,
                fillColor: Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Essas informações serão usadas para identificar possíveis riscos de segurança relacionados ao seus medicamentos.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(117, 117, 117, 1),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
