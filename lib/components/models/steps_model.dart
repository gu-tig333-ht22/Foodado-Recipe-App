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
