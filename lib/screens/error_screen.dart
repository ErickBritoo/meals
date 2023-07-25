import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Página Não Encontrada"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Error Página não Encontrada",
              style: TextStyle(
                fontSize: 26,
                fontFamily: Theme.of(context).textTheme.titleLarge?.fontFamily,
              ),
            )
          ],
        ),
      ),
    );
  }
}
