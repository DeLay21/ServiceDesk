import 'package:flutter/material.dart';
import 'package:servicedesk/login/login_page.dart';
import 'package:servicedesk/config/notificacoes_page.dart';
import 'package:servicedesk/config/config_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indiceAtual = 2;
    Widget _CaixaDias(String dia, String semana, bool selecionado) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 18),
            decoration: BoxDecoration(
                color: selecionado
                    ? Color.fromRGBO(27, 79, 138, 1) : Colors.white,
                    borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                children: [
                    Text(
                        dia,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: selecionado
                                ? Colors.white : Colors.black,
                        ),
                    ),
                    Text(
                        semana,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: selecionado
                            ? Colors.white : Colors.black,
                        ),
                    )
                ],
            ),
        );
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(padding: EdgeInsets.all(20),
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
                                        Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => const Notificacoes()),
                                        );
                                    },
                                    icon: Icon(Icons.notifications, color: Colors.black, size: 35,),
                                ),
                                IconButton(
                                    onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => ConfigPage()),
                                        );
                                    },
                                    icon: Icon(Icons.settings, color: Colors.black, size: 35,)
                                ),
                            ],
                        )
                    ],
                ),
                SizedBox(height: 20,),

                TextField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.tune),
                        suffixIcon: Icon(Icons.search),
                        filled: true,
                        fillColor: Color.fromRGBO(232, 238, 247,1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                        ),
                    ),
                ),
                SizedBox(height: 20,),

                Container(
                    width: double.infinity,
                    height: 180,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(232, 238, 247,1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Text(
                                'April',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(27, 79, 138,1)
                                ),
                            ),
                            SizedBox(height: 20,),

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

                SizedBox(height: 20,),

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
                                child: Icon(Icons.person, color: Colors.white, size: 40,),
                            ),
                            
                            SizedBox(width: 20,),

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
                                        Text(
                                            'Furador de Bolo',
                                            style: TextStyle(
                                                fontSize: 16,
                                            ),
                                        ),
                                        
                                        Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2,),
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
                                        )
                                    ],
                                ),
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                                    SizedBox(height: 15,),
                                    Icon(
                                        Icons.arrow_forward_ios,
                                        size: 30,
                                    )
                                ]
                            )
                        ],
                    ),
                ),
                //Barra de navegação
                Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(27, 79, 138, 1),
                        borderRadius: BorderRadius.circular(30),
                    ),
                    child: BottomNavigationBar(
                        currentIndex: _indiceAtual,
                    onTap: (indice) {
                        setState(() {
                            _indiceAtual = indice;
                        });
                    },
                    selectedItemColor: Colors.white,
                    unselectedItemColor: Colors.white60,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    items: [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.bookmark_border, size: 28),
                            activeIcon: Icon(Icons.bookmark, size: 28),
                            label: 'Favoritos',
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.download_outlined, size: 28),
                            activeIcon: Icon(Icons.download, size: 28),
                            label: 'Adicionar',
                        ),
                        BottomNavigationBarItem(
                            icon: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.home,
                                    color: Color.fromRGBO(27, 79, 138, 1), size: 36),
                            ),
                            activeIcon: Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.home,
                                    color: Color.fromRGBO(27, 79, 138, 1), size: 36),
                            ),
                            label: 'Home',
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.list_alt_outlined, size: 28),
                            activeIcon: Icon(Icons.list_alt, size: 28),
                            label: 'Chamados',
                        ),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.person_outline, size: 28),
                            activeIcon: Icon(Icons.person, size: 28),
                            label: 'Perfil',
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
