import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    super.dispose();
  }

  void _entrar() {}

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
          onPressed: _entrar,
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
              //controller: _emailController,
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
              child: GestureDetector(
                onTap: () {},
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
              //controller: _emailController,
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
              //controller: _emailController,
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
