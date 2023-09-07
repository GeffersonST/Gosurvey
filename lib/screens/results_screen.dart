import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultsScreen extends StatefulWidget {
  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  String question1Response = '';
  String question2Response = '';
  bool question3Response = false;

  int satisfiedCount = 0;
  int goodCount = 0;
  int okayCount = 0;
  int notSatisfiedCount = 0;

  int excellentCount = 0;
  int goodProductCount = 0;
  int fairCount = 0;
  int poorCount = 0;

  int yesCount = 0;
  int noCount = 0;

  @override
  void initState() {
    super.initState();
    loadResponses();
  }

  Future<void> loadResponses() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      question1Response = prefs.getString('question1') ?? 'No response';
      question2Response = prefs.getString('question2') ?? 'No response';
      question3Response = prefs.getBool('question3') ?? false;
    });

    // Chame a função para calcular as contagens com base nas respostas existentes
    calculateCounts();
  }

  Future<void> calculateCounts() async {
    final prefs = await SharedPreferences.getInstance();

    // Calcula as contagens com base nas respostas armazenadas
    satisfiedCount = prefs.getInt('satisfiedCount') ?? 0;
    goodCount = prefs.getInt('goodCount') ?? 0;
    okayCount = prefs.getInt('okayCount') ?? 0;
    notSatisfiedCount = prefs.getInt('notSatisfiedCount') ?? 0;
    excellentCount = prefs.getInt('excellentCount') ?? 0;
    goodProductCount = prefs.getInt('goodProductCount') ?? 0;
    fairCount = prefs.getInt('fairCount') ?? 0;
    poorCount = prefs.getInt('poorCount') ?? 0;
    yesCount = prefs.getInt('yesCount') ?? 0;
    noCount = prefs.getInt('noCount') ?? 0;

    // Atualize as contagens com base nas respostas atuais
    switch (question1Response) {
      case 'Satisfied':
        satisfiedCount++;
        break;
      case 'Good':
        goodCount++;
        break;
      case 'Okay':
        okayCount++;
        break;
      case 'Not Satisfied':
        notSatisfiedCount++;
        break;
    }

    switch (question2Response) {
      case 'Excellent':
        excellentCount++;
        break;
      case 'Good':
        goodProductCount++;
        break;
      case 'Fair':
        fairCount++;
        break;
      case 'Poor':
        poorCount++;
        break;
    }

    if (question3Response) {
      yesCount++;
    } else {
      noCount++;
    }

    // Salve as novas contagens no SharedPreferences
    prefs.setInt('satisfiedCount', satisfiedCount);
    prefs.setInt('goodCount', goodCount);
    prefs.setInt('okayCount', okayCount);
    prefs.setInt('notSatisfiedCount', notSatisfiedCount);
    prefs.setInt('excellentCount', excellentCount);
    prefs.setInt('goodProductCount', goodProductCount);
    prefs.setInt('fairCount', fairCount);
    prefs.setInt('poorCount', poorCount);
    prefs.setInt('yesCount', yesCount);
    prefs.setInt('noCount', noCount);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Survey Results'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Question 1 Response: $question1Response'),
              SizedBox(height: 20),
              Column(
                children: [
                  Text('Counts for Question 1:'),
                  Container(
                    height: 200,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Colors.green,
                            value: satisfiedCount.toDouble(),
                            title: 'Satisfied',
                          ),
                          PieChartSectionData(
                            color: Colors.blue,
                            value: goodCount.toDouble(),
                            title: 'Good',
                          ),
                          PieChartSectionData(
                            color: Colors.yellow,
                            value: okayCount.toDouble(),
                            title: 'Okay',
                          ),
                          PieChartSectionData(
                            color: Colors.red,
                            value: notSatisfiedCount.toDouble(),
                            title: 'Not Satisfied',
                          ),
                        ],
                        sectionsSpace: 0,
                        centerSpaceRadius: 30,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text('Question 2 Response: $question2Response'),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text('Counts for Question 2:'),
                      Container(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Colors.green,
                                value: excellentCount.toDouble(),
                                title: 'Excellent',
                              ),
                              PieChartSectionData(
                                color: Colors.blue,
                                value: goodProductCount.toDouble(),
                                title: 'Good',
                              ),
                              PieChartSectionData(
                                color: Colors.yellow,
                                value: fairCount.toDouble(),
                                title: 'Fair',
                              ),
                              PieChartSectionData(
                                color: Colors.red,
                                value: poorCount.toDouble(),
                                title: 'Poor',
                              ),
                            ],
                            sectionsSpace: 0,
                            centerSpaceRadius: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Column(
                children: [
                  Text('Question 3 Response: $question3Response'),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Text('Counts for Question 3:'),
                      Container(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                color: Colors.green,
                                value: yesCount.toDouble(),
                                title: 'Yes',
                              ),
                              PieChartSectionData(
                                color: Colors.red,
                                value: noCount.toDouble(),
                                title: 'No',
                              ),
                            ],
                            sectionsSpace: 0,
                            centerSpaceRadius: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
