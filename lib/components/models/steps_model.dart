import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:grupp_5/components/models/api_service.dart';

class AnalyzedInstruction {
  final List<Steps> steps;

  const AnalyzedInstruction({
    required this.steps,
  });

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) {
    return AnalyzedInstruction(
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

//StepsProvider Analyzedinstructions

// Future<AnalyzedInstruction> fetchAnalyzedInstruction() async {
//   final response = await http.get(Uri.parse(
//       '$apiUrl/recipes/$apiId/analyzedInstructions?apiKey=$apiKey&stepBreakdown=true'));
//   if (response.statusCode == 200) {
//     return AnalyzedInstruction.fromJson(jsonDecode(response.body)[0]);
//   } else {
//     throw Exception('Failed to load AnalyzedInstruction');
//   }
class AnalyzedInstructionProvider with ChangeNotifier {
  AnalyzedInstruction? _analyzedInstruction;

  AnalyzedInstruction? get analyzedInstruction => _analyzedInstruction;

  AnalyzedInstructionProvider() {
    fetchAnalyzedInstruction();
  }

  Future<AnalyzedInstruction> fetchAnalyzedInstruction() async {
    final response = await http.get(Uri.parse(
        '$apiUrl/recipes/$apiId/analyzedInstructions?apiKey=$apiKey&stepBreakdown=true'));
    if (response.statusCode == 200) {
      _analyzedInstruction =
          AnalyzedInstruction.fromJson(jsonDecode(response.body)[0]);
      notifyListeners();
      return _analyzedInstruction!;
    } else {
      throw Exception('Failed to load AnalyzedInstruction');
    }
  }
}
