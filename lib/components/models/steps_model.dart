class AnalyzedInstructions {
  final List<Steps> steps;

  const AnalyzedInstructions({
    required this.steps,
  });

  factory AnalyzedInstructions.fromJson(Map<String, dynamic> json) {
    return AnalyzedInstructions(
      steps: List<Steps>.from(json['steps'].map((x) => Steps.fromJson(x))),
    );
  }
}

class Steps {
  final String step;
  final int number;

  const Steps({
    required this.step,
    required this.number,
  });

  factory Steps.fromJson(Map<String, dynamic> json) {
    return Steps(
      step: json['step'] ?? '',
      number: json['number'] ?? 0,
    );
  }
}
