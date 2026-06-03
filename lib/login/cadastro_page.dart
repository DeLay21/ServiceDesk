import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:servicedesk/home/home.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController dataNascController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmarController = TextEditingController();

  bool mostrarSenha = false;
  bool mostrarConfirmar = false;
  bool aceitouTermos = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F4FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF1B2D6B),
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Criar uma Conta',
          style: TextStyle(
            color: Color(0xFF1B2D6B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nome Completo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                hintText: 'Example Example',
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                filled: true,
                fillColor: const Color(0xFFE8EEFF),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Data de Nascimento',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: dataNascController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'DD / MM / YYY',
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                filled: true,
                fillColor: const Color(0xFFE8EEFF),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'E-mail ou número de celular',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'example@example.com',
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                filled: true,
                fillColor: const Color(0xFFE8EEFF),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Senha',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: senhaController,
              obscureText: !mostrarSenha,
              decoration: InputDecoration(
                hintText: '············',
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                filled: true,
                fillColor: const Color(0xFFE8EEFF),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    mostrarSenha
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFFAAAAAA),
                  ),
                  onPressed: () {
                    setState(() {
                      mostrarSenha = !mostrarSenha;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'Confirmar a senha',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: confirmarController,
              obscureText: !mostrarConfirmar,
              decoration: InputDecoration(
                hintText: '············',
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                filled: true,
                fillColor: const Color(0xFFE8EEFF),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    mostrarConfirmar
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFFAAAAAA),
                  ),
                  onPressed: () {
                    setState(() {
                      mostrarConfirmar = !mostrarConfirmar;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(
                  value: aceitouTermos,
                  activeColor: const Color(0xFF1B2D6B),
                  onChanged: (valor) {
                    setState(() {
                      aceitouTermos = valor!;
                    });
                  },
                ),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Aceitar ',
                      style: TextStyle(fontSize: 13),
                      children: [
                        TextSpan(
                          text: 'Termos de Uso',
                          style: TextStyle(
                            color: Color(0xFF1B2D6B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: ' e '),
                        TextSpan(
                          text: 'Política de Privacidade',
                          style: TextStyle(
                            color: Color(0xFF1B2D6B),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: '?'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (!aceitouTermos) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Aceite os termos para continuar'),
                        backgroundColor: Color(0xFF1B2D6B),
                      ),
                    );
                    return;
                  }
                  if (senhaController.text != confirmarController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('As senhas não coincidem!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  try {
                    final credencial = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: senhaController.text,
                        );

                    await FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(
                          credencial.user!.uid,
                        ) 
                        .set({
                          'nome': nomeController.text.trim(),
                          'email': emailController.text.trim(),
                          'dataNascimento': dataNascController.text.trim(),
                          'sexo': '',
                          'fotoPerfil': '',
                          'criadoEm': FieldValue.serverTimestamp(),
                        });

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erro ao cadastrar: $e')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B2D6B),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Cadastrar-se',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
