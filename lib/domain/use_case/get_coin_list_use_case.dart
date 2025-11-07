import '../entity/coin.dart';
import '../repository/stock_repository.dart';

class GetCoinListUseCase {
  final StockRepository _repository;

  GetCoinListUseCase(this._repository);

  Future<List<Coin>> call() {
    return _repository.getCoinList();
  }
}
