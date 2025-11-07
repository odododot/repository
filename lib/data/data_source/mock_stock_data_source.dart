import '../model/stock_price.dart';
import './stock_data_source.dart';

class MockStockDataSource implements StockDataSource {
  @override
  Future<List<StockPrice>> getStockPrices(String ticker) async {
    return [
      StockPrice(date: DateTime.now().subtract(const Duration(days: 9)), price: 150),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 8)), price: 152),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 7)), price: 155),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 6)), price: 153),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 5)), price: 158),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 4)), price: 160),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 3)), price: 159),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 2)), price: 162),
      StockPrice(date: DateTime.now().subtract(const Duration(days: 1)), price: 165),
      StockPrice(date: DateTime.now(), price: 163),
    ];
  }
}
