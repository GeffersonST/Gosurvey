import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gosurvey/screens/results_screen.dart';

class Question3Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 3'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Would you recommend our establishment to others?'),
            SizedBox(height: 20),
            buildResponseButton(context, 'Yes', Colors.green, '👍'),
            SizedBox(height: 10), // Espaço vertical entre os botões
            buildResponseButton(context, 'No', Colors.red, '👎'),
          ],
        ),
      ),
    );
  }

  Widget buildResponseButton(BuildContext context, String response, Color color, String emoji) {
    return SizedBox(
      width: 200, // Largura desejada para o botão
      height: 60, // Altura desejada para o botão
      child: ElevatedButton(
        onPressed: () async {
          // Save the response to question 3
          await saveResultsToSharedPreferences('question3', response == 'Yes');

          // Navigate to the results screen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultsScreen()),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(response),
            SizedBox(height: 5),
            Text(emoji, style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }

  // Função para salvar os resultados no SharedPreferences
  Future<void> saveResultsToSharedPreferences(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
