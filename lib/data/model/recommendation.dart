enum RecommendationStrategy {
  twentyDayMovingAverage,
  risingDivergence,
}

class Recommendation {
  final RecommendationStrategy strategy;
  final String reason;

  Recommendation({required this.strategy, required this.reason});
}
