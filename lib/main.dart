import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portal do Aluno'), centerTitle: true),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Text(
                'Olá, Aluno!',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {},
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAMAAADDpiTIAAAAA3NCSVQICAjb4U/gAAAACXBIWXMAARNvAAETbwHN4iDCAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAAv1QTFRF////AwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEAwEEMLqDUQAAAP50Uk5TAAECAwQFBgcI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',
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Novo Cadastro',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Aluno',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.face),
              ),
            ),

            const SizedBox(height: 20),

            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Matrícula',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.fingerprint),
              ),
            ),

            const SizedBox(height: 20),

            const TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 25),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Interesses:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: [
                ActionChip(label: const Text('Mobile'), onPressed: () {}),
                ActionChip(label: const Text('Web'), onPressed: () {}),
                ActionChip(label: const Text('IA'), onPressed: () {}),
              ],
            ),

            const SizedBox(height: 40),

            ElevatedButton.icon(
              onPressed: () {
                String nome = _nomeController.text;

                print('Dados enviados com sucesso!');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cadastra com sucesso $nome')),
                );
              },
              icon: const Icon(Icons.check),
              label: const Text('FINALIZAR CADASTRO'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
