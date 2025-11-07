import 'dart:developer';

import '../entity/recommendation.dart';
import '../entity/stock_price.dart';

class GetRecommendationUseCase {
  Recommendation? call(List<StockPrice> prices) {
    if (prices.isEmpty) {
      return null;
    }

    // For demonstration, always return a recommendation for the last price point.
    log('Generating a demonstration recommendation.');
    return Recommendation(
      strategy: RecommendationStrategy.twentyDayMovingAverage,
      reason: '데모: 이 추천은 기능 확인을 위해 항상 표시됩니다.',
      triggerDate: prices.last.date,
    );
  }
}
