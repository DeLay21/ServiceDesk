import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:servicedesk/service/usuario_service.dart';

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
    final doc = await UsuarioService.buscarPerfil();

    setState(() {
      nomeController.text = doc['nome'] ?? '';
      emailController.text = doc['email'] ?? '';
      sexoController.text = (doc['sexo'] ?? '');
      dataNascController.text = doc['dataNascimento'] ?? '';
    });
  }

  Future<void> _salvar() async {
    final jaExisteEmail = await UsuarioService.existsByEmail(
      emailController.text.trim(),
    );

    if (jaExisteEmail) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('O email inserido já está em uso!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await UsuarioService.atualizarPerfil({
        'nome': nomeController.text.trim(),
        'email': emailController.text.trim(),
        'sexo': sexoController.text.trim(),
        'dataNascimento': dataNascController.text.trim(),
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil atualizado com sucesso!'),
            backgroundColor: Color.fromRGBO(0, 168, 120, 1),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZÀ-ÿ\s]')),
              ],
              decoration: InputDecoration(
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
            DropdownButtonFormField<String>(
              initialValue: sexoController.text.isEmpty
                  ? null
                  : sexoController.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
              items: const [
                DropdownMenuItem(value: 'M', child: Text('Masculino')),
                DropdownMenuItem(value: 'F', child: Text('Feminino')),
              ],
              onChanged: (valor) {
                setState(() {
                  sexoController.text = valor ?? '';
                });
              },
            ),
            const SizedBox(height: 15),
            const Text(
              'Data de Nascimento',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            InkWell(
              onTap: () async {
                final dataSelecionada = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2000),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (dataSelecionada != null) {
                  setState(() {
                    dataNascController.text =
                        '${dataSelecionada.day.toString().padLeft(2, '0')}/'
                        '${dataSelecionada.month.toString().padLeft(2, '0')}/'
                        '${dataSelecionada.year}';
                  });
                }
              },
              child: IgnorePointer(
                child: TextField(
                  controller: dataNascController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(230, 241, 251, 1),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(13)),
                      borderSide: BorderSide.none,
                    ),
                    suffixIcon: const Icon(Icons.calendar_today, size: 18),
                  ),
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
