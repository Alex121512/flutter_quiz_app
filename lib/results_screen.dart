import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './questions_summary.dart';
import './data/questions.dart';

class ResultsScreen extends StatelessWidget {
  final List<String> chosenAnswers;
  final VoidCallback onPressedRestart;

  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.onPressedRestart});

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestion = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answered $numCorrectQuestions out of $numTotalQuestion questions correctly!',
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.restart_alt,
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              onPressed: onPressedRestart,
              label: const Text(
                'Restart quiz!',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
