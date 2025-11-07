import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/coin.dart';
import '../model/ohlc_data.dart';
import '../model/stock_price.dart';
import './stock_data_source.dart';

class RemoteStockDataSource implements StockDataSource {
  final http.Client _client;

  RemoteStockDataSource({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Coin>> getCoinList() async {
    final response = await _client.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1&sparkline=false'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Coin.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load coin list');
    }
  }

  Future<List<OhlcData>> getOhlcData(String ticker) async {
    final response = await _client.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/$ticker/ohlc?vs_currency=usd&days=90'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => OhlcData.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load OHLC data');
    }
  }

  @override
  Future<List<StockPrice>> getStockPrices(String ticker) async {
    final response = await _client.get(Uri.parse(
        'https://api.coingecko.com/api/v3/coins/$ticker/market_chart?vs_currency=usd&days=90&interval=daily'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> prices = data['prices'];
      return prices
          .map((item) => StockPrice(
                date: DateTime.fromMillisecondsSinceEpoch(item[0]),
                price: item[1].toDouble(),
              ))
          .toList();
    } else {
      throw Exception('Failed to load stock prices');
    }
  }
}
