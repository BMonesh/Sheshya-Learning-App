import 'package:flutter/material.dart';
import '../models/question_model.dart';
import '../widgets/draggable_image_card.dart';
import '../widgets/progress_bar.dart';

class ImageMatchScreen extends StatefulWidget {
  final List<Question> questions;

  const ImageMatchScreen({super.key, required this.questions});

  @override
  State<ImageMatchScreen> createState() => _ImageMatchScreenState();
}

class _ImageMatchScreenState extends State<ImageMatchScreen> with TickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  Map<String, String?> _matches = {};
  bool _isCompleted = false;
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

  void _onMatch(String sourceId, String targetId) {
    setState(() {
      _matches[sourceId] = targetId;
    });

    // Check if all items are matched
    final currentQuestion = widget.questions[_currentQuestionIndex] as ImageMatchQuestion;
    final correctMatches = currentQuestion.correctAnswer as Map<String, String>;
    
    if (_matches.length == correctMatches.length) {
      // All items matched, check if correct
      bool allCorrect = true;
      for (final entry in correctMatches.entries) {
        if (_matches[entry.key] != entry.value) {
          allCorrect = false;
          break;
        }
      }

      setState(() {
        _isCompleted = true;
        _isCorrect = allCorrect;
        if (allCorrect) {
          _score++;
        }
      });

      _animationController.forward();

      // Move to next question after delay
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (_currentQuestionIndex < widget.questions.length - 1) {
          setState(() {
            _currentQuestionIndex++;
            _matches = {};
            _isCompleted = false;
            _isCorrect = false;
          });
          _animationController.reset();
        } else {
          // Show completion dialog
          _showCompletionDialog();
        }
      });
    }
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
    final currentQuestion = widget.questions[_currentQuestionIndex] as ImageMatchQuestion;
    final imageOptions = currentQuestion.imageOptions!;
    
    // Separate items by type
    final sourceItems = imageOptions.where((item) => item['type'] == 'animal' || item['type'] == 'shape').toList();
    final targetItems = imageOptions.where((item) => item['type'] == 'home' || item['type'] == 'name').toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.secondary.withOpacity(0.1),
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
                      'Image Matching',
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
                  color: Theme.of(context).colorScheme.secondary,
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
                        Expanded(
                          child: Column(
                            children: [
                              // Source items (draggable)
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: sourceItems.map((item) {
                                      final isMatched = _matches.containsKey(item['id']);
                                      return DraggableImageCard(
                                        id: item['id'],
                                        imagePath: item['image'],
                                        label: item['name'],
                                        isMatched: isMatched,
                                        onMatch: _onMatch,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Target items (drop targets)
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: targetItems.map((item) {
                                      final isMatched = _matches.containsValue(item['id']);
                                      return DraggableImageCard(
                                        id: item['id'],
                                        imagePath: item['image'],
                                        label: item['name'],
                                        isTarget: true,
                                        isMatched: isMatched,
                                        onMatch: _onMatch,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_isCompleted)
                          FadeTransition(
                            opacity: _animation,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(top: 16),
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
                                    _isCorrect ? 'Perfect match!' : 'Not quite right!',
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
}
