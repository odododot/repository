import '../entity/coin.dart';
import '../entity/ohlc_data.dart';
import '../entity/stock_price.dart';

abstract class StockRepository {
  Future<List<StockPrice>> getStockPrices(String ticker);
  Future<List<Coin>> getCoinList();
  Future<List<OhlcData>> getOhlcData(String ticker);
}
