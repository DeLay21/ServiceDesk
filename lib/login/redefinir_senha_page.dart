import 'package:flutter/material.dart';
import 'package:servicedesk/login/login_page.dart';

class RedefinirSenhaPage extends StatefulWidget {
  const RedefinirSenhaPage({super.key});

  @override
  State<RedefinirSenhaPage> createState() => _RedefinirSenhaPageState();
}

class _RedefinirSenhaPageState extends State<RedefinirSenhaPage> {

  TextEditingController novaSenhaController      = TextEditingController();
  TextEditingController confirmarSenhaController = TextEditingController();

  bool mostrarNovaSenha      = false;
  bool mostrarConfirmarSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F4FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1B2D6B), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Esqueci a Senha',
          style: TextStyle(
            color: Color(0xFF1B2D6B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Center(
              child: Text(
                'Redefina a senha em até\nduas etapas',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 36),

            const Text(
              'Nova Senha',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B),
              ),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: novaSenhaController,
              obscureText: !mostrarNovaSenha,
              decoration: InputDecoration(
                hintText: '············',
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                filled: true,
                fillColor: const Color(0xFFE8EEFF),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    mostrarNovaSenha
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFFAAAAAA),
                  ),
                  onPressed: () {
                    setState(() {
                      mostrarNovaSenha = !mostrarNovaSenha;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),

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
              controller: confirmarSenhaController,
              obscureText: !mostrarConfirmarSenha,
              decoration: InputDecoration(
                hintText: '············',
                hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                filled: true,
                fillColor: const Color(0xFFE8EEFF),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    mostrarConfirmarSenha
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: const Color(0xFFAAAAAA),
                  ),
                  onPressed: () {
                    setState(() {
                      mostrarConfirmarSenha = !mostrarConfirmarSenha;
                    });
                  },
                ),
              ),
            ),

            const SizedBox(height: 48),

            Center(
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (novaSenhaController.text.isEmpty ||
                        confirmarSenhaController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preencha os dois campos!'),
                          backgroundColor: Color(0xFF1B2D6B),
                        ),
                      );
                      return;
                    }
                    if (novaSenhaController.text != confirmarSenhaController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('As senhas não coincidem!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1B2D6B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Redefinir',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}