import 'package:http/http.dart' as http;
import 'dart:convert';

Future<double> getPrice(String id) async {
  try {
    var url =
        'https://api.coingecko.com/api/v3/simple/price?ids=$id&vs_currencies=usd';

    var response = await http.get(
      Uri.parse(url),
    );
    var json = jsonDecode(response.body);
    var value = json[id]['usd'].toString();
    return double.parse(value);
  } catch (e) {
    // ignore: avoid_print
    print(e);
    return 0.0;
  }
}
