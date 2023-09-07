import 'package:flutter/material.dart';
import 'results_screen.dart'; // Importe a tela de resultados

class ThankYouScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agradecemos por responder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Obrigado por responder à avaliação!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegue para a tela de resultados
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ResultsScreen()),
                );
              },
              child: Text('Continuar'),
            ),
          ],
        ),
      ),
    );
  }
}
