import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey = 'your-openai-api-key';

  Future<String> generateSummary(String inputText) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/completions'),
      headers: {'Authorization': 'Bearer $_apiKey'},
      body: jsonEncode({
        'model': 'text-davinci-003',
        'prompt': inputText,
        'max_tokens': 100,
      }),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].trim();
    } else {
      throw Exception('Failed to generate summary');
    }
  }
}
