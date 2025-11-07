import '../entity/ohlc_data.dart';
import '../repository/stock_repository.dart';

class GetOhlcDataUseCase {
  final StockRepository _repository;

  GetOhlcDataUseCase(this._repository);

  Future<List<OhlcData>> call(String ticker) {
    return _repository.getOhlcData(ticker);
  }
}
