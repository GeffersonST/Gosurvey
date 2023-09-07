import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gosurvey/screens/question2_screen.dart';

class Question1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('How satisfied are you with our service?'),
            SizedBox(height: 20),
            buildResponseButton(context, 'Satisfied', Colors.green, '😄'),
            SizedBox(height: 10), // Espaço vertical entre os botões
            buildResponseButton(context, 'Good', Colors.blue, '😃'),
            SizedBox(height: 10), // Espaço vertical entre os botões
            buildResponseButton(context, 'Okay', Colors.yellow, '😐'),
            SizedBox(height: 10), // Espaço vertical entre os botões
            buildResponseButton(context, 'Not Satisfied', Colors.red, '😞'),
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
          // Save the response to question 1
          await saveResultsToSharedPreferences('question1', response);

          // Navigate to the next question (Question2Screen) after saving the response
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Question2Screen()),
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
  Future<void> saveResultsToSharedPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }
}
