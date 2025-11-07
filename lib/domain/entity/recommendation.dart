import 'package:equatable/equatable.dart';

enum RecommendationStrategy {
  twentyDayMovingAverage,
  risingDivergence,
}

class Recommendation extends Equatable {
  final RecommendationStrategy strategy;
  final String reason;
  final DateTime triggerDate;

  const Recommendation({
    required this.strategy,
    required this.reason,
    required this.triggerDate,
  });

  @override
  List<Object?> get props => [strategy, reason, triggerDate];
}
