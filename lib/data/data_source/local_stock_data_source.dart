import '../model/stock_price.dart';
import './stock_data_source.dart';

class LocalStockDataSource implements StockDataSource {
  final Map<String, List<StockPrice>> _cache = {};

  @override
  Future<List<StockPrice>> getStockPrices(String ticker) async {
    if (_cache.containsKey(ticker)) {
      return _cache[ticker]!;
    } else {
      // In a real app, this would fetch from a local database (e.g., sqflite)
      // For now, we return an empty list to signify no data in local cache.
      return [];
    }
  }

  void saveStockPrices(String ticker, List<StockPrice> prices) {
    _cache[ticker] = prices;
  }
}
