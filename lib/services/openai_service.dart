import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = 'your-openai-api-key';

  Future<Map<String, dynamic>> processTaskInput(String userInput) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": "Extract task details from: $userInput",
        "max_tokens": 100,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Parse GPT response
      return {"taskName": "example", "dueDate": "2025-01-30"}; // Mocked response
    } else {
      throw Exception('Failed to process input');
    }
  }
}
