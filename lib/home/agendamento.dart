import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Agendamento {
  String cliente;
  String pedido;
  DateTime? data;
  TimeOfDay? horario;
  bool concluida;
  String usuario_logado;

  Agendamento({
    required this.cliente,
    required this.pedido,
    this.data,
    this.horario,
    this.concluida = false,
    required this.usuario_logado,
  });

  Map<String, dynamic> toMap() => {
    'cliente': cliente,
    'pedido': pedido,
    'data': data?.toIso8601String(),
    'horario': horario != null ? '${horario!.hour}:${horario!.minute}' : null,
    'finalizada': concluida,
    'usuario_logado': usuario_logado,
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
    usuario_logado: (map['usuario_logado'] ?? '') as String,
  );
}

List<Agendamento> AgendamentoServiceDeskGlobal = [];

class AgendamentoModal extends StatefulWidget {
  const AgendamentoModal({super.key});

  @override
  State<AgendamentoModal> createState() => _AgendamentoModalState();
}

class _AgendamentoModalState extends State<AgendamentoModal> {
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _pedidoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _horarioController = TextEditingController();

  Future<void> _salvarFireStore(Agendamento agendamento) async {
    try{
      await FirebaseFirestore.instance.collection('agendamentos').add(agendamento.toMap());

    } catch (e) {
      debugPrint('Erro ao tentar salvar: $e');
    }
  }

  void _salvar() {
    if (_clienteController.text.isNotEmpty &&
        _pedidoController.text.isNotEmpty &&
        _dataController.text.isNotEmpty &&
        _horarioController.text.isNotEmpty) {

      final User? usuarioAtual = FirebaseAuth.instance.currentUser;
      final String emailLogado = usuarioAtual?.email ?? 'usuario@cliente.com.br';

      final novoAgendamento = Agendamento(
        cliente: _clienteController.text, 
        pedido: _pedidoController.text, 
        data: DateTime.now(),
        horario: TimeOfDay.now(),
        concluida: false,
        usuario_logado: emailLogado,
        );

        AgendamentoServiceDeskGlobal.add(novoAgendamento);
        _salvarFireStore(novoAgendamento);
        Navigator.pop(context);

    }
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _pedidoController.dispose();
    _dataController.dispose();
    _horarioController.dispose();
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
          // ← título do modal
          const Center(
            child: Text(
              'Novo Agendamento',
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

          const Text('Pedido', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _pedidoController,
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

          const Text('Data', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _dataController,
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

          const Text('Horário', style: TextStyle(fontWeight: FontWeight.bold)),
          TextField(
            controller: _horarioController,
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
