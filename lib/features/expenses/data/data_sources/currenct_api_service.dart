import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class CurrencyApiService {
  Future<double> fetchRate(String from, String to);
}

class CurrencyApiServiceImpl implements CurrencyApiService {
  @override
  Future<double> fetchRate(String from, String to) async {
    final res = await http.get(Uri.parse('https://open.er-api.com/v6/latest/$from'));
    if (res.statusCode == 200) {
      final json = jsonDecode(res.body);
      return (json['rates'][to] as num).toDouble();
    }
    throw Exception('Failed to fetch rate');
  }
}