import 'package:flutter/material.dart';
import '../models/course_content.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import '../widgets/progress_bar.dart';
import '../widgets/fill_question_widget.dart';
import '../widgets/image_match_widget.dart';
import '../widgets/audio_question_widget.dart';
import '../widgets/sentence_question_widget.dart';
import 'result_screen.dart';

class QuestionScreen extends StatefulWidget {
  final List<CourseContent> questions;
  final QuestionType activityType;
  final String activityTitle;

  const QuestionScreen({
    Key? key,
    required this.questions,
    required this.activityType,
    required this.activityTitle,
  }) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  bool _isCorrect = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppConstants.mediumAnimationDuration,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _checkAnswer(dynamic userAnswer) {
    if (_answered) return;

    bool correct = false;
    final question = widget.questions[_currentQuestionIndex];

    switch (question.type) {
      case QuestionType.fill:
        correct = userAnswer == question.correctAnswer;
        break;
      case QuestionType.imageMatch:
        final Map<String, String> userMatches = userAnswer;
        final Map<String, String> correctMatches = question.correctAnswer;
        correct = _mapsEqual(userMatches, correctMatches);
        break;
      case QuestionType.audio:
        correct = userAnswer == question.correctAnswer;
        break;
      case QuestionType.sentence:
        final List<String> userWords = userAnswer;
        final List<String> correctWords = question.correctAnswer;
        correct = _listsEqual(userWords, correctWords);
        break;
    }

    setState(() {
      _answered = true;
      _isCorrect = correct;
      if (correct) {
        _score += question.points;
      }
    });

    // Show feedback and move to next question after delay
    Future.delayed(const Duration(seconds: 2), () {
      if (_currentQuestionIndex < widget.questions.length - 1) {
        _nextQuestion();
      } else {
        _showResults();
      }
    });
  }

  bool _mapsEqual(Map<String, String> map1, Map<String, String> map2) {
    if (map1.length != map2.length) return false;
    return map1.entries.every((entry) => map2[entry.key] == entry.value);
  }

  bool _listsEqual(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  void _nextQuestion() {
    _animationController.reverse().then((_) {
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        _isCorrect = false;
      });
      _animationController.forward();
    });
  }

  void _showResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          score: _score,
          totalQuestions: widget.questions.length,
          maxScore: widget.questions.fold(0, (sum, question) => sum + question.points),
          activityType: widget.activityType,
          activityTitle: widget.activityTitle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];
    final progress = (_currentQuestionIndex + 1) / widget.questions.length;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.backgroundColor,
              AppTheme.primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ProgressBar(progress: progress),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: FadeTransition(
                  opacity: _animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1, 0),
                      end: Offset.zero,
                    ).animate(_animation),
                    child: _buildQuestionWidget(question),
                  ),
                ),
              ),
              if (_answered)
                _buildFeedback(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Text(
            'Score: $_score',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionWidget(CourseContent question) {
    switch (question.type) {
      case QuestionType.fill:
        return FillQuestionWidget(
          question: question as FillQuestion,
          onAnswerSelected: _checkAnswer,
          answered: _answered,
          isCorrect: _isCorrect,
        );
      case QuestionType.imageMatch:
        return ImageMatchWidget(
          question: question as ImageMatchQuestion,
          onAnswerSubmitted: _checkAnswer,
          answered: _answered,
          isCorrect: _isCorrect,
        );
      case QuestionType.audio:
        return AudioQuestionWidget(
          question: question as AudioQuestion,
          onAnswerSelected: _checkAnswer,
          answered: _answered,
          isCorrect: _isCorrect,
        );
      case QuestionType.sentence:
        return SentenceQuestionWidget(
          question: question as SentenceQuestion,
          onAnswerSubmitted: _checkAnswer,
          answered: _answered,
          isCorrect: _isCorrect,
        );
      default:
        return const Center(child: Text('Unsupported question type'));
    }
  }

  Widget _buildFeedback() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: _isCorrect ? AppTheme.correctColor : AppTheme.incorrectColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _isCorrect ? Icons.check_circle : Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            _isCorrect ? AppConstants.correct : AppConstants.incorrect,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
