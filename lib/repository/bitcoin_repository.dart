import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/bitcoin.dart';

class BitcoinRepository {
  final String _baseUrl = 'https://rest.coincap.io/v3/assets';
  final String _apiKey = '305ae7fa2f751acd65d11e950bbbec3f5b7608b7858b62f04b43de441e967adb';

  Future<List<BitCoin>> fetchBitcoins() async {
    final response = await http.get(Uri.parse('$_baseUrl?apiKey=$_apiKey'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> bitcoinList = data['data'];
      return bitcoinList.map((json) => BitCoin.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Bitcoin data');
    }
  }
}