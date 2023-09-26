class ResponseModel {
  final String id;
  final String object;
  final int created;
  final String model;
  final List<Choice> choices;
  final Usage usage;

  ResponseModel({
    required this.id,
    required this.object,
    required this.created,
    required this.model,
    required this.choices,
    required this.usage,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    List<Choice> choices = (json['choices'] as List)
        .map((choice) => Choice.fromJson(choice))
        .toList();

    Usage usage = Usage.fromJson(json['usage']);

    return ResponseModel(
      id: json['id'],
      object: json['object'],
      created: json['created'],
      model: json['model'],
      choices: choices,
      usage: usage,
    );
  }
}

class Choice {
  final String text;
  final int index;
  final dynamic logprobs;
  final String finishReason;

  Choice({
    required this.text,
    required this.index,
    required this.logprobs,
    required this.finishReason,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      text: json['text'],
      index: json['index'],
      logprobs: json['logprobs'],
      finishReason: json['finish_reason'],
    );
  }
}

class Usage {
  final int promptTokens;
  final int completionTokens;
  final int totalTokens;

  Usage({
    required this.promptTokens,
    required this.completionTokens,
    required this.totalTokens,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
      promptTokens: json['prompt_tokens'],
      completionTokens: json['completion_tokens'],
      totalTokens: json['total_tokens'],
    );
  }
}