import 'package:flutter/material.dart';
import 'package:servicedesk/login/cadastro_page.dart';
import 'package:servicedesk/login/esqueci_senha_page.dart';
import 'package:servicedesk/home/home.dart';
import 'package:servicedesk/service/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool mostrarSenha = false;
  bool _carregando = false;

  void _setCarregando(bool v) {
    if (mounted) setState(() => _carregando = v);
  }

  void _snackErro(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  void _irParaHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  String _mensagemErro(Object e) {
    if (e is DomainNotAllowedException) {
      return 'Acesso negado. Use seu e-mail institucional (@souunit.com.br).';
    }
    return 'E-mail ou senha incorretos.';
  }

  Future<void> _loginEmailSenha() async {
    final email = emailController.text.trim();
    final senha = senhaController.text;

    if (email.isEmpty || senha.isEmpty) {
      _snackErro('Preencha e-mail e senha.');
      return;
    }

    _setCarregando(true);
    try {
      await AuthService.signInEmailSenha(email: email, password: senha);
      _irParaHome();
    } catch (e) {
      _snackErro(_mensagemErro(e));
    } finally {
      _setCarregando(false);
    }
  }

  Future<void> _loginGoogle() async {
    _setCarregando(true);
    try {
      final cred = await AuthService.signInGoogle();
      if (cred == null) return; // usuário cancelou
      _irParaHome();
    } catch (e) {
      _snackErro(_mensagemErro(e));
    } finally {
      _setCarregando(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),

                  const Text(
                    'ServiceDesk',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1B2D6B),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // E-mail
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'E-mail Institucional',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B2D6B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'usuario@souunit.com.br',
                      hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
                      filled: true,
                      fillColor: const Color(0xFFE8EEFF),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Senha
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Senha',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B2D6B),
                      ),
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
                          horizontal: 16, vertical: 14),
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
                        onPressed: () =>
                            setState(() => mostrarSenha = !mostrarSenha),
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (_) => EsqueciSenhaPage()),
                      ),
                      child: const Text(
                        'Esqueci a senha',
                        style:
                            TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Botão Login
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _carregando ? null : _loginEmailSenha,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1B2D6B),
                          disabledBackgroundColor:
                              const Color(0xFF1B2D6B).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text('Ou faça login com',
                      style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 16),

                  // Botão Google
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: _carregando ? null : _loginGoogle,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFFDDDDDD)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Logo G colorido desenhado com CustomPaint
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: CustomPaint(
                                painter: _GoogleLogoPainter()),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Continuar com Google',
                            style: TextStyle(
                              color: Color(0xFF3C3C3C),
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Column(
                    children: [
                      const Text('Não tem uma conta?',
                          style: TextStyle(fontSize: 13)),
                      TextButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (_) => CadastroPage()),
                        ),
                        child: const Text(
                          'Se inscreva',
                          style: TextStyle(
                            color: Color(0xFF1B2D6B),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Overlay de loading
            if (_carregando)
              Container(
                color: Colors.black.withOpacity(0.15),
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF1B2D6B)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;
    final rect = Rect.fromCircle(center: Offset(cx, cy), radius: r * 0.85);

    void arco(double inicio, double angulo, Color cor) {
      canvas.drawArc(
        rect,
        inicio,
        angulo,
        false,
        Paint()
          ..color = cor
          ..strokeWidth = r * 0.30
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.butt,
      );
    }

    arco(-1.57, 1.57, const Color(0xFF4285F4)); 
    arco(0.00, 1.57, const Color(0xFF34A853));  
    arco(1.57, 1.57, const Color(0xFFFBBC05)); 
    arco(3.14, 1.57, const Color(0xFFEA4335)); 

    canvas.drawLine(
      Offset(cx, cy),
      Offset(cx + r * 0.82, cy),
      Paint()
        ..color = const Color(0xFF4285F4)
        ..strokeWidth = r * 0.30
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}