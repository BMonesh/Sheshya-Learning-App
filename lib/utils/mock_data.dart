import 'dart:math';
import '../models/question_model.dart';

class MockData {
  static List<Question> getQuestions() {
    return [
      // Kindergarten Fill Questions
      FillQuestion(
        id: 'k-fill-1',
        question: 'What color is the sky?',
        options: ['Blue', 'Green', 'Red', 'Yellow'],
        correctAnswer: 'Blue',
        gradeLevel: GradeLevel.kindergarten,
      ),
      FillQuestion(
        id: 'k-fill-2',
        question: 'How many legs does a cat have?',
        options: ['2', '4', '6', '8'],
        correctAnswer: '4',
        gradeLevel: GradeLevel.kindergarten,
      ),
      FillQuestion(
        id: 'k-fill-3',
        question: 'Which animal says "moo"?',
        options: ['Cow', 'Dog', 'Cat', 'Duck'],
        correctAnswer: 'Cow',
        gradeLevel: GradeLevel.kindergarten,
      ),
      FillQuestion(
        id: 'k-fill-4',
        question: 'What shape is a ball?',
        options: ['Circle', 'Square', 'Triangle', 'Rectangle'],
        correctAnswer: 'Circle',
        gradeLevel: GradeLevel.kindergarten,
      ),
      FillQuestion(
        id: 'k-fill-5',
        question: 'What do you use to write?',
        options: ['Pencil', 'Fork', 'Shoe', 'Hat'],
        correctAnswer: 'Pencil',
        gradeLevel: GradeLevel.kindergarten,
      ),
      
      // First Grade Fill Questions
      FillQuestion(
        id: '1-fill-1',
        question: 'Which animal lives in the ocean?',
        options: ['Fish', 'Lion', 'Elephant', 'Monkey'],
        correctAnswer: 'Fish',
        gradeLevel: GradeLevel.firstGrade,
      ),
      FillQuestion(
        id: '1-fill-2',
        question: 'What do plants need to grow?',
        options: ['Water', 'Candy', 'Toys', 'Books'],
        correctAnswer: 'Water',
        gradeLevel: GradeLevel.firstGrade,
      ),
      FillQuestion(
        id: '1-fill-3',
        question: 'How many days are in a week?',
        options: ['7', '5', '10', '12'],
        correctAnswer: '7',
        gradeLevel: GradeLevel.firstGrade,
      ),
      FillQuestion(
        id: '1-fill-4',
        question: 'What season comes after summer?',
        options: ['Fall', 'Winter', 'Spring', 'None'],
        correctAnswer: 'Fall',
        gradeLevel: GradeLevel.firstGrade,
      ),
      FillQuestion(
        id: '1-fill-5',
        question: 'Which fruit is red?',
        options: ['Apple', 'Banana', 'Grape', 'Orange'],
        correctAnswer: 'Apple',
        gradeLevel: GradeLevel.firstGrade,
      ),
      
      // Second Grade Fill Questions
      FillQuestion(
        id: '2-fill-1',
        question: 'What is 5 + 7?',
        options: ['12', '10', '13', '11'],
        correctAnswer: '12',
        gradeLevel: GradeLevel.secondGrade,
      ),
      FillQuestion(
        id: '2-fill-2',
        question: 'Which planet is closest to the sun?',
        options: ['Mercury', 'Earth', 'Mars', 'Jupiter'],
        correctAnswer: 'Mercury',
        gradeLevel: GradeLevel.secondGrade,
      ),
      FillQuestion(
        id: '2-fill-3',
        question: 'What do you call frozen water?',
        options: ['Ice', 'Steam', 'Fog', 'Rain'],
        correctAnswer: 'Ice',
        gradeLevel: GradeLevel.secondGrade,
      ),
      FillQuestion(
        id: '2-fill-4',
        question: 'How many sides does a triangle have?',
        options: ['3', '4', '5', '6'],
        correctAnswer: '3',
        gradeLevel: GradeLevel.secondGrade,
      ),
      FillQuestion(
        id: '2-fill-5',
        question: 'What is 20 - 8?',
        options: ['12', '10', '14', '16'],
        correctAnswer: '12',
        gradeLevel: GradeLevel.secondGrade,
      ),
      
      // Kindergarten Image Match Questions
      ImageMatchQuestion(
        id: 'k-img-1',
        question: 'Match the animals with their homes',
        imageOptions: [
          {
            'id': 'a1',
            'image': 'assets/images/dog.png',
            'name': 'Dog',
            'type': 'animal'
          },
          {
            'id': 'a2',
            'image': 'assets/images/bird.png',
            'name': 'Bird',
            'type': 'animal'
          },
          {
            'id': 'h1',
            'image': 'assets/images/kennel.png',
            'name': 'Kennel',
            'type': 'home'
          },
          {
            'id': 'h2',
            'image': 'assets/images/nest.png',
            'name': 'Nest',
            'type': 'home'
          },
        ],
        correctAnswer: {
          'a1': 'h1',
          'a2': 'h2',
        },
        gradeLevel: GradeLevel.kindergarten,
      ),
      ImageMatchQuestion(
        id: 'k-img-2',
        question: 'Match the shapes with their names',
        imageOptions: [
          {
            'id': 's1',
            'image': 'assets/images/circle.png',
            'name': 'Circle',
            'type': 'shape'
          },
          {
            'id': 's2',
            'image': 'assets/images/square.png',
            'name': 'Square',
            'type': 'shape'
          },
          {
            'id': 'n1',
            'image': 'assets/images/circle_text.png',
            'name': 'Circle',
            'type': 'name'
          },
          {
            'id': 'n2',
            'image': 'assets/images/square_text.png',
            'name': 'Square',
            'type': 'name'
          },
        ],
        correctAnswer: {
          's1': 'n1',
          's2': 'n2',
        },
        gradeLevel: GradeLevel.kindergarten,
      ),
      
      // First Grade Image Match Questions
      ImageMatchQuestion(
        id: '1-img-1',
        question: 'Match the animals with their babies',
        imageOptions: [
          {
            'id': 'a1',
            'image': 'assets/images/cow.png',
            'name': 'Cow',
            'type': 'animal'
          },
          {
            'id': 'a2',
            'image': 'assets/images/sheep.png',
            'name': 'Sheep',
            'type': 'animal'
          },
          {
            'id': 'b1',
            'image': 'assets/images/calf.png',
            'name': 'Calf',
            'type': 'baby'
          },
          {
            'id': 'b2',
            'image': 'assets/images/lamb.png',
            'name': 'Lamb',
            'type': 'baby'
          },
        ],
        correctAnswer: {
          'a1': 'b1',
          'a2': 'b2',
        },
        gradeLevel: GradeLevel.firstGrade,
      ),
      ImageMatchQuestion(
        id: '1-img-2',
        question: 'Match the fruits with their colors',
        imageOptions: [
          {
            'id': 'f1',
            'image': 'assets/images/banana.png',
            'name': 'Banana',
            'type': 'fruit'
          },
          {
            'id': 'f2',
            'image': 'assets/images/strawberry.png',
            'name': 'Strawberry',
            'type': 'fruit'
          },
          {
            'id': 'c1',
            'image': 'assets/images/yellow.png',
            'name': 'Yellow',
            'type': 'color'
          },
          {
            'id': 'c2',
            'image': 'assets/images/red.png',
            'name': 'Red',
            'type': 'color'
          },
        ],
        correctAnswer: {
          'f1': 'c1',
          'f2': 'c2',
        },
        gradeLevel: GradeLevel.firstGrade,
      ),
      
      // Second Grade Image Match Questions
      ImageMatchQuestion(
        id: '2-img-1',
        question: 'Match the countries with their flags',
        imageOptions: [
          {
            'id': 'c1',
            'image': 'assets/images/usa.png',
            'name': 'USA',
            'type': 'country'
          },
          {
            'id': 'c2',
            'image': 'assets/images/canada.png',
            'name': 'Canada',
            'type': 'country'
          },
          {
            'id': 'f1',
            'image': 'assets/images/usa_flag.png',
            'name': 'USA Flag',
            'type': 'flag'
          },
          {
            'id': 'f2',
            'image': 'assets/images/canada_flag.png',
            'name': 'Canada Flag',
            'type': 'flag'
          },
        ],
        correctAnswer: {
          'c1': 'f1',
          'c2': 'f2',
        },
        gradeLevel: GradeLevel.secondGrade,
      ),
      ImageMatchQuestion(
        id: '2-img-2',
        question: 'Match the math problems with their answers',
        imageOptions: [
          {
            'id': 'p1',
            'image': 'assets/images/5plus3.png',
            'name': '5+3',
            'type': 'problem'
          },
          {
            'id': 'p2',
            'image': 'assets/images/10minus4.png',
            'name': '10-4',
            'type': 'problem'
          },
          {
            'id': 'a1',
            'image': 'assets/images/8.png',
            'name': '8',
            'type': 'answer'
          },
          {
            'id': 'a2',
            'image': 'assets/images/6.png',
            'name': '6',
            'type': 'answer'
          },
        ],
        correctAnswer: {
          'p1': 'a1',
          'p2': 'a2',
        },
        gradeLevel: GradeLevel.secondGrade,
      ),
      
      // Kindergarten Audio Questions
      AudioQuestion(
        id: 'k-audio-1',
        question: 'Listen and select the animal you hear',
        options: ['Dog', 'Cat', 'Cow', 'Lion'],
        correctAnswer: 'Cow',
        audioUrl: 'assets/audio/cow.mp3',
        gradeLevel: GradeLevel.kindergarten,
      ),
      AudioQuestion(
        id: 'k-audio-2',
        question: 'Listen and select the sound',
        options: ['Bell', 'Drum', 'Whistle', 'Clap'],
        correctAnswer: 'Bell',
        audioUrl: 'assets/audio/bell.mp3',
        gradeLevel: GradeLevel.kindergarten,
      ),
      
      // First Grade Audio Questions
      AudioQuestion(
        id: '1-audio-1',
        question: 'Listen and select the instrument you hear',
        options: ['Piano', 'Guitar', 'Drums', 'Flute'],
        correctAnswer: 'Piano',
        audioUrl: 'assets/audio/piano.mp3',
        gradeLevel: GradeLevel.firstGrade,
      ),
      AudioQuestion(
        id: '1-audio-2',
        question: 'Listen and select the weather sound',
        options: ['Rain', 'Wind', 'Thunder', 'Snow'],
        correctAnswer: 'Thunder',
        audioUrl: 'assets/audio/thunder.mp3',
        gradeLevel: GradeLevel.firstGrade,
      ),
      
      // Second Grade Audio Questions
      AudioQuestion(
        id: '2-audio-1',
        question: 'Listen and identify the language',
        options: ['English', 'Spanish', 'French', 'Chinese'],
        correctAnswer: 'Spanish',
        audioUrl: 'assets/audio/spanish.mp3',
        gradeLevel: GradeLevel.secondGrade,
      ),
      AudioQuestion(
        id: '2-audio-2',
        question: 'Listen and select the correct word',
        options: ['Happy', 'Sad', 'Angry', 'Excited'],
        correctAnswer: 'Happy',
        audioUrl: 'assets/audio/happy.mp3',
        gradeLevel: GradeLevel.secondGrade,
      ),
      
      // Kindergarten Sentence Questions
      SentenceQuestion(
        id: 'k-sent-1',
        question: 'Complete the sentence',
        sentenceParts: ['The', '', 'is shining bright.'],
        blankPosition: 1,
        options: ['sun', 'moon', 'star', 'light'],
        correctAnswer: 'sun',
        gradeLevel: GradeLevel.kindergarten,
      ),
      SentenceQuestion(
        id: 'k-sent-2',
        question: 'Fill in the blank',
        sentenceParts: ['I like to', '', 'with my friends.'],
        blankPosition: 1,
        options: ['play', 'sleep', 'eat', 'run'],
        correctAnswer: 'play',
        gradeLevel: GradeLevel.kindergarten,
      ),
      
      // First Grade Sentence Questions
      SentenceQuestion(
        id: '1-sent-1',
        question: 'Complete the sentence',
        sentenceParts: ['The', '', 'is flying in the sky.'],
        blankPosition: 1,
        options: ['bird', 'car', 'fish', 'tree'],
        correctAnswer: 'bird',
        gradeLevel: GradeLevel.firstGrade,
      ),
      SentenceQuestion(
        id: '1-sent-2',
        question: 'Fill in the blank',
        sentenceParts: ['We go to', '', 'to learn.'],
        blankPosition: 1,
        options: ['school', 'park', 'beach', 'store'],
        correctAnswer: 'school',
        gradeLevel: GradeLevel.firstGrade,
      ),
      
      // Second Grade Sentence Questions
      SentenceQuestion(
        id: '2-sent-1',
        question: 'Complete the sentence',
        sentenceParts: ['The Earth', '', 'around the Sun.'],
        blankPosition: 1,
        options: ['revolves', 'jumps', 'swims', 'flies'],
        correctAnswer: 'revolves',
        gradeLevel: GradeLevel.secondGrade,
      ),
      SentenceQuestion(
        id: '2-sent-2',
        question: 'Fill in the blank',
        sentenceParts: ['Water', '', 'at 100 degrees Celsius.'],
        blankPosition: 1,
        options: ['boils', 'freezes', 'melts', 'evaporates'],
        correctAnswer: 'boils',
        gradeLevel: GradeLevel.secondGrade,
      ),
    ];
  }

  static List<Question> getQuestionsByType(QuestionType type) {
    return getQuestions().where((q) => q.type == type).toList();
  }
  
  static List<Question> getQuestionsByGradeLevel(GradeLevel gradeLevel) {
    return getQuestions().where((q) => q.gradeLevel == gradeLevel).toList();
  }
  
  static List<Question> getQuestionsByTypeAndGrade(QuestionType type, GradeLevel gradeLevel) {
    return getQuestions().where((q) => q.type == type && q.gradeLevel == gradeLevel).toList();
  }
  
  static List<Question> getRandomQuestions(QuestionType type, GradeLevel gradeLevel, int count) {
    final questions = getQuestionsByTypeAndGrade(type, gradeLevel);
    if (questions.length <= count) {
      return questions;
    }
    
    // Shuffle and take first 'count' questions
    final shuffled = List<Question>.from(questions);
    shuffled.shuffle(Random());
    return shuffled.take(count).toList();
  }
}