import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gosurvey/screens/question3_screen.dart';

class Question2Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('How would you rate the quality of our product?'),
            SizedBox(height: 20),
            Wrap(
              spacing: 10, // Espaçamento horizontal entre os botões
              runSpacing: 10, // Espaçamento vertical entre os botões
              children: [
                buildResponseButton(context, 'Excellent', Colors.green, '👍'),
                buildResponseButton(context, 'Good', Colors.blue, '🙂'),
                buildResponseButton(context, 'Fair', Colors.yellow, '😐'),
                buildResponseButton(context, 'Poor', Colors.red, '👎'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResponseButton(BuildContext context, String response, Color color, String emoji) {
    return SizedBox(
      width: 120, // Largura desejada para o botão
      height: 60, // Altura desejada para o botão
      child: ElevatedButton(
        onPressed: () async {
          // Save the response to question 2
          await saveResultsToSharedPreferences('question2', response);

          // Navigate to the next question (Question3Screen) after saving the response
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Question3Screen()),
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
