import 'package:flutter/material.dart';

class ReclamosScreen extends StatelessWidget {
  const ReclamosScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reclamos'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Reclamos'),
      ),
    );
  }
}
