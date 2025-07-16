import 'package:http/http.dart' as http;

void main() async {
  final response = await http.get(Uri.parse('http://213.171.26.195:8080/'));
  print("Failed with status code ${response.body}");
}