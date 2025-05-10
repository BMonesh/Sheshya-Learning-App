import '../models/course_content.dart';

class MockDataService {
  // Get all content for a specific class
  List<CourseContent> getCourseContent(String className) {
    List<CourseContent> allContent = [];
    
    allContent.addAll(getFillQuestions());
    allContent.addAll(getImageMatchQuestions());
    allContent.addAll(getAudioQuestions());
    allContent.addAll(getSentenceQuestions());
    
    return allContent;
  }
  
  // Get fill in the blank questions
  List<FillQuestion> getFillQuestions() {
    return [
      FillQuestion(
        id: 'fill_1',
        question: 'Complete the word',
        sentenceWithBlank: 'A for A____',
        options: ['pple', 'rrow', 'nt', 'rm'],
        correctAnswer: 'pple',
        hint: 'It\'s a fruit',
        explanation: 'Apple starts with the letter A',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_2',
        question: 'Complete the word',
        sentenceWithBlank: 'B for B____',
        options: ['all', 'ox', 'ird', 'ook'],
        correctAnswer: 'all',
        hint: 'You can play with it',
        explanation: 'Ball starts with the letter B',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_3',
        question: 'Complete the word',
        sentenceWithBlank: 'C for C____',
        options: ['at', 'up', 'ar', 'ake'],
        correctAnswer: 'at',
        hint: 'It\'s a pet animal',
        explanation: 'Cat starts with the letter C',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_4',
        question: 'Complete the word',
        sentenceWithBlank: 'D for D____',
        options: ['og', 'uck', 'oor', 'oll'],
        correctAnswer: 'og',
        hint: 'It\'s a pet animal',
        explanation: 'Dog starts with the letter D',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_5',
        question: 'Complete the word',
        sentenceWithBlank: 'E for E____',
        options: ['lephant', 'gg', 'agle', 'ye'],
        correctAnswer: 'lephant',
        hint: 'It\'s a large animal',
        explanation: 'Elephant starts with the letter E',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_6',
        question: 'Complete the word',
        sentenceWithBlank: 'F for F____',
        options: ['ish', 'rog', 'lower', 'an'],
        correctAnswer: 'ish',
        hint: 'It lives in water',
        explanation: 'Fish starts with the letter F',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_7',
        question: 'Complete the word',
        sentenceWithBlank: 'G for G____',
        options: ['oat', 'rapes', 'arden', 'ame'],
        correctAnswer: 'rapes',
        hint: 'It\'s a fruit',
        explanation: 'Grapes starts with the letter G',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_8',
        question: 'Complete the word',
        sentenceWithBlank: 'H for H____',
        options: ['ouse', 'at', 'orse', 'and'],
        correctAnswer: 'ouse',
        hint: 'You live in it',
        explanation: 'House starts with the letter H',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_9',
        question: 'Complete the word',
        sentenceWithBlank: 'I for I____',
        options: ['ce cream', 'gloo', 'nsect', 'nk'],
        correctAnswer: 'ce cream',
        hint: 'It\'s cold and sweet',
        explanation: 'Ice cream starts with the letter I',
        points: 10,
      ),
      FillQuestion(
        id: 'fill_10',
        question: 'Complete the word',
        sentenceWithBlank: 'J for J____',
        options: ['uice', 'ar', 'elly', 'acket'],
        correctAnswer: 'uice',
        hint: 'You drink it',
        explanation: 'Juice starts with the letter J',
        points: 10,
      ),
    ];
  }
  
  // Get image match questions
  List<ImageMatchQuestion> getImageMatchQuestions() {
  return [
    ImageMatchQuestion(
      id: 'img_1',
      question: 'Match the animals with their homes',
      imagePairs: [
        {'id': 'a1', 'image': 'assets/images/bird.png', 'name': 'Bird'},
        {'id': 'h1', 'image': 'assets/images/nest.png', 'name': 'Nest'},
        {'id': 'a2', 'image': 'assets/images/dog.png', 'name': 'Dog'},
        {'id': 'h2', 'image': 'assets/images/kennel.png', 'name': 'Kennel'},
        {'id': 'a3', 'image': 'assets/images/fish.png', 'name': 'Fish'},
        {'id': 'h3', 'image': 'assets/images/aquarium.png', 'name': 'Aquarium'},
      ],
      correctAnswer: {
        'a1': 'h1',
        'a2': 'h2',
        'a3': 'h3',
      },
      hint: 'Think about where each animal lives',
      points: 15,
    ),
    ImageMatchQuestion(
      id: 'img_2',
      question: 'Match the fruits with their colors',
      imagePairs: [
        {'id': 'f1', 'image': 'assets/images/apple.png', 'name': 'Apple'},
        {'id': 'c1', 'image': 'assets/images/red.png', 'name': 'Red'},
        {'id': 'f2', 'image': 'assets/images/banana.png', 'name': 'Banana'},
        {'id': 'c2', 'image': 'assets/images/yellow.png', 'name': 'Yellow'},
        {'id': 'f3', 'image': 'assets/images/grapes.png', 'name': 'Grapes'},
        {'id': 'c3', 'image': 'assets/images/purple.png', 'name': 'Purple'},
      ],
      correctAnswer: {
        'f1': 'c1',
        'f2': 'c2',
        'f3': 'c3',
      },
      hint: 'Think about the color of each fruit',
      points: 15,
    ),
    ImageMatchQuestion(
      id: 'img_3',
      question: 'Match the shapes with their names',
      imagePairs: [
        {'id': 's1', 'image': 'assets/images/circle.png', 'name': 'Circle'},
        {'id': 'n1', 'image': 'assets/images/circle_text.png', 'name': 'Circle'},
        {'id': 's2', 'image': 'assets/images/square.png', 'name': 'Square'},
        {'id': 'n2', 'image': 'assets/images/square_text.png', 'name': 'Square'},
        {'id': 's3', 'image': 'assets/images/triangle.png', 'name': 'Triangle'},
        {'id': 'n3', 'image': 'assets/images/triangle_text.png', 'name': 'Triangle'},
      ],
      correctAnswer: {
        's1': 'n1',
        's2': 'n2',
        's3': 'n3',
      },
      hint: 'Match the shape with its name',
      points: 15,
    ),
    ImageMatchQuestion(
      id: 'img_4',
      question: 'Match the animals with their babies',
      imagePairs: [
        {'id': 'p1', 'image': 'assets/images/hen.png', 'name': 'Hen'},
        {'id': 'b1', 'image': 'assets/images/chick.png', 'name': 'Chick'},
        {'id': 'p2', 'image': 'assets/images/cat.png', 'name': 'Cat'},
        {'id': 'b2', 'image': 'assets/images/kitten.png', 'name': 'Kitten'},
        {'id': 'p3', 'image': 'assets/images/dog.png', 'name': 'Dog'},
        {'id': 'b3', 'image': 'assets/images/puppy.png', 'name': 'Puppy'},
      ],
      correctAnswer: {
        'p1': 'b1',
        'p2': 'b2',
        'p3': 'b3',
      },
      hint: 'Match each animal with its baby',
      points: 15,
    ),
    ImageMatchQuestion(
      id: 'img_5',
      question: 'Match the objects with their uses',
      imagePairs: [
        {'id': 'o1', 'image': 'assets/images/pencil.png', 'name': 'Pencil'},
        {'id': 'u1', 'image': 'assets/images/writing.png', 'name': 'Writing'},
        {'id': 'o2', 'image': 'assets/images/toothbrush.png', 'name': 'Toothbrush'},
        {'id': 'u2', 'image': 'assets/images/brushing.png', 'name': 'Brushing'},
        {'id': 'o3', 'image': 'assets/images/spoon.png', 'name': 'Spoon'},
        {'id': 'u3', 'image': 'assets/images/eating.png', 'name': 'Eating'},
      ],
      correctAnswer: {
        'o1': 'u1',
        'o2': 'u2',
        'o3': 'u3',
      },
      hint: 'Think about how we use each object',
      points: 15,
    ),
  ];
}

  // Get audio questions
  List<AudioQuestion> getAudioQuestions() {
    return [
      AudioQuestion(
        id: 'audio_1',
        question: 'Listen to the animal sound and select the correct animal',
        audioUrl: 'assets/audio/dog_bark.mp3',
        options: ['Dog', 'Cat', 'Cow', 'Lion'],
        correctAnswer: 'Dog',
        hint: 'This animal says "woof"',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_2',
        question: 'Listen to the animal sound and select the correct animal',
        audioUrl: 'assets/audio/cat_meow.mp3',
        options: ['Dog', 'Cat', 'Cow', 'Lion'],
        correctAnswer: 'Cat',
        hint: 'This animal says "meow"',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_3',
        question: 'Listen to the animal sound and select the correct animal',
        audioUrl: 'assets/audio/cow.mp3',
        options: ['Dog', 'Cat', 'Cow', 'Lion'],
        correctAnswer: 'Cow',
        hint: 'This animal says "moo"',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_4',
        question: 'Listen to the animal sound and select the correct animal',
        audioUrl: 'assets/audio/lion.mp3',
        options: ['Dog', 'Cat', 'Cow', 'Lion'],
        correctAnswer: 'Lion',
        hint: 'This animal makes a loud roar',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_5',
        question: 'Listen to the instrument and select the correct one',
        audioUrl: 'assets/audio/piano.mp3',
        options: ['Piano', 'Guitar', 'Drum', 'Flute'],
        correctAnswer: 'Piano',
        hint: 'This instrument has black and white keys',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_6',
        question: 'Listen to the instrument and select the correct one',
        audioUrl: 'assets/audio/guitar.mp3',
        options: ['Piano', 'Guitar', 'Drum', 'Flute'],
        correctAnswer: 'Guitar',
        hint: 'This instrument has strings that you pluck',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_7',
        question: 'Listen to the instrument and select the correct one',
        audioUrl: 'assets/audio/drums.mp3',
        options: ['Piano', 'Guitar', 'Drum', 'Flute'],
        correctAnswer: 'Drum',
        hint: 'You hit this instrument to make sound',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_8',
        question: 'Listen to the instrument and select the correct one',
        audioUrl: 'assets/audio/flute.mp3',
        options: ['Piano', 'Guitar', 'Drum', 'Flute'],
        correctAnswer: 'Flute',
        hint: 'You blow into this instrument to make sound',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_9',
        question: 'Listen to the sound and select what makes it',
        audioUrl: 'assets/audio/rain.mp3',
        options: ['Rain', 'Wind', 'Thunder', 'Fire'],
        correctAnswer: 'Rain',
        hint: 'This falls from the sky and makes everything wet',
        points: 12,
      ),
      AudioQuestion(
        id: 'audio_10',
        question: 'Listen to the sound and select what makes it',
        audioUrl: 'assets/audio/thunder.mp3',
        options: ['Rain', 'Wind', 'Thunder', 'Fire'],
        correctAnswer: 'Thunder',
        hint: 'This is a loud sound during a storm',
        points: 12,
      ),
    ];
  }
  
  // Get sentence questions
  List<SentenceQuestion> getSentenceQuestions() {
    return [
      SentenceQuestion(
        id: 'sent_1',
        question: 'Complete the sentence',
        sentenceParts: ['The sun rises in the ', '.'],
        wordOptions: ['east', 'west', 'north', 'south'],
        correctAnswer: ['east'],
        hint: 'Think about where you see the sun in the morning',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_2',
        question: 'Complete the sentence',
        sentenceParts: ['The sky is ', ' during the day.'],
        wordOptions: ['blue', 'black', 'green', 'red'],
        correctAnswer: ['blue'],
        hint: 'Look up at the sky during daytime',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_3',
        question: 'Complete the sentence',
        sentenceParts: ['We see the ', ' at night.'],
        wordOptions: ['sun', 'moon', 'stars', 'clouds'],
        correctAnswer: ['moon', 'stars'],
        hint: 'What shines in the night sky?',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_4',
        question: 'Complete the sentence',
        sentenceParts: ['Birds have ', ' to fly.'],
        wordOptions: ['legs', 'wings', 'tails', 'beaks'],
        correctAnswer: ['wings'],
        hint: 'What helps birds to fly?',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_5',
        question: 'Complete the sentence',
        sentenceParts: ['Fish live in ', '.'],
        wordOptions: ['water', 'air', 'land', 'trees'],
        correctAnswer: ['water'],
        hint: 'Where do fish swim?',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_6',
        question: 'Complete the sentence',
        sentenceParts: ['We use our ', ' to see.'],
        wordOptions: ['ears', 'eyes', 'nose', 'mouth'],
        correctAnswer: ['eyes'],
        hint: 'Which body part helps us see?',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_7',
        question: 'Complete the sentence',
        sentenceParts: ['We use our ', ' to hear.'],
        wordOptions: ['ears', 'eyes', 'nose', 'mouth'],
        correctAnswer: ['ears'],
        hint: 'Which body part helps us hear sounds?',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_8',
        question: 'Complete the sentence',
        sentenceParts: ['The grass is ', '.'],
        wordOptions: ['green', 'blue', 'red', 'yellow'],
        correctAnswer: ['green'],
        hint: 'What color is the grass in a garden?',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_9',
        question: 'Complete the sentence',
        sentenceParts: ['We go to ', ' to learn.'],
        wordOptions: ['school', 'park', 'market', 'hospital'],
        correctAnswer: ['school'],
        hint: 'Where do children go to study?',
        points: 10,
      ),
      SentenceQuestion(
        id: 'sent_10',
        question: 'Complete the sentence',
        sentenceParts: ['We sleep at ', '.'],
        wordOptions: ['day', 'night', 'morning', 'evening'],
        correctAnswer: ['night'],
        hint: 'When do most people go to bed?',
        points: 10,
      ),
    ];
  }
}
