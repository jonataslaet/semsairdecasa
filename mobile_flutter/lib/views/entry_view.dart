import 'package:flutter/material.dart';

class EntryView extends StatelessWidget {
  const EntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerenciador de Cidades'),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cities');
              },
              child: const Text('Cadastrar cidade de Teresina'),
            ),
          ],
        ),
      ),
    );
  }
}