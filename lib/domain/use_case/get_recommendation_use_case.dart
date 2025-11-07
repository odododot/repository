import 'dart:developer';

import '../entity/recommendation.dart';
import '../entity/stock_price.dart';

class GetRecommendationUseCase {
  Recommendation? call(List<StockPrice> prices) {
    log('Analyzing ${prices.length} prices...');
    final movingAverageRecommendation = _check20DayMovingAverage(prices);
    if (movingAverageRecommendation != null) {
      return movingAverageRecommendation;
    }

    final divergenceRecommendation = _checkRisingDivergence(prices);
    if (divergenceRecommendation != null) {
      return divergenceRecommendation;
    }

    log('No recommendation found.');
    return null;
  }

  Recommendation? _check20DayMovingAverage(List<StockPrice> prices) {
    if (prices.length < 20) {
      log('[MA] Not enough data: ${prices.length} prices');
      return null;
    }

    final twentyDayPrices = prices.sublist(prices.length - 20);
    final movingAverage =
        twentyDayPrices.map((p) => p.price).reduce((a, b) => a + b) / 20;

    final latestPrice = prices.last.price;
    final previousPrice = prices[prices.length - 2].price;

    log('[MA] Latest Price: $latestPrice, 20-day MA: $movingAverage');

    if (latestPrice > movingAverage) {
      log('[MA] Price is above 20-day MA!');
      return Recommendation(
        strategy: RecommendationStrategy.twentyDayMovingAverage,
        reason: '현재 가격이 20일 이동평균선 위에 있습니다.',
        triggerDate: prices.last.date,
      );
    }
    return null;
  }

  Recommendation? _checkRisingDivergence(List<StockPrice> prices) {
    // This is a simplified version of rising divergence detection.
    // A real implementation would use an oscillator like RSI.
    if (prices.length < 15) { // Need enough data to find pivots
      log('[Div] Not enough data: ${prices.length} prices');
      return null;
    }

    // Simplified pivot low detection
    List<StockPrice> pivotLows = [];
    for (int i = 2; i < prices.length - 2; i++) {
      if (prices[i].price < prices[i - 1].price &&
          prices[i].price < prices[i - 2].price &&
          prices[i].price < prices[i + 1].price &&
          prices[i].price < prices[i + 2].price) {
        pivotLows.add(prices[i]);
      }
    }

    log('[Div] Found ${pivotLows.length} pivot lows.');

    if (pivotLows.length >= 2) {
      final lastPivot = pivotLows[pivotLows.length - 1];
      final secondLastPivot = pivotLows[pivotLows.length - 2];

      log('[Div] Last pivot: ${lastPivot.price} at ${lastPivot.date}');
      log('[Div] Second last pivot: ${secondLastPivot.price} at ${secondLastPivot.date}');

      // Check if price made a higher low
      if (lastPivot.price > secondLastPivot.price) {
        log('[Div] Higher low detected in price.');
        // In a real scenario, you would check if an oscillator made a lower low.
        // For this example, we'll just trigger on a higher low in price.
        if (prices.last.price > lastPivot.price) { // Ensure price is recovering
          log('[Div] Price is recovering. Divergence recommendation triggered!');
           return Recommendation(
              strategy: RecommendationStrategy.risingDivergence,
              reason: '가격이 상승 다이버전스 패턴을 보이고 있습니다.',
              triggerDate: lastPivot.date,
           );
        }
      }
    }

    return null;
  }
}
