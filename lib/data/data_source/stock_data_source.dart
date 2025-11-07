import '../model/stock_price.dart';

abstract class StockDataSource {
  Future<List<StockPrice>> getStockPrices(String ticker);
}
