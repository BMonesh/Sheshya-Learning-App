import 'package:flutter/material.dart';
import '../models/course_content.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

class FillQuestionWidget extends StatefulWidget {
  final FillQuestion question;
  final Function(String) onAnswerSelected;
  final bool answered;
  final bool isCorrect;

  const FillQuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswerSelected,
    required this.answered,
    required this.isCorrect,
  }) : super(key: key);

  @override
  State<FillQuestionWidget> createState() => _FillQuestionWidgetState();
}

class _FillQuestionWidgetState extends State<FillQuestionWidget> {
  String? _selectedOption;

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
            AppConstants.fillInstructions,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.lightTextColor,
            ),
          ),
          const SizedBox(height: 30),
          _buildSentenceWithBlank(),
          const SizedBox(height: 30),
          _buildOptions(),
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

  Widget _buildSentenceWithBlank() {
    return Container(
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.question.sentenceWithBlank,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
            textAlign: TextAlign.center,
          ),
          if (_selectedOption != null)
            Text(
              _selectedOption!,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.answered
                    ? (widget.isCorrect
                        ? AppTheme.correctColor
                        : AppTheme.incorrectColor)
                    : AppTheme.primaryColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: widget.question.options.map((option) {
        final isSelected = _selectedOption == option;
        final isCorrect = widget.answered && option == widget.question.correctAnswer;
        final isIncorrect = widget.answered && isSelected && !isCorrect;

        return GestureDetector(
          onTap: widget.answered ? null : () {
            setState(() {
              _selectedOption = option;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? (isCorrect
                      ? AppTheme.correctColor
                      : (isIncorrect
                          ? AppTheme.incorrectColor
                          : AppTheme.primaryColor))
                  : (isCorrect
                      ? AppTheme.correctColor.withOpacity(0.2)
                      : Colors.white),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? (isCorrect
                          ? AppTheme.correctColor.withOpacity(0.3)
                          : (isIncorrect
                              ? AppTheme.incorrectColor.withOpacity(0.3)
                              : AppTheme.primaryColor.withOpacity(0.3)))
                      : Colors.grey.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              option,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected || isCorrect ? Colors.white : AppTheme.textColor,
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
        onPressed: _selectedOption == null || widget.answered
            ? null
            : () => widget.onAnswerSelected(_selectedOption!),
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
