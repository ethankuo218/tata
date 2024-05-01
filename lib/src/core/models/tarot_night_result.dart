class TarotNightResult {
  final String question;
  final String answer;

  TarotNightResult({required this.question, required this.answer});

  factory TarotNightResult.fromMap(Map<String, dynamic> map) {
    return TarotNightResult(
      question: map['question'],
      answer: map['answer'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
