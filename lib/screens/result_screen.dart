import 'package:flutter/material.dart';
import '../models/course_content.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';
import 'course_selection_screen.dart';
import '../widgets/confetti_animation.dart';

class ResultScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;
  final int maxScore;
  final QuestionType activityType;
  final String activityTitle;

  const ResultScreen({
    Key? key,
    required this.score,
    required this.totalQuestions,
    required this.maxScore,
    required this.activityType,
    required this.activityTitle,
  }) : super(key: key);

  double get percentage => (score / maxScore) * 100;
  
  String get resultMessage {
    if (percentage >= 90) {
      return 'Excellent! You\'re a star!';
    } else if (percentage >= 70) {
      return 'Great job! Keep it up!';
    } else if (percentage >= 50) {
      return 'Good effort! Try again to improve!';
    } else {
      return 'Keep practicing! You\'ll get better!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          if (percentage >= 70) const ConfettiAnimation(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildResultHeader(),
                  const SizedBox(height: 40),
                  _buildScoreCard(),
                  const SizedBox(height: 40),
                  _buildStars(),
                  const SizedBox(height: 40),
                  Text(
                    resultMessage,
                    style: AppTheme.subheadingStyle.copyWith(
                      color: AppTheme.primaryColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  _buildButtons(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultHeader() {
    return Column(
      children: [
        Text(
          AppConstants.completed,
          style: AppTheme.headingStyle.copyWith(
            fontSize: 32,
            color: AppTheme.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'You\'ve completed the $activityTitle activity',
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.lightTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildScoreCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Score',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.lightTextColor,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
              Text(
                '/$maxScore',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.lightTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 10,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: score / maxScore,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryColor, AppTheme.accentColor],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${percentage.toStringAsFixed(0)}%',
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

  Widget _buildStars() {
    int starCount = 0;
    if (percentage >= 90) {
      starCount = 3;
    } else if (percentage >= 70) {
      starCount = 2;
    } else if (percentage >= 50) {
      starCount = 1;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Icon(
          Icons.star_rounded,
          size: 50,
          color: index < starCount ? Colors.amber : Colors.grey.withOpacity(0.3),
        );
      }),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const CourseSelectionScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: AppTheme.primaryColor),
              ),
            ),
            child: const Text(
              'Home',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Try Again',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
