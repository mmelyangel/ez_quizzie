import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'result_screen.dart';
import 'category_screen.dart';

class QuizScreen extends StatefulWidget {
  final String category;

  QuizScreen({required this.category});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<Map<String, dynamic>> questions = [];
  int currentQuestionIndex = 0;
  int score = 0;
  bool soundOn = true;

  @override
  void initState() {
    super.initState();
    loadQuestions(widget.category);
  }

  void toggleSound() {
    setState(() {
      soundOn = !soundOn;
    });
  }

  void loadQuestions(String category) {
    switch (category) {
      case 'ABC':
        questions = [
          {
            'question': 'What letter comes after A?',
            'options': ['B', 'C', 'D'],
            'answer': 'B'
          },
          {
            'question': 'What letter comes before R?',
            'options': ['Q', 'S', 'T'],
            'answer': 'Q'
          },
          {
            'question': 'What letter comes after Y?',
            'options': ['Z', 'W', 'X'],
            'answer': 'Z'
          },
        ];
        break;

      case 'Colors':
        questions = [
          {
            'question': 'What color is the sky?',
            'options': ['Blue', 'Red', 'Green'],
            'answer': 'Blue'
          },
          {
            'question': 'What color is the banana?',
            'options': ['Orange', 'Yellow', 'Green'],
            'answer': 'Yellow'
          },
          {
            'question': 'What color is the leaf?',
            'options': ['Orange', 'Yellow', 'Green'],
            'answer': 'Green'
          },
        ];
        break;

      case 'Numbers':
        questions = [
          {
            'question': 'What number comes after 2?',
            'options': ['5', '4', '3'],
            'answer': '3'
          },
          {
            'question': 'What number comes before 5?',
            'options': ['2', '4', '3'],
            'answer': '4'
          },
          {
            'question': 'What number comes after 5?',
            'options': ['2', '4', '6'],
            'answer': '6'
          },
        ];
        break;

      case 'Shapes':
        questions = [
          {
            'question': 'What shape has three sides?',
            'options': ['Square', 'Triangle', 'Circle'],
            'answer': 'Triangle'
          },
          {
            'question': 'What shape has four equal sides?',
            'options': ['Diamond', 'Rectangle', 'Square'],
            'answer': 'Square'
          },
          {
            'question': 'What shape has no sides?',
            'options': ['Diamond', 'Circle', 'Square'],
            'answer': 'Circle'
          },
        ];
        break;
    }
  }

  void playSound() async {
    if (soundOn) {
      await audioPlayer.play(AssetSource('assets/soundeffects.mp3'));
    }
  }

  void checkAnswer(String answer) {
    if (answer == questions[currentQuestionIndex]['answer']) {
      score++;
      playSound();
    }

    setState(() {
      currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return ResultScreen(score: score);
    }

    var currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        leading: IconButton(
          icon: Image.network(
            'https://cdn-icons-png.flaticon.com/512/93/93634.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Image.network(
              'https://cdn-icons-png.flaticon.com/512/1828/1828479.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Exit Quiz'),
                  content:
                      const Text('Are you sure you want to exit the quiz?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryScreen()),
                        );
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'EZ Quizzie - ${widget.category}',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Image.network(
                        soundOn
                            ? 'https://cdn-icons-png.flaticon.com/512/727/727269.png'
                            : 'https://cdn-icons-png.flaticon.com/512/727/727245.png',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      onPressed: toggleSound,
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  'Question ${currentQuestionIndex + 1}:',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  currentQuestion['question'],
                  style: TextStyle(fontSize: 20, color: Colors.white70),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40),
                ...List<Widget>.from(
                  (currentQuestion['options'] as List<String>).map((option) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => checkAnswer(option),
                          child: Text(option),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
