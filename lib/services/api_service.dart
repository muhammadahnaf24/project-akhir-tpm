import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project_akhir_tpm/models/jellybean_model.dart';

Future<List<JellyBean>> fetchJellyBeans() async {
  final String apiUrl = 'https://jellybellywikiapi.onrender.com/api/Beans';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    List<dynamic> items = jsonResponse['items'];
    return items.map((bean) => JellyBean.fromJson(bean)).toList();
  } else {
    throw Exception('Failed to load jelly beans');
  }
}
