import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/course_content.dart';
import '../utils/theme.dart';
import '../utils/constants.dart';

class AudioQuestionWidget extends StatefulWidget {
  final AudioQuestion question;
  final Function(String) onAnswerSelected;
  final bool answered;
  final bool isCorrect;

  const AudioQuestionWidget({
    Key? key,
    required this.question,
    required this.onAnswerSelected,
    required this.answered,
    required this.isCorrect,
  }) : super(key: key);

  @override
  State<AudioQuestionWidget> createState() => _AudioQuestionWidgetState();
}

class _AudioQuestionWidgetState extends State<AudioQuestionWidget> {
  String? _selectedOption;
  bool _isPlaying = false;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(
        AssetSource(widget.question.audioUrl.replaceFirst('assets/', '')),
      );
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
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
            AppConstants.audioInstructions,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.lightTextColor,
            ),
          ),
          const SizedBox(height: 30),
          _buildAudioPlayer(),
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

  Widget _buildAudioPlayer() {
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
      child: Column(
        children: [
          const Icon(
            Icons.music_note_rounded,
            size: 60,
            color: AppTheme.primaryColor,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const LinearProgressIndicator(
            value: 0.5,
            backgroundColor: Colors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
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
        final isCorrect =
            widget.answered && option == widget.question.correctAnswer;
        final isIncorrect = widget.answered && isSelected && !isCorrect;

        return GestureDetector(
          onTap: widget.answered
              ? null
              : () {
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
                color:
                    isSelected || isCorrect ? Colors.white : AppTheme.textColor,
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
