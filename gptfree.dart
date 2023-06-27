import 'dart:convert';
import 'package:http/http.dart' as http;

class GPTfree {

  static Future<Map<String, dynamic>> create({
    String systemMessage = "Vous êtes ChatGPT, un grand modèle linguistique formé par OpenAI. Suivez attentivement les instructions de l'utilisateur. Répondre en utilisant le markdown",
    String prompt = "",
    String parentMessageId = "",
    double temperature = 0.8,
    double topP = 1,
  }) async {
    var jsonBody = {
      "prompt": prompt,
      //"options": {"parentMessageId": parentMessageId},
      "systemMessage": systemMessage,
      "temperature": temperature,
      "top_p": topP,
    };

    final headers = {
      'Accept': 'application/json, text/plain, */*',
      'Accept-Encoding': 'gzip, deflate',
      'Accept-Language': 'fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7',
      'Connection': 'keep-alive',
      'Content-Type': 'application/json',
      'Host': '43.153.7.56:8080',
      'Origin': 'http://43.153.7.56:8081',
      'Referer': 'http://43.153.7.56:8081/',
      'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36'
    };

    var url = Uri.parse("http://43.153.7.56:8081/api/chat-process");
    var response = await http.post(url, body: json.encode(jsonBody), headers: headers);
    var content = response.body;

    var jsonResponse = _loadJson(content);
    return jsonResponse;
  }

  static Map<String, dynamic> _loadJson(String content) {
    var decodeContent = utf8.decode(content.runes.toList());
    var split = decodeContent.split("\n").last;
    var toJson = json.decode(split);
    return toJson;
  }
}
