import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuizApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  bool isStartPage = true;
  int score = 0;

  List<Map> allQuestions = [
    {'question': "Who is the founder of Microsoft?", 'options': ["Steve Jobs", "Elon Musk", "Bill Gates", "Larry Page"], 'correctAnswer': 2},
    {'question': "Who is the Founder of Apple?", 'options': ["Steve Jobs", "Bill Gates", "Elon Musk", "Larry Page"], 'correctAnswer': 0},
    {'question': "Who is the founder of Google?", 'options': ["Steve Jobs", "Elon Musk", "Bill Gates", "Larry Page"], 'correctAnswer': 3},
    {'question': "Who is the founder of OpenAI?", 'options': ["Sam Altman", "Elon Musk", "Bill Gates", "Larry Page"], 'correctAnswer': 0},
    {'question': "Who is the Founder of SpaceX?", 'options': ["Steve Jobs", "Elon Musk", "Bill Gates", "Larry Page"], 'correctAnswer': 1},
  ];

  int currentQuestionIndex = 0;
  int selectedAnswerIndex = -1;
  bool isQuestionPage = true;

  WidgetStatePropertyAll<Color?> checkAnswer(int answerIndex) {
    if (selectedAnswerIndex != -1) {
      if (answerIndex == allQuestions[currentQuestionIndex]['correctAnswer']) {
        return const WidgetStatePropertyAll(Colors.green);
      } else if (selectedAnswerIndex == answerIndex) {
        return const WidgetStatePropertyAll(Colors.red);
      }
    }
    return const WidgetStatePropertyAll(null);
  }

  @override
  Widget build(BuildContext context) {
    if (isStartPage) {
      return Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                isStartPage = false;
              });
            },
            child: const Text("Start Quiz", style: TextStyle(fontSize: 20)),
          ),
        ),
      );
    }

    return quizAppPage();
  }

  Scaffold quizAppPage() {
    if (isQuestionPage) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("QuizApp",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.orange)),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 120),
                Text("Question : ${currentQuestionIndex + 1}/${allQuestions.length}",
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 380,
              child: Text(allQuestions[currentQuestionIndex]['question'],
                  style: const TextStyle(fontSize: 25, color: Colors.purple, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),

            for (int i = 0; i < allQuestions[currentQuestionIndex]['options'].length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: checkAnswer(i)),
                    onPressed: () {
                      if (selectedAnswerIndex == -1) {
                        selectedAnswerIndex = i;
                        if (i == allQuestions[currentQuestionIndex]['correctAnswer']) {
                          score++;
                        }
                        setState(() {});
                      }
                    },
                    child: Text(allQuestions[currentQuestionIndex]['options'][i],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // ✅ FIXED
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  if (currentQuestionIndex > 0) {
                    currentQuestionIndex--;
                    selectedAnswerIndex = -1;
                    setState(() {});
                  }
                },
                backgroundColor: Colors.blue,
                child: const Text("Prev", style: TextStyle(fontSize: 15, color: Colors.orange)),
              ),
              FloatingActionButton(
                onPressed: () {
                  if (selectedAnswerIndex != -1) {
                    if (currentQuestionIndex < allQuestions.length - 1) {
                      currentQuestionIndex++;
                      selectedAnswerIndex = -1;
                    } else {
                      isQuestionPage = false;
                    }
                    setState(() {});
                  }
                },
                backgroundColor: Colors.blue,
                child: const Text("Next", style: TextStyle(fontSize: 15, color: Colors.orange)),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(backgroundColor: Colors.blue, centerTitle: true, title: const Text("Result Screen", style: TextStyle(fontSize: 30))),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.network("https://tse2.mm.bing.net/th/id/OIP.sz4fIixQ1wm0_fihZ66uwwHaDt?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                  width: 400, height: 440, fit: BoxFit.fill),
              const SizedBox(height: 40),
              Text("Your Score: $score/${allQuestions.length}", style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              const Text("🎉 Congratulations! 🎉", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      );
    }
  }
}
