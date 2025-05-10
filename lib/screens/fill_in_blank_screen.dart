import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/option_tile.dart';
import '../widgets/progress_bar.dart';

class FillInBlankScreen extends StatefulWidget {
  final List<Question> questions;

  const FillInBlankScreen({super.key, required this.questions});

  @override
  State<FillInBlankScreen> createState() => _FillInBlankScreenState();
}

class _FillInBlankScreenState extends State<FillInBlankScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  bool _isAnswered = false;
  bool _isCorrect = false;
  int _score = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkAnswer(String answer) {
    if (_isAnswered) return;

    final currentQuestion = widget.questions[_currentQuestionIndex];
    final isCorrect = answer == currentQuestion.correctAnswer;

    setState(() {
      _selectedAnswer = answer;
      _isAnswered = true;
      _isCorrect = isCorrect;
      if (isCorrect) {
        _score++;
      }
    });

    _animationController.forward();

    // Move to next question after delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (_currentQuestionIndex < widget.questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _selectedAnswer = null;
          _isAnswered = false;
          _isCorrect = false;
        });
        _animationController.reset();
      } else {
        // Show completion dialog
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.celebration,
                size: 60,
                color: Colors.amber,
              ),
              const SizedBox(height: 16),
              Text(
                'Great Job!',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'You scored $_score out of ${widget.questions.length}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentQuestionIndex];
    final isSentenceQuestion = currentQuestion is SentenceQuestion;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
              Theme.of(context).colorScheme.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isSentenceQuestion ? 'Sentence Builder' : 'Fill in the Blank',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProgressBar(
                  current: _currentQuestionIndex + 1,
                  total: widget.questions.length,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentQuestion.question,
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 20),
                        if (isSentenceQuestion) _buildSentence(currentQuestion as SentenceQuestion),
                        const SizedBox(height: 30),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2.5,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: currentQuestion.options.length,
                            itemBuilder: (context, index) {
                              final option = currentQuestion.options[index];
                              return OptionTile(
                                text: option,
                                isSelected: _selectedAnswer == option,
                                isCorrect: _isAnswered
                                    ? option == currentQuestion.correctAnswer
                                    : null,
                                onTap: () => _checkAnswer(option),
                              );
                            },
                          ),
                        ),
                        if (_isAnswered)
                          FadeTransition(
                            opacity: _animation,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: _isCorrect
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _isCorrect ? Icons.check_circle : Icons.cancel,
                                    color: _isCorrect ? Colors.green : Colors.red,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    _isCorrect ? 'Great job!' : 'Try again!',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                          color: _isCorrect ? Colors.green : Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSentence(SentenceQuestion question) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < question.sentenceParts.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            if (i == question.blankPosition)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _selectedAnswer != null
                      ? _isCorrect
                          ? Colors.green.withOpacity(0.2)
                          : Colors.red.withOpacity(0.2)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _selectedAnswer != null
                        ? _isCorrect
                            ? Colors.green
                            : Colors.red
                        : Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: Text(
                  _selectedAnswer ?? '____',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _selectedAnswer != null
                            ? _isCorrect
                                ? Colors.green
                                : Colors.red
                            : Theme.of(context).colorScheme.primary,
                      ),
                ),
              )
            else
              Text(
                question.sentenceParts[i],
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ],
        ],
      ),
    );
  }
}
