enum QuestionType {
  fill,
  imageMatch,
  audio,
  sentence,
}

class CourseContent {
  final String id;
  final String question;
  final QuestionType type;
  final List<String> options;
  final dynamic correctAnswer; // Can be String, List<String>, or Map depending on type
  final String? imageUrl;
  final String? audioUrl;
  final int points;
  final String? hint;
  final String? explanation;

  CourseContent({
    required this.id,
    required this.question,
    required this.type,
    required this.options,
    required this.correctAnswer,
    this.imageUrl,
    this.audioUrl,
    this.points = 10,
    this.hint,
    this.explanation,
  });
}

class FillQuestion extends CourseContent {
  final String sentenceWithBlank;
  
  FillQuestion({
    required String id,
    required String question,
    required this.sentenceWithBlank,
    required List<String> options,
    required String correctAnswer,
    String? hint,
    String? explanation,
    int points = 10,
  }) : super(
          id: id,
          question: question,
          type: QuestionType.fill,
          options: options,
          correctAnswer: correctAnswer,
          hint: hint,
          explanation: explanation,
          points: points,
        );
}

class ImageMatchQuestion extends CourseContent {
  final List<Map<String, String>> imagePairs;
  
  ImageMatchQuestion({
    required String id,
    required String question,
    required this.imagePairs,
    required Map<String, String> correctAnswer,
    String? hint,
    String? explanation,
    int points = 15,
  }) : super(
          id: id,
          question: question,
          type: QuestionType.imageMatch,
          options: imagePairs.map((pair) => pair['id']!).toList(),
          correctAnswer: correctAnswer,
          hint: hint,
          explanation: explanation,
          points: points,
        );
}

class AudioQuestion extends CourseContent {
  final String audioUrl;
  
  AudioQuestion({
    required String id,
    required String question,
    required this.audioUrl,
    required List<String> options,
    required String correctAnswer,
    String? hint,
    String? explanation,
    int points = 12,
  }) : super(
          id: id,
          question: question,
          type: QuestionType.audio,
          options: options,
          correctAnswer: correctAnswer,
          audioUrl: audioUrl,
          hint: hint,
          explanation: explanation,
          points: points,
        );
}

class SentenceQuestion extends CourseContent {
  final List<String> sentenceParts;
  final List<String> wordOptions;
  
  SentenceQuestion({
    required String id,
    required String question,
    required this.sentenceParts,
    required this.wordOptions,
    required List<String> correctAnswer,
    String? hint,
    String? explanation,
    int points = 10,
  }) : super(
          id: id,
          question: question,
          type: QuestionType.sentence,
          options: wordOptions,
          correctAnswer: correctAnswer,
          hint: hint,
          explanation: explanation,
          points: points,
        );
}
