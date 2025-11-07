import '../entity/stock_price.dart';
import '../repository/stock_repository.dart';

class GetStockDataUseCase {
  final StockRepository _repository;

  GetStockDataUseCase(this._repository);

  Future<List<StockPrice>> call(String ticker) {
    return _repository.getStockPrices(ticker);
  }
}
