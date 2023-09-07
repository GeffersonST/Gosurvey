import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gosurvey/screens/results_screen.dart';

class Question3Screen extends StatefulWidget {
  @override
  _Question3ScreenState createState() => _Question3ScreenState();
}

class _Question3ScreenState extends State<Question3Screen> {
  int selectedRating = -1; // Nenhum selecionado por padrão
  bool isCompleted = false; // Para controlar se a seleção foi concluída

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
            Text('How likely are you to recommend our establishment to others?'),
            SizedBox(height: 20),
            buildRatingSquares(),
            SizedBox(height: 20),
            buildFinishButton(),
          ],
        ),
      ),
    );
  }

  Widget buildRatingSquares() {
    return Container(
      height: 100,
      child: ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final rating = index + 1;
          final isSelected = rating == selectedRating; // Verifique se está selecionado
          final squareSize = getSquareSize();
          final squareColor = getSquareColor(rating);

          return GestureDetector(
            onTap: () async {
              // Salva a resposta da pergunta 3 no SharedPreferences
              await saveResultsToSharedPreferences('question3', rating);
              setState(() {
                selectedRating = rating; // Atualize a seleção ao tocar
                isCompleted = true; // A seleção foi concluída
              });
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300), // Duração da animação em milissegundos
              curve: Curves.easeInOut, // Curva de animação suave
              width: squareSize,
              height: squareSize,
              margin: EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: squareColor,
                border: Border.all(
                  color: isSelected ? Colors.blue : Colors.transparent,
                  width: isSelected ? 4.0 : 2.0, // Largura da borda aumentada quando selecionado
                ),
              ),
              child: Center(
                child: Text(
                  rating.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  double getSquareSize() {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxSquareSize = screenWidth / 10 - 5; // Divide a largura da tela em 10 quadrados com espaçamento de 5
    return maxSquareSize;
  }

  Color getSquareColor(int rating) {
    // Aqui você pode definir as cores personalizadas para cada classificação
    switch (rating) {
      case 1:
        return Color(0xFFE73838);
      case 2:
        return Color(0xFFF4474A);
      case 3:
        return Color(0xFFFC664A);
      case 4:
        return Color(0xFFFD8744);
      case 5:
        return Color(0xFFFEA73F);
      case 6:
        return Color(0xFFFFC21F);
      case 7:
        return Color(0xFFE2C517);
      case 8:
        return Color(0xFFC0CA0E);
      case 9:
        return Color(0xFF9ECC06);
      case 10:
        return Color(0xFF7CCB00);
      default:
        return Colors.grey; // Cor padrão quando não está selecionado
    }
  }

  Widget buildFinishButton() {
    if (isCompleted) {
      return ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ResultsScreen()),
          );
        },
        child: Text('Finalizar'),
      );
    } else {
      return SizedBox(); // Oculta o botão se a seleção não estiver concluída
    }
  }

  // Função para salvar os resultados no SharedPreferences
  Future<void> saveResultsToSharedPreferences(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }
}
