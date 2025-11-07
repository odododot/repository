import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:untitled1/data/data_source/local_stock_data_source.dart';
import 'package:untitled1/data/data_source/remote_stock_data_source.dart';
import 'package:untitled1/data/model/stock_price.dart' as data;
import 'package:untitled1/domain/entity/stock_price.dart' as domain;
import 'package:untitled1/data/repository/stock_repository_impl.dart';

import 'stock_repository_impl_test.mocks.dart';

@GenerateMocks([LocalStockDataSource, RemoteStockDataSource])
void main() {
  group('StockRepositoryImpl', () {
    late StockRepositoryImpl repository;
    late MockLocalStockDataSource mockLocalDataSource;
    late MockRemoteStockDataSource mockRemoteDataSource;

    setUp(() {
      mockLocalDataSource = MockLocalStockDataSource();
      mockRemoteDataSource = MockRemoteStockDataSource();
      repository = StockRepositoryImpl(
        localDataSource: mockLocalDataSource,
        remoteDataSource: mockRemoteDataSource,
      );
    });

    test('should return local data when available', () async {
      // Arrange
      final tDate = DateTime.now();
      final localData = [data.StockPrice(date: tDate, price: 100)];
      final expectedData = [domain.StockPrice(date: tDate, price: 100)];
      when(mockLocalDataSource.getStockPrices(any)).thenAnswer((_) async => localData);

      // Act
      final result = await repository.getStockPrices('AAPL');

      // Assert
      expect(result, expectedData);
      verify(mockLocalDataSource.getStockPrices('AAPL'));
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('should return remote data and save to local when local data is not available', () async {
      // Arrange
      final tDate = DateTime.now();
      final remoteData = [data.StockPrice(date: tDate, price: 200)];
      final expectedData = [domain.StockPrice(date: tDate, price: 200)];
      when(mockLocalDataSource.getStockPrices(any)).thenAnswer((_) async => []);
      when(mockRemoteDataSource.getStockPrices(any)).thenAnswer((_) async => remoteData);

      // Act
      final result = await repository.getStockPrices('AAPL');

      // Assert
      expect(result, expectedData);
      verify(mockLocalDataSource.getStockPrices('AAPL'));
      verify(mockRemoteDataSource.getStockPrices('AAPL'));
      verify(mockLocalDataSource.saveStockPrices('AAPL', remoteData));
    });
  });
}
