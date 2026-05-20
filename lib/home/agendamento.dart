import 'package:flutter/material.dart';

class Agendamento {
  String cliente;
  String pedido;
  DateTime? data;
  TimeOfDay? horario;
  bool concluida;

  Agendamento({
    required this.cliente,
    required this.pedido,
    this.data,
    this.horario,
    this.concluida = false,
  });

  Map<String, dynamic> toMap() => {
    'cliente': cliente,
    'pedido': pedido,
    'data': data?.toIso8601String(),
    'horario': horario != null ? '${horario!.hour}:${horario!.minute}' : null,
    'finalizada': concluida,
  };

  factory Agendamento.fromMap(Map<String, dynamic> map) => Agendamento(
    cliente: map['cliente'] as String,
    pedido: map['pedido'] as String,
    data: map['data'] != null ? DateTime.parse(map['Data'] as String) : null,
    horario: map['horario'] != null
        ? TimeOfDay(
            hour: int.parse((map['horario'] as String).split(':')[0]),
            minute: int.parse((map['horario'] as String).split(':')[1]),
          )
        : null,
    concluida: map['concluida'] as bool,
  );
}

List<Agendamento> AgendamentoServiceDeskGlobal = [];

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _pedidoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horarioController = TextEditingController();

  void _salvarEVoltar() {
    if (_clienteController.text.isNotEmpty &&
        _pedidoController.text.isNotEmpty &&
        _dataController.text.isNotEmpty &&
        _horarioController.text.isNotEmpty) {
      AgendamentoServiceDeskGlobal.add(
        Agendamento(
          cliente: _clienteController.text,
          pedido: _pedidoController.text,
          data: DateTime.now(),
          horario: TimeOfDay.now(),
          concluida: false,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Novo Agendamento")),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Color.fromRGBO(27, 79, 138, 1),
            foregroundColor: Colors.white,
          ),
          onPressed: _salvarEVoltar,
          child: const Text('Confirmar'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cliente',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _clienteController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(232, 238, 247, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Pedido',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _pedidoController,
              decoration: InputDecoration(
                //labelText: 'Qual é seu nome?',
                filled: true,
                fillColor: Color.fromRGBO(232, 238, 247, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Data',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _dataController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(232, 238, 247, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Horário',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextField(
              controller: _horarioController,
              decoration: InputDecoration(
                //labelText: 'Qual é seu nome?',
                filled: true,
                fillColor: Color.fromRGBO(232, 238, 247, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
