import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:untitled1/domain/entity/ohlc_data.dart';
import 'package:untitled1/domain/entity/stock_price.dart';
import '../../domain/entity/recommendation.dart';
import '../../domain/use_case/get_ohlc_data_use_case.dart';
import '../../domain/use_case/get_recommendation_use_case.dart';

class StockViewModel with ChangeNotifier {
  final GetOhlcDataUseCase _getOhlcDataUseCase;
  final GetRecommendationUseCase _getRecommendationUseCase;

  StockViewModel({
    required GetOhlcDataUseCase getOhlcDataUseCase,
    required GetRecommendationUseCase getRecommendationUseCase,
  })  : _getOhlcDataUseCase = getOhlcDataUseCase,
        _getRecommendationUseCase = getRecommendationUseCase;

  List<OhlcData> _ohlcData = [];
  List<OhlcData> get ohlcData => _ohlcData;

  Recommendation? _recommendation;
  Recommendation? get recommendation => _recommendation;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchData(String ticker) async {
    log('Fetching OHLC data for $ticker');
    _isLoading = true;
    notifyListeners();

    try {
      _ohlcData = await _getOhlcDataUseCase(ticker);
      log('Fetched ${_ohlcData.length} OHLC data points');

      // Adapt OHLC data to a list of close prices for the recommendation engine
      final closePrices = _ohlcData
          .map((d) => StockPrice(date: d.date, price: d.close))
          .toList();

      _recommendation = _getRecommendationUseCase(closePrices);
      log('Recommendation: ${_recommendation?.reason}');
    } catch (e) {
      log('Error fetching data: $e');
    }

    _isLoading = false;
    notifyListeners();
    log('Data fetch complete');
  }
}
