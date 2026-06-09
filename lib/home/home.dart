import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servicedesk/config/detalhes_perfil.dart';
import 'package:servicedesk/home/relatorio.dart';
import 'package:servicedesk/config/notificacoes_page.dart';
import 'package:servicedesk/config/config_page.dart';
import 'package:servicedesk/home/agendamento.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _nome = '';
  int _indiceAtual = 2;
  final TextEditingController _buscaController = TextEditingController();
  String _filtroBusca = '';

  @override
  void initState() {
    super.initState();
    _carregarPerfil();
    _buscaController.addListener(() {
      setState(() => _filtroBusca = _buscaController.text.trim().toLowerCase());
    });
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  Future<void> _carregarPerfil() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(uid)
        .get();

    setState(() {
      _nome = doc['nome'] ?? '';
    });
  }

Future<void> _confirmarExclusao(BuildContext context, String docId) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Excluir agendamento',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(27, 79, 138, 1),
          ),
        ),
        content: const Text('Tem certeza que deseja excluir este agendamento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmar == true) {
      await FirebaseFirestore.instance
          .collection('agendamentos')
          .doc(docId)
          .delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(27, 79, 138, 1),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    builder: (context) => const AgendamentoModal(),
                  );
                },
                icon: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color.fromRGBO(27, 79, 138, 1),
                    size: 18,
                  ),
                ),
                label: const Text(
                  'Agendar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              alignment: Alignment.bottomCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 79, 138, 1),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: SizedBox(
                    height: 67,
                    child: BottomNavigationBar(
                      currentIndex: _indiceAtual,
                      onTap: (indice) {
                        setState(() {
                          _indiceAtual = indice;
                        });

                        if (indice == 1) {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                            ),
                            builder: (context) => const RelatorioModal(),
                          );
                        }
                        if (indice == 3) {
                        } else if (indice == 4) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DetalhesPerfil(),
                            ),
                          );
                        }
                      },
                      selectedItemColor: Colors.white,
                      unselectedItemColor: Colors.white60,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      iconSize: 28,
                      items: [
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.bookmark_border),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.bookmark),
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.download_outlined),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.download),
                          ),
                          label: '',
                        ),
                        const BottomNavigationBarItem(
                          icon: SizedBox(width: 40),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.list_alt_outlined),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.list_alt),
                          ),
                          label: '',
                        ),
                        BottomNavigationBarItem(
                          icon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.person_outline),
                          ),
                          activeIcon: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: const Icon(Icons.person),
                          ),
                          label: '',
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Color.fromRGBO(27, 79, 138, 1),
                      size: 38,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _nome,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Seja Bem-Vindo(a)!',
                      style: TextStyle(
                        fontSize: 24,
                        color: Color.fromRGBO(27, 79, 138, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Notificacoes(),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ConfigPage()),
                        );
                      },
                      icon: Icon(Icons.settings, color: Colors.black, size: 35),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _buscaController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.tune),
                suffixIcon: Icon(Icons.search),
                hintText: 'Buscar por cliente...',
                filled: true,
                fillColor: Color.fromRGBO(232, 238, 247, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('agendamentos')
                  .snapshots(),
              builder: (context, snapshot) {
                final datasComAgendamento = <DateTime>{};
                if (snapshot.hasData) {
                  for (final doc in snapshot.data!.docs) {
                    final dataStr = doc['data'] as String?;
                    if (dataStr != null) {
                      try {
                        final d = DateTime.parse(dataStr);
                        datasComAgendamento.add(DateTime(d.year, d.month, d.day));
                      } catch (_) {}
                    }
                  }
                }
                return _AgendaWidget(datasComAgendamento: datasComAgendamento);
              },
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('agendamentos')
                  .snapshots(),
              builder: (context, snapshots) {
                if (!snapshots.hasData || snapshots.data!.docs.isEmpty) {
                  return Text('Sem agendamento');
                }
                final docs = snapshots.data!.docs.where((doc) {
                  if (_filtroBusca.isEmpty) return true;
                  final cliente = (doc['cliente'] as String? ?? '').toLowerCase();
                  return cliente.contains(_filtroBusca);
                }).toList();
                if (docs.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Nenhum cliente encontrado.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return Column(
                  children: docs.map((doc) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      padding: EdgeInsets.all(20),
                      width: 890,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 238, 247, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Color.fromRGBO(27, 79, 138, 1),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  doc['cliente'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  doc['pedido'],
                                  style: TextStyle(fontSize: 18),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(27, 79, 138, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    doc['horario'] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    builder: (context) => EditarAgendamentoModal(
                                      docId: doc.id,
                                      clienteAtual: doc['cliente'] ?? '',
                                      pedidoAtual: doc['pedido'] ?? '',
                                      dataAtual: doc['data'] as String?,
                                      horarioAtual: doc['horario'] as String?,
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  margin: const EdgeInsets.only(bottom: 6),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(27, 79, 138, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            
                              GestureDetector(
                                onTap: () => _confirmarExclusao(context, doc.id),
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AgendaWidget extends StatefulWidget {
  final Set<DateTime> datasComAgendamento;
  const _AgendaWidget({required this.datasComAgendamento});

  @override
  State<_AgendaWidget> createState() => _AgendaWidgetState();
}

class _AgendaWidgetState extends State<_AgendaWidget> {
  bool _expandido = false;
  late DateTime _mesExibido;
  static const _meses = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
  ];
  static const _diasSemana = ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'];

  @override
  void initState() {
    super.initState();
    _mesExibido = DateTime(DateTime.now().year, DateTime.now().month);
  }

  List<DateTime> get _proximosSete {
    final hoje = DateTime.now();
    return List.generate(7, (i) => hoje.add(Duration(days: i)));
  }

  bool _temAgendamento(DateTime dia) =>
      widget.datasComAgendamento.contains(DateTime(dia.year, dia.month, dia.day));

  @override
  Widget build(BuildContext context) {
    final dias = _proximosSete;
    final mesAtual = _meses[DateTime.now().month - 1];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 238, 247, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mesAtual,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(27, 79, 138, 1),
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _expandido = !_expandido),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(27, 79, 138, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _expandido ? 'Recolher' : 'Expandir',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        _expandido ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final larguraCaixa = (constraints.maxWidth - 16) / 7;
              return Row(
                children: dias.map((dia) {
                  final comAgendamento = _temAgendamento(dia);
                  return Container(
                    width: larguraCaixa,
                    margin: const EdgeInsets.symmetric(horizontal: 1),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: comAgendamento
                          ? const Color.fromRGBO(27, 79, 138, 1)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${dia.day}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: comAgendamento ? Colors.white : Colors.black,
                          ),
                        ),
                        Text(
                          _diasSemana[dia.weekday % 7],
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: comAgendamento ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          if (_expandido) ...[
            const SizedBox(height: 16),
            const Divider(color: Color.fromRGBO(27, 79, 138, 0.2)),
            const SizedBox(height: 8),
            _Calendario(
              mesExibido: _mesExibido,
              datasComAgendamento: widget.datasComAgendamento,
              onMesAnterior: () => setState(
                  () => _mesExibido = DateTime(_mesExibido.year, _mesExibido.month - 1)),
              onProximoMes: () => setState(
                  () => _mesExibido = DateTime(_mesExibido.year, _mesExibido.month + 1)),
            ),
          ],
        ],
      ),
    );
  }
}

class _Calendario extends StatelessWidget {
  final DateTime mesExibido;
  final Set<DateTime> datasComAgendamento;
  final VoidCallback onMesAnterior;
  final VoidCallback onProximoMes;
  static const _meses = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
  ];
  static const _cab = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
  const _Calendario({
    required this.mesExibido,
    required this.datasComAgendamento,
    required this.onMesAnterior,
    required this.onProximoMes,
  });
  bool _temAgendamento(DateTime dia) =>
      datasComAgendamento.contains(DateTime(dia.year, dia.month, dia.day));

  @override
  Widget build(BuildContext context) {
    final hoje = DateTime.now();
    final primeiro = DateTime(mesExibido.year, mesExibido.month, 1);
    final ultimo = DateTime(mesExibido.year, mesExibido.month + 1, 0);
    final offset = primeiro.weekday % 7;
    final linhas = ((offset + ultimo.day) / 7).ceil();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left,
                  color: Color.fromRGBO(27, 79, 138, 1)),
              onPressed: onMesAnterior,
            ),
            Text(
              '${_meses[mesExibido.month - 1]} ${mesExibido.year}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(27, 79, 138, 1),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right,
                  color: Color.fromRGBO(27, 79, 138, 1)),
              onPressed: onProximoMes,
            ),
          ],
        ),
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
        ...List.generate(linhas, (linha) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (col) {
              final indice = calendarIndex(linha, col); 
              final dia = indice - offset + 1;
              if (dia < 1 || dia > ultimo.day) {
                return const SizedBox(width: 32, height: 32);
              }
              final data = DateTime(mesExibido.year, mesExibido.month, dia);
              final isHoje = data.year == hoje.year &&
                  data.month == hoje.month &&
                  data.day == hoje.day;
              final comAgendamento = _temAgendamento(data);

              return Container(
                width: 32,
                height: 32,
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: comAgendamento
                      ? const Color.fromRGBO(27, 79, 138, 1)
                      : isHoje
                          ? const Color.fromRGBO(27, 79, 138, 0.15)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: isHoje && !comAgendamento
                      ? Border.all(
                          color: const Color.fromRGBO(27, 79, 138, 0.5),
                          width: 1,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    '$dia',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isHoje || comAgendamento
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: comAgendamento
                          ? Colors.white
                          : const Color.fromRGBO(27, 79, 138, 1),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }

  int calendarIndex(int linha, int col) => linha * 7 + col;
}


class EditarAgendamentoModal extends StatefulWidget {
  final String docId;
  final String clienteAtual;
  final String pedidoAtual;
  final String? dataAtual;
  final String? horarioAtual;

  const EditarAgendamentoModal({
    super.key,
    required this.docId,
    required this.clienteAtual,
    required this.pedidoAtual,
    this.dataAtual,
    this.horarioAtual,
  });

  @override
  State<EditarAgendamentoModal> createState() => _EditarAgendamentoModalState();
}

class _EditarAgendamentoModalState extends State<EditarAgendamentoModal> {
  late TextEditingController _clienteController;
  late TextEditingController _pedidoController;
  late TextEditingController _horarioController;

  DateTime? _dataSelecionada;
  bool _calendarioAberto = false;
  late DateTime _mesExibido;

  static const _meses = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
  ];
  static const _cab = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  @override
  void initState() {
    super.initState();
    _clienteController = TextEditingController(text: widget.clienteAtual);
    _pedidoController = TextEditingController(text: widget.pedidoAtual);
    _horarioController = TextEditingController(text: widget.horarioAtual ?? '');

    if (widget.dataAtual != null) {
      try {
        _dataSelecionada = DateTime.parse(widget.dataAtual!);
      } catch (_) {}
    }
    _mesExibido = _dataSelecionada != null
        ? DateTime(_dataSelecionada!.year, _dataSelecionada!.month)
        : DateTime(DateTime.now().year, DateTime.now().month);
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _pedidoController.dispose();
    _horarioController.dispose();
    super.dispose();
  }

  Future<void> _salvarEdicao() async {
    if (_clienteController.text.isNotEmpty &&
        _pedidoController.text.isNotEmpty &&
        _dataSelecionada != null &&
        _horarioController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('agendamentos')
          .doc(widget.docId)
          .update({
        'cliente': _clienteController.text,
        'pedido': _pedidoController.text,
        'data': _dataSelecionada!.toIso8601String(),
        'horario': _horarioController.text,
      });
      if (mounted) Navigator.pop(context);
    }
  }

  String get _dataFormatada {
    if (_dataSelecionada == null) return '';
    return '${_dataSelecionada!.day.toString().padLeft(2, '0')}/'
        '${_dataSelecionada!.month.toString().padLeft(2, '0')}/'
        '${_dataSelecionada!.year}';
  }

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
                final isSel =
                    _dataSelecionada != null && _mesmodia(data, _dataSelecionada!);

                Color bgColor = Colors.transparent;
                Color textColor = const Color.fromRGBO(27, 79, 138, 1);
                Border? border;

                if (isSel) {
                  bgColor = const Color.fromRGBO(27, 79, 138, 1);
                  textColor = Colors.white;
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
                          fontWeight:
                              isSel || isHoje ? FontWeight.bold : FontWeight.normal,
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
                'Editar Agendamento',
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
                        color: _dataSelecionada != null ? Colors.black : Colors.black45,
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
                onPressed: _salvarEdicao,
                child: const Text('Salvar Alterações'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
