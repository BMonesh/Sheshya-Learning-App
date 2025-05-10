enum QuestionType {
  fill,
  imageMatch,
  audio,
  sentence,
}

enum GradeLevel {
  kindergarten,
  firstGrade,
  secondGrade,
}

class Question {
  final String id;
  final QuestionType type;
  final String question;
  final List<String> options;
  final dynamic correctAnswer; // Can be String, List<String>, or Map depending on type
  final String? audioUrl;
  final List<Map<String, dynamic>>? imageOptions;
  final GradeLevel gradeLevel; // Added grade level

  Question({
    required this.id,
    required this.type,
    required this.question,
    required this.options,
    required this.correctAnswer,
    this.audioUrl,
    this.imageOptions,
    required this.gradeLevel, // Required parameter
  });
}

class FillQuestion extends Question {
  FillQuestion({
    required String id,
    required String question,
    required List<String> options,
    required String correctAnswer,
    required GradeLevel gradeLevel,
  }) : super(
          id: id,
          type: QuestionType.fill,
          question: question,
          options: options,
          correctAnswer: correctAnswer,
          gradeLevel: gradeLevel,
        );
}

class ImageMatchQuestion extends Question {
  ImageMatchQuestion({
    required String id,
    required String question,
    required List<Map<String, dynamic>> imageOptions,
    required Map<String, String> correctAnswer,
    required GradeLevel gradeLevel,
  }) : super(
          id: id,
          type: QuestionType.imageMatch,
          question: question,
          options: [],
          correctAnswer: correctAnswer,
          imageOptions: imageOptions,
          gradeLevel: gradeLevel,
        );
}

class AudioQuestion extends Question {
  AudioQuestion({
    required String id,
    required String question,
    required List<String> options,
    required String correctAnswer,
    required String audioUrl,
    required GradeLevel gradeLevel,
  }) : super(
          id: id,
          type: QuestionType.audio,
          question: question,
          options: options,
          correctAnswer: correctAnswer,
          audioUrl: audioUrl,
          gradeLevel: gradeLevel,
        );
}

class SentenceQuestion extends Question {
  final List<String> sentenceParts;
  final int blankPosition;

  SentenceQuestion({
    required String id,
    required String question,
    required this.sentenceParts,
    required this.blankPosition,
    required List<String> options,
    required String correctAnswer,
    required GradeLevel gradeLevel,
  }) : super(
          id: id,
          type: QuestionType.sentence,
          question: question,
          options: options,
          correctAnswer: correctAnswer,
          gradeLevel: gradeLevel,
        );
}