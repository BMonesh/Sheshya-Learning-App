import 'package:flutter/material.dart';
import '../utils/theme.dart';
import '../services/mock_data_service.dart';
import '../models/course_content.dart';
import 'question_screen.dart';

class CourseSelectionScreen extends StatelessWidget {
  const CourseSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Choose a Learning Activity',
                  style: AppTheme.headingStyle.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Select an activity to start learning and playing',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.lightTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: _buildCourseGrid(context),
              ),
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
            icon: const Icon(Icons.arrow_back_ios_rounded),
            color: AppTheme.primaryColor,
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Hero(
            tag: 'app_logo',
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'S',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseGrid(BuildContext context) {
    final List<Map<String, dynamic>> activities = [
      {
        'title': 'Fill in the Blanks',
        'description': 'Complete words and sentences',
        'icon': Icons.text_fields_rounded,
        'color': const Color(0xFF6C63FF),
        'type': QuestionType.fill,
      },
      {
        'title': 'Image Matching',
        'description': 'Match related images together',
        'icon': Icons.image_rounded,
        'color': const Color(0xFFFF6584),
        'type': QuestionType.imageMatch,
      },
      {
        'title': 'Audio Quiz',
        'description': 'Listen and identify sounds',
        'icon': Icons.volume_up_rounded,
        'color': const Color(0xFF43E97B),
        'type': QuestionType.audio,
      },
      {
        'title': 'Sentence Building',
        'description': 'Complete sentences correctly',
        'icon': Icons.format_align_left_rounded,
        'color': const Color(0xFFFFA726),
        'type': QuestionType.sentence,
      },
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: activities.length,
      itemBuilder: (context, index) {
        final activity = activities[index];
        return _buildActivityCard(context, activity);
      },
    );
  }

  Widget _buildActivityCard(BuildContext context, Map<String, dynamic> activity) {
    return GestureDetector(
      onTap: () {
        final mockDataService = MockDataService();
        List<CourseContent> questions = [];
        
        switch (activity['type']) {
          case QuestionType.fill:
            questions = mockDataService.getFillQuestions();
            break;
          case QuestionType.imageMatch:
            questions = mockDataService.getImageMatchQuestions();
            break;
          case QuestionType.audio:
            questions = mockDataService.getAudioQuestions();
            break;
          case QuestionType.sentence:
            questions = mockDataService.getSentenceQuestions();
            break;
        }
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionScreen(
              questions: questions,
              activityType: activity['type'],
              activityTitle: activity['title'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: activity['color'].withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: activity['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                activity['icon'],
                size: 36,
                color: activity['color'],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              activity['title'],
              style: AppTheme.subheadingStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                activity['description'],
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.lightTextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: activity['color'].withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Start',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: activity['color'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
