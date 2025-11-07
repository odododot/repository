import 'package:untitled1/domain/entity/coin.dart' as domain_coin;
import 'package:untitled1/domain/entity/ohlc_data.dart' as domain_ohlc;
import 'package:untitled1/domain/entity/stock_price.dart' as domain;
import '../../domain/repository/stock_repository.dart';
import '../data_source/local_stock_data_source.dart';
import '../data_source/remote_stock_data_source.dart';

class StockRepositoryImpl implements StockRepository {
  final LocalStockDataSource _localDataSource;
  final RemoteStockDataSource _remoteDataSource;

  StockRepositoryImpl({
    required LocalStockDataSource localDataSource,
    required RemoteStockDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<List<domain_coin.Coin>> getCoinList() async {
    final coins = await _remoteDataSource.getCoinList();
    return coins
        .map((e) => domain_coin.Coin(id: e.id, symbol: e.symbol, name: e.name))
        .toList();
  }

  @override
  Future<List<domain_ohlc.OhlcData>> getOhlcData(String ticker) async {
    final ohlcData = await _remoteDataSource.getOhlcData(ticker);
    return ohlcData
        .map((e) => domain_ohlc.OhlcData(
              date: e.date,
              open: e.open,
              high: e.high,
              low: e.low,
              close: e.close,
            ))
        .toList();
  }

  @override
  Future<List<domain.StockPrice>> getStockPrices(String ticker) async {
    // Try to get data from local source first
    final localPrices = await _localDataSource.getStockPrices(ticker);

    if (localPrices.isNotEmpty) {
      return localPrices.map((e) => domain.StockPrice(date: e.date, price: e.price)).toList();
    } else {
      // If no local data, fetch from remote
      final remotePrices = await _remoteDataSource.getStockPrices(ticker);
      // Save to local source for future use
      _localDataSource.saveStockPrices(ticker, remotePrices);
      return remotePrices.map((e) => domain.StockPrice(date: e.date, price: e.price)).toList();
    }
  }
}
