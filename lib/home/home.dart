import 'package:flutter/material.dart';
import 'package:servicedesk/config/detalhes_perfil.dart';
import 'package:servicedesk/home/relatorio.dart';
import 'package:servicedesk/login/login_page.dart';
import 'package:servicedesk/config/notificacoes_page.dart';
import 'package:servicedesk/config/config_page.dart';
import 'package:servicedesk/home/agendamento.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 2;

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
                      'Isaac Kerllon',
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
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.tune),
                suffixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color.fromRGBO(232, 238, 247, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),

            const _AgendaWidget(),

            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(20),
              width: 890,
              height: 130,
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
                    child: Icon(Icons.person, color: Colors.white, size: 40),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Isaac',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Furador de Bolo', style: TextStyle(fontSize: 16)),

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
                            '15:00',
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(27, 79, 138, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '15/04',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _AgendaWidget extends StatefulWidget {
  const _AgendaWidget();

  @override
  State<_AgendaWidget> createState() => _AgendaWidgetState();
}

class _AgendaWidgetState extends State<_AgendaWidget> {
  late DateTime _diaSelecionado;
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
    _diaSelecionado = DateTime.now();
    _mesExibido = DateTime(DateTime.now().year, DateTime.now().month);
  }

  List<DateTime> get _proximosSete {
    final hoje = DateTime.now();
    return List.generate(7, (i) => hoje.add(Duration(days: i)));
  }

  bool _mesmodia(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    final dias = _proximosSete;

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
                _meses[_diaSelecionado.month - 1],
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
                  final ativo = _mesmodia(dia, _diaSelecionado);
                  return GestureDetector(
                    onTap: () => setState(() => _diaSelecionado = dia),
                    child: Container(
                      width: larguraCaixa,
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: ativo
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
                              color: ativo ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            _diasSemana[dia.weekday % 7],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: ativo ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
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
            _CalendarioCompleto(
              mesExibido: _mesExibido,
              diaSelecionado: _diaSelecionado,
              onMesAnterior: () => setState(
                  () => _mesExibido = DateTime(_mesExibido.year, _mesExibido.month - 1)),
              onProximoMes: () => setState(
                  () => _mesExibido = DateTime(_mesExibido.year, _mesExibido.month + 1)),
              onDiaSelecionado: (d) => setState(() => _diaSelecionado = d),
            ),
          ],
        ],
      ),
    );
  }
}

class _CalendarioCompleto extends StatelessWidget {
  final DateTime mesExibido;
  final DateTime diaSelecionado;
  final VoidCallback onMesAnterior;
  final VoidCallback onProximoMes;
  final ValueChanged<DateTime> onDiaSelecionado;

  static const _meses = [
    'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
    'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
  ];
  static const _cab = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];

  const _CalendarioCompleto({
    required this.mesExibido,
    required this.diaSelecionado,
    required this.onMesAnterior,
    required this.onProximoMes,
    required this.onDiaSelecionado,
  });

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
              final indice = linha * 7 + col;
              final dia = indice - offset + 1;
              if (dia < 1 || dia > ultimo.day) {
                return const SizedBox(width: 32, height: 32);
              }
              final data = DateTime(mesExibido.year, mesExibido.month, dia);
              final isHoje = data.year == hoje.year &&
                  data.month == hoje.month &&
                  data.day == hoje.day;
              final isSel = data.year == diaSelecionado.year &&
                  data.month == diaSelecionado.month &&
                  data.day == diaSelecionado.day;
              return GestureDetector(
                onTap: () => onDiaSelecionado(data),
                child: Container(
                  width: 32,
                  height: 32,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  decoration: BoxDecoration(
                    color: isSel
                        ? const Color.fromRGBO(27, 79, 138, 1)
                        : isHoje
                            ? const Color.fromRGBO(27, 79, 138, 0.15)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: isHoje && !isSel
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
                        fontWeight: isHoje || isSel
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSel
                            ? Colors.white
                            : const Color.fromRGBO(27, 79, 138, 1),
                      ),
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
}
