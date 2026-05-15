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
          ? TimeOfDay(hour: int.parse((map['horario'] as String).split(':')[0]) , minute: int.parse((map['horario'] as String).split(':')[1]),
          ) : null,
        concluida: map['concluida'] as bool,
      );
}

List<Agendamento> AgendamentoServiceDeskGlobal = [];

class AgendamentoPage extends StatefulWidget{
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}
class _AgendamentoPageState extends State<AgendamentoPage> {
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _pedidoController = TextEditingController();

  void _salvarEVoltar(){
    if (_clienteController.text.isNotEmpty && _pedidoController.text.isNotEmpty){
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
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Novo Agendamento")),
      body: Column(
        children: [
          TextField(controller: _clienteController, decoration: const InputDecoration(labelText: "Cliente")),
          TextField(controller: _pedidoController, decoration: const InputDecoration(labelText: "Pedido")),
          ElevatedButton(
            onPressed: _salvarEVoltar,
            child: const Text("Salvar")),
        ],
      ),
    );
  }
}