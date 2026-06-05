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
    'horario': horario != null ? '${horario!.hour}:${horario!.minute.toString().padLeft(2, '0')}' : null,
    'finalizada': concluida,
    'usuario_logado': usuario_logado,
  };

  factory Agendamento.fromMap(Map<String, dynamic> map) => Agendamento(
    cliente: map['cliente'] as String,
    pedido: map['pedido'] as String,
    data: map['data'] != null ? DateTime.parse(map['data'] as String) : null,
    horario: map['horario'] != null
        ? TimeOfDay(
            hour: int.parse((map['horario'] as String).split(':')[0]),
            minute: int.parse((map['horario'] as String).split(':')[1]),
          )
        : null,
    concluida: map['finalizada'] as bool? ?? false,
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
  final TextEditingController _horarioController = TextEditingController();

  DateTime? _dataSelecionada;
  bool _calendarioAberto = false;
  late DateTime _mesExibido;
  Set<DateTime> _datasComAgendamento = {};

  static const _meses = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
  ];
  static const _cab = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  @override
  void initState() {
    super.initState();
    _mesExibido = DateTime(DateTime.now().year, DateTime.now().month);
    _carregarDatasAgendadas();
  }

  Future<void> _carregarDatasAgendadas() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('agendamentos')
        .get();
    final datas = <DateTime>{};
    for (final doc in snapshot.docs) {
      final dataStr = doc['data'] as String?;
      if (dataStr != null) {
        try {
          final d = DateTime.parse(dataStr);
          datas.add(DateTime(d.year, d.month, d.day));
        } catch (_) {}
      }
    }
    if (mounted) setState(() => _datasComAgendamento = datas);
  }

  Future<void> _salvarFireStore(Agendamento agendamento) async {
    try {
      await FirebaseFirestore.instance
          .collection('agendamentos')
          .add(agendamento.toMap());
    } catch (e) {
      debugPrint('Erro ao tentar salvar: $e');
    }
  }

  void _salvar() {
    if (_clienteController.text.isNotEmpty &&
        _pedidoController.text.isNotEmpty &&
        _dataSelecionada != null &&
        _horarioController.text.isNotEmpty) {
      final User? usuarioAtual = FirebaseAuth.instance.currentUser;
      final String emailLogado = usuarioAtual?.email ?? 'usuario@cliente.com.br';

      final partes = _horarioController.text.split(':');
      TimeOfDay? horario;
      if (partes.length == 2) {
        final h = int.tryParse(partes[0]);
        final m = int.tryParse(partes[1]);
        if (h != null && m != null) horario = TimeOfDay(hour: h, minute: m);
      }

      final novoAgendamento = Agendamento(
        cliente: _clienteController.text,
        pedido: _pedidoController.text,
        data: _dataSelecionada,
        horario: horario,
        concluida: false,
        usuario_logado: emailLogado,
      );

      AgendamentoServiceDeskGlobal.add(novoAgendamento);
      _salvarFireStore(novoAgendamento);
      Navigator.pop(context);
    }
  }

  String get _dataFormatada {
    if (_dataSelecionada == null) return '';
    return '${_dataSelecionada!.day.toString().padLeft(2, '0')}/'
        '${_dataSelecionada!.month.toString().padLeft(2, '0')}/'
        '${_dataSelecionada!.year}';
  }

  bool _temAgendamento(DateTime dia) =>
      _datasComAgendamento.contains(DateTime(dia.year, dia.month, dia.day));

  bool _mesmodia(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  Widget _buildCalendarioInline() {
    final hoje = DateTime.now();
    final primeiro = DateTime(_mesExibido.year, _mesExibido.month, 1);
    final ultimo = DateTime(_mesExibido.year, _mesExibido.month + 1, 0);
    final offset = primeiro.weekday % 7;
    final linhas = ((offset + ultimo.day) / 7).ceil();

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color.fromRGBO(27, 79, 138, 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Navegação de mês
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.chevron_left,
                    color: Color.fromRGBO(27, 79, 138, 1), size: 20),
                onPressed: () => setState(() =>
                    _mesExibido = DateTime(_mesExibido.year, _mesExibido.month - 1)),
              ),
              Text(
                '${_meses[_mesExibido.month - 1]} ${_mesExibido.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color.fromRGBO(27, 79, 138, 1),
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.chevron_right,
                    color: Color.fromRGBO(27, 79, 138, 1), size: 20),
                onPressed: () => setState(() =>
                    _mesExibido = DateTime(_mesExibido.year, _mesExibido.month + 1)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // Cabeçalho dos dias da semana
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _cab
                .map((d) => SizedBox(
                      width: 32,
                      child: Center(
                        child: Text(
                          d,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(27, 79, 138, 0.6),
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 4),
          // Grade de dias
          ...List.generate(linhas, (linha) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (col) {
                final indice = linha * 7 + col;
                final dia = indice - offset + 1;
                if (dia < 1 || dia > ultimo.day) {
                  return const SizedBox(width: 32, height: 32);
                }
                final data = DateTime(_mesExibido.year, _mesExibido.month, dia);
                final isHoje = _mesmodia(data, hoje);
                final isSel = _dataSelecionada != null && _mesmodia(data, _dataSelecionada!);
                final comAgendamento = _temAgendamento(data);

                Color bgColor = Colors.transparent;
                Color textColor = const Color.fromRGBO(27, 79, 138, 1);
                Border? border;

                if (isSel) {
                  bgColor = const Color.fromRGBO(27, 79, 138, 1);
                  textColor = Colors.white;
                } else if (comAgendamento) {
                  bgColor = const Color.fromRGBO(27, 79, 138, 0.12);
                  border = Border.all(
                    color: const Color.fromRGBO(27, 79, 138, 0.5),
                    width: 1,
                  );
                } else if (isHoje) {
                  bgColor = const Color.fromRGBO(27, 79, 138, 0.08);
                  border = Border.all(
                    color: const Color.fromRGBO(27, 79, 138, 0.3),
                    width: 1,
                  );
                } else {
                  border = Border.all(
                    color: const Color.fromRGBO(200, 210, 225, 1),
                    width: 1,
                  );
                }

                return GestureDetector(
                  onTap: () => setState(() {
                    _dataSelecionada = data;
                    _calendarioAberto = false;
                  }),
                  child: Container(
                    width: 32,
                    height: 32,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(8),
                      border: border,
                    ),
                    child: Center(
                      child: Text(
                        '$dia',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSel || isHoje || comAgendamento
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _pedidoController.dispose();
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            GestureDetector(
              onTap: () => setState(() => _calendarioAberto = !_calendarioAberto),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(232, 238, 247, 1),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _dataSelecionada != null ? _dataFormatada : 'Selecionar data',
                      style: TextStyle(
                        fontSize: 16,
                        color: _dataSelecionada != null
                            ? Colors.black
                            : Colors.black45,
                      ),
                    ),
                    Icon(
                      _calendarioAberto
                          ? Icons.keyboard_arrow_up
                          : Icons.calendar_today_outlined,
                      color: const Color.fromRGBO(27, 79, 138, 1),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            if (_calendarioAberto) _buildCalendarioInline(),
            const SizedBox(height: 15),

            const Text('Horário', style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _horarioController,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                hintText: 'HH:MM',
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
      ),
    );
  }
}
