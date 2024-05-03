import 'package:flutter/material.dart';

class DenunciasScreen extends StatelessWidget {
  const DenunciasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Denuncias'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Denuncias'),
      ),
    );
  }
}
