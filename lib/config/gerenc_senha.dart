import 'package:flutter/material.dart';
import 'package:servicedesk/service/usuario_service.dart';
import 'package:servicedesk/login/esqueci_senha_page.dart';

class GerencSenha extends StatefulWidget {
  const GerencSenha({super.key});

  @override
  State<GerencSenha> createState() => _GerencSenhaState();
}

class _GerencSenhaState extends State<GerencSenha> {
  //variaveis pra mostrar/esconder senhas
  bool _verSenhaAtual = false;
  bool _verNovaSenha = false;
  bool _verConfirmarNovaSenha = false;

  final TextEditingController _senhaAtualController = TextEditingController();
  final TextEditingController _novaSenhaController = TextEditingController();
  final TextEditingController _confirmarNovaSenhaController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  void _alterar() async {
    String novaSenha = _novaSenhaController.text;
    String confirmar = _confirmarNovaSenhaController.text;

    if (novaSenha != confirmar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('A nova senha não confere, por favor verifique novamente'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await UsuarioService.alterarSenha(
        _senhaAtualController.text,
        _novaSenhaController.text,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Senha alterada com sucesso!'),
            backgroundColor: Color.fromRGBO(0, 168, 120, 1),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Senha atual incorreta ou erro ao alterar.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext contex) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, //centralizar
        title: const Text(
          'Gerenciador de Senha',
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
        // button la
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Color.fromRGBO(0, 168, 120, 1),
            foregroundColor: Colors.white,
          ),
          onPressed: _alterar,
          child: const Text('Mudar Senha'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // alinhamento a esquerda
          children: [
            const Text(
              'Senha Atual',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _senhaAtualController,
              obscureText: _verSenhaAtual ? false : true, //esconder senha
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _verSenhaAtual ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _verSenhaAtual = !_verSenhaAtual;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EsqueciSenhaPage(),
                    ),
                  );
                },
                mouseCursor: SystemMouseCursors.click,
                hoverColor: Colors.transparent,
                child: const Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(14, 51, 107, 1),
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Nova Senha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ), // espaçamento
            TextField(
              controller: _novaSenhaController,
              obscureText: _verNovaSenha ? false : true, //esconder senha
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _verNovaSenha ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _verNovaSenha = !_verNovaSenha;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 15), //espaço
            const Text(
              'Confirmar Nova Senha',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ), // espaçamento
            TextField(
              controller: _confirmarNovaSenhaController,
              obscureText: _verConfirmarNovaSenha
                  ? false
                  : true, //esconder senha
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(230, 241, 251, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _verConfirmarNovaSenha
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _verConfirmarNovaSenha = !_verConfirmarNovaSenha;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
