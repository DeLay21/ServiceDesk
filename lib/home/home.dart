import 'package:cloud_firestore/cloud_firestore.dart';
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

  //bool _hoverHome = false;
  int _indiceAtual = 2;
  Widget _CaixaDias(String dia, String semana, bool selecionado) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
      decoration: BoxDecoration(
        color: selecionado ? Color.fromRGBO(27, 79, 138, 1) : Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            dia,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: selecionado ? Colors.white : Colors.black,
            ),
          ),
          Text(
            semana,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: selecionado ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
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

            Container(
              width: double.infinity,
              height: 180,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(232, 238, 247, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Abril',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(27, 79, 138, 1),
                    ),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _CaixaDias('9', 'SEG', false),
                      _CaixaDias('10', 'TER', false),
                      _CaixaDias('11', 'QUA', true),
                      _CaixaDias('12', 'QUI', false),
                      _CaixaDias('13', 'SEX', false),
                      _CaixaDias('14', 'SAB', false),
                    ],
                  ),
                ],
              ),
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
                final docs = snapshots.data!.docs;

                return Column(
                  children: docs.map((doc) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
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

                          Expanded(child: Column(
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
                                style: TextStyle(
                                  fontSize: 18,
                                ),
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
                            doc['horario'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                              )
                            ],
                          ))
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
            ),
          ],
        ),
      ),
    );
  }
}
