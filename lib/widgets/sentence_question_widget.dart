import 'package:flutter/material.dart';
import '../models/course_content.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

class SentenceQuestionWidget extends StatefulWidget {
  final SentenceQuestion question;
  final Function(List<String>) onAnswerSubmitted;
  final bool answered;
  final bool isCorrect;

  const SentenceQuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswerSubmitted,
    required this.answered,
    required this.isCorrect,
  }) : super(key: key);

  @override
  State<SentenceQuestionWidget> createState() => _SentenceQuestionWidgetState();
}

class _SentenceQuestionWidgetState extends State<SentenceQuestionWidget> {
  List<String> _selectedWords = [];
  List<String> _availableWords = [];

  @override
  void initState() {
    super.initState();
    _availableWords = List.from(widget.question.wordOptions);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: AppTheme.headingStyle,
          ),
          const SizedBox(height: 8),
          Text(
            AppConstants.sentenceInstructions,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.lightTextColor,
            ),
          ),
          const SizedBox(height: 30),
          _buildSentence(),
          const SizedBox(height: 30),
          _buildWordOptions(),
          const Spacer(),
          if (widget.answered && widget.question.explanation != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.isCorrect
                    ? AppTheme.correctColor.withOpacity(0.1)
                    : AppTheme.incorrectColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: widget.isCorrect
                      ? AppTheme.correctColor
                      : AppTheme.incorrectColor,
                  width: 1,
                ),
              ),
              child: Text(
                widget.question.explanation!,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.textColor,
                ),
              ),
            ),
          const SizedBox(height: 20),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildSentence() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          Text(
            widget.question.sentenceParts[0],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          if (_selectedWords.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: widget.answered
                    ? (widget.isCorrect
                        ? AppTheme.correctColor.withOpacity(0.2)
                        : AppTheme.incorrectColor.withOpacity(0.2))
                    : AppTheme.primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: widget.answered
                      ? (widget.isCorrect
                          ? AppTheme.correctColor
                          : AppTheme.incorrectColor)
                      : AppTheme.primaryColor,
                  width: 1,
                ),
              ),
              child: Text(
                _selectedWords.join(' '),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.answered
                      ? (widget.isCorrect
                          ? AppTheme.correctColor
                          : AppTheme.incorrectColor)
                      : AppTheme.primaryColor,
                ),
              ),
            )
          else
            Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppTheme.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          Text(
            widget.question.sentenceParts[1],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordOptions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: widget.question.wordOptions.map((word) {
        final isSelected = _selectedWords.contains(word);
        final isAvailable = _availableWords.contains(word);
        final isCorrect = widget.answered && widget.question.correctAnswer.contains(word);
        final isIncorrect = widget.answered && _selectedWords.contains(word) && !isCorrect;

        return GestureDetector(
          onTap: widget.answered || !isAvailable ? null : () {
            setState(() {
              if (isSelected) {
                _selectedWords.remove(word);
                _availableWords.add(word);
              } else {
                _selectedWords.add(word);
                _availableWords.remove(word);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? (widget.answered
                      ? (isCorrect
                          ? AppTheme.correctColor
                          : AppTheme.incorrectColor)
                      : AppTheme.primaryColor)
                  : (widget.answered && isCorrect
                      ? AppTheme.correctColor.withOpacity(0.2)
                      : (isAvailable ? Colors.white : Colors.grey.withOpacity(0.2))),
              borderRadius: BorderRadius.circular(20),
              boxShadow: isAvailable
                  ? [
                      BoxShadow(
                        color: isSelected
                            ? (widget.answered
                                ? (isCorrect
                                    ? AppTheme.correctColor.withOpacity(0.3)
                                    : AppTheme.incorrectColor.withOpacity(0.3))
                                : AppTheme.primaryColor.withOpacity(0.3))
                            : Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              word,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isSelected || (widget.answered && isCorrect)
                    ? Colors.white
                    : (isAvailable ? AppTheme.textColor : Colors.grey),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _selectedWords.isEmpty || widget.answered
            ? null
            : () => widget.onAnswerSubmitted(_selectedWords),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBackgroundColor: Colors.grey.withOpacity(0.3),
        ),
        child: Text(
          widget.answered ? AppConstants.next : AppConstants.submit,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
