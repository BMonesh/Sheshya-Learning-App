import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../utils/mock_data.dart';
import 'image_match_screen.dart';
import 'audio_question_screen.dart';
import 'fill_in_blank_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GradeLevel _selectedGradeLevel = GradeLevel.kindergarten;
  final int _questionsPerQuiz = 5;

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 20),
              // Header with avatar and name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Friend!',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Let\'s Learn Together',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Grade level selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Grade Level',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildGradeButton(
                          context, 
                          'Kindergarten', 
                          GradeLevel.kindergarten,
                        ),
                        const SizedBox(width: 10),
                        _buildGradeButton(
                          context, 
                          '1st Grade', 
                          GradeLevel.firstGrade,
                        ),
                        const SizedBox(width: 10),
                        _buildGradeButton(
                          context, 
                          '2nd Grade', 
                          GradeLevel.secondGrade,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              // Main content
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose a Game',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            children: [
                              _buildGameCard(
                                context,
                                'Fill in the Blank',
                                Icons.edit,
                                Theme.of(context).colorScheme.primary,
                                () => _navigateToFillInBlank(context),
                              ),
                              _buildGameCard(
                                context,
                                'Image Matching',
                                Icons.image,
                                Theme.of(context).colorScheme.secondary,
                                () => _navigateToImageMatch(context),
                              ),
                              _buildGameCard(
                                context,
                                'Audio Quiz',
                                Icons.music_note,
                                Theme.of(context).colorScheme.tertiary,
                                () => _navigateToAudioQuiz(context),
                              ),
                              _buildGameCard(
                                context,
                                'Sentence Builder',
                                Icons.text_fields,
                                Colors.teal,
                                () => _navigateToSentenceBuilder(context),
                              ),
                            ],
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

  Widget _buildGradeButton(BuildContext context, String label, GradeLevel gradeLevel) {
    final isSelected = _selectedGradeLevel == gradeLevel;
    
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedGradeLevel = gradeLevel;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected 
                ? Theme.of(context).colorScheme.primary 
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 40,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToFillInBlank(BuildContext context) {
    final questions = MockData.getRandomQuestions(
      QuestionType.fill, 
      _selectedGradeLevel,
      _questionsPerQuiz,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FillInBlankScreen(questions: questions),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  void _navigateToImageMatch(BuildContext context) {
    final questions = MockData.getRandomQuestions(
      QuestionType.imageMatch, 
      _selectedGradeLevel,
      _questionsPerQuiz,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ImageMatchScreen(questions: questions),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  void _navigateToAudioQuiz(BuildContext context) {
    final questions = MockData.getRandomQuestions(
      QuestionType.audio, 
      _selectedGradeLevel,
      _questionsPerQuiz,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => AudioQuestionScreen(questions: questions),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }

  void _navigateToSentenceBuilder(BuildContext context) {
    final questions = MockData.getRandomQuestions(
      QuestionType.sentence, 
      _selectedGradeLevel,
      _questionsPerQuiz,
    );
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FillInBlankScreen(questions: questions),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(position: animation.drive(tween), child: child);
        },
      ),
    );
  }
}