import 'package:flutter/material.dart';

class Relatorio {
  String cliente;
  DateTime? inicio;
  DateTime? fim;
  String tipo;

  Relatorio({
    required this.cliente,
    this.inicio,
    this.fim,
    required this.tipo,
  });

  Map<String, dynamic> toMap() => {
    'cliente': cliente,
    'inicio': inicio?.toIso8601String(),
    'fim': fim?.toIso8601String(),
    'tipo': tipo,
  };

  factory Relatorio.fromMap(Map<String, dynamic> map) => Relatorio(
    cliente: map['cliente'] as String,
    inicio: map['inicio'] != null
        ? DateTime.parse(map['inicio'] as String)
        : null,
    fim: map['fim'] != null ? DateTime.parse(map['fim'] as String) : null,
    tipo: map['tipo'] as String,
  );
}

List<Relatorio> RelatorioServiceDeskGlobal = [];

class RelatorioModal extends StatefulWidget {
  const RelatorioModal({super.key});

  @override
  State<RelatorioModal> createState() => _RelatorioModalState();
}

class _RelatorioModalState extends State<RelatorioModal> {
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _inicioController = TextEditingController();
  final TextEditingController _fimController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();

  void _salvar() {
    if (_clienteController.text.isNotEmpty &&
        _inicioController.text.isNotEmpty &&
        _fimController.text.isNotEmpty &&
        _tipoController.text.isNotEmpty) {
      RelatorioServiceDeskGlobal.add(
        Relatorio(
          cliente: _clienteController.text,
          inicio: DateTime.now(),
          fim: DateTime.now(),
          tipo: _tipoController.text,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _inicioController.dispose();
    _fimController.dispose();
    _tipoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 25,
        right: 25,
        top: 25,
        bottom: MediaQuery.of(context).viewInsets.bottom + 25,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Relatório',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(27, 79, 138, 1),
              ),
            ),
          ),
          const SizedBox(height: 20),

          const Text('Cliente', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _clienteController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(232, 238, 247, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15),

          const Text('Início', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _inicioController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(232, 238, 247, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15),

          const Text('Fim', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _fimController,
            keyboardType: TextInputType.datetime,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(232, 238, 247, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 15),

          const Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _tipoController,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(232, 238, 247, 1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 25),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color.fromRGBO(27, 79, 138, 1),
                foregroundColor: Colors.white,
              ),
              onPressed: _salvar,
              child: const Text('Confirmar'),
            ),
          ),
        ],
      ),
    );
  }
}
