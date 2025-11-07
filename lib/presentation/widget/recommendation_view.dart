import 'package:flutter/material.dart';
import '../../domain/entity/recommendation.dart';

class RecommendationView extends StatelessWidget {
  final Recommendation? recommendation;

  const RecommendationView({Key? key, this.recommendation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (recommendation == null) {
      return const SizedBox.shrink();
    }

    return Card(
      color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '추천 전략: ${recommendation!.strategy.toString().split('.').last}',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '추천 이유: ${recommendation!.reason}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
