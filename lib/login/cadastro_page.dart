import 'package:flutter/material.dart';
import 'package:servicedesk/home/home.dart';
import 'package:servicedesk/service/auth_service.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController dataNascController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController confirmarController = TextEditingController();

  bool mostrarSenha = false;
  bool mostrarConfirmar = false;
  bool aceitouTermos = false;
  bool _carregando = false;

  Future<void> _cadastrar() async {
    if (!aceitouTermos) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Aceite os termos para continuar'),
        backgroundColor: Color(0xFF1B2D6B),
      ));
      return;
    }

    if (senhaController.text != confirmarController.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('As senhas não coincidem!'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    final email = emailController.text.trim();

    // Valida domínio antes de tentar cadastrar
    if (!AuthService.isDomainAllowed(email)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Cadastro restrito ao e-mail institucional (@souunit.com.br).'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    setState(() => _carregando = true);
    try {
      await AuthService.cadastrar(
        email: email,
        password: senhaController.text,
        nome: nomeController.text,
        dataNasc: dataNascController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {
      String msg = 'Erro ao cadastrar.';
      if (e is DomainNotAllowedException) {
        msg = 'Cadastro restrito ao domínio @souunit.com.br.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F4FF),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color(0xFF1B2D6B), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Criar uma Conta',
          style: TextStyle(
              color: Color(0xFF1B2D6B),
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _campo('Nome Completo', nomeController,
                hint: 'Example Example'),
            const SizedBox(height: 18),
            _campo('Data de Nascimento', dataNascController,
                hint: 'DD / MM / AAAA',
                tipo: TextInputType.datetime),
            const SizedBox(height: 18),
            _campo('E-mail Institucional', emailController,
                hint: 'usuario@souunit.com.br',
                tipo: TextInputType.emailAddress),
            const SizedBox(height: 18),
            _campoSenha('Senha', senhaController, mostrarSenha, () {
              setState(() => mostrarSenha = !mostrarSenha);
            }),
            const SizedBox(height: 18),
            _campoSenha(
                'Confirmar a senha', confirmarController, mostrarConfirmar,
                () {
              setState(() => mostrarConfirmar = !mostrarConfirmar);
            }),
            const SizedBox(height: 16),

            // Termos
            Row(
              children: [
                Checkbox(
                  value: aceitouTermos,
                  activeColor: const Color(0xFF1B2D6B),
                  onChanged: (v) => setState(() => aceitouTermos = v!),
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
                              fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: ' e '),
                        TextSpan(
                          text: 'Política de Privacidade',
                          style: TextStyle(
                              color: Color(0xFF1B2D6B),
                              fontWeight: FontWeight.bold),
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
                onPressed: _carregando ? null : _cadastrar,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B2D6B),
                  disabledBackgroundColor:
                      const Color(0xFF1B2D6B).withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
                child: _carregando
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : const Text(
                        'Cadastrar-se',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _campo(String label, TextEditingController ctrl,
      {String hint = '', TextInputType tipo = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B))),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          keyboardType: tipo,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
            filled: true,
            fillColor: const Color(0xFFE8EEFF),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _campoSenha(String label, TextEditingController ctrl, bool visivel,
      VoidCallback toggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1B2D6B))),
        const SizedBox(height: 6),
        TextField(
          controller: ctrl,
          obscureText: !visivel,
          decoration: InputDecoration(
            hintText: '············',
            hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
            filled: true,
            fillColor: const Color(0xFFE8EEFF),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none),
            suffixIcon: IconButton(
              icon: Icon(
                visivel
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: const Color(0xFFAAAAAA),
              ),
              onPressed: toggle,
            ),
          ),
        ),
      ],
    );
  }
}