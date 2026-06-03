import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetalhesPerfil extends StatefulWidget {
  const DetalhesPerfil({super.key});

  @override
  State<DetalhesPerfil> createState() => _DetalhesPerfilState();
}

class _DetalhesPerfilState extends State<DetalhesPerfil> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sexoController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();

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
      nomeController.text = doc['nome'] ?? '';
      emailController.text = doc['email'] ?? '';
      sexoController.text = (doc['sexo'] ?? '');
      dataNascController.text = doc['dataNascimento'] ?? '';
    });
  }

  Future<void> _salvar() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('usuarios').doc(uid).update({
        'nome': nomeController.text.trim(),
        'email': emailController.text.trim(),
        'sexo': sexoController.text.trim(),
        'dataNascimento': dataNascController.text.trim(),
      });

      if (mounted) Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao salvar: $e')));
    }
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
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
              controller: nomeController,
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
              controller: emailController,
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
              controller: sexoController,
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
              controller: dataNascController,
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
