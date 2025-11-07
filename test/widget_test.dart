import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/domain/entity/recommendation.dart';
import 'package:untitled1/domain/entity/stock_price.dart';
import 'package:untitled1/presentation/view/stock_screen.dart';
import 'package:untitled1/presentation/viewmodel/stock_view_model.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([StockViewModel])
void main() {
  testWidgets('StockScreen should display loading indicator and then data', (WidgetTester tester) async {
    // Arrange
    final mockViewModel = MockStockViewModel();
    when(mockViewModel.isLoading).thenReturn(true);
    when(mockViewModel.prices).thenReturn([]);
    when(mockViewModel.recommendation).thenReturn(null);

    // Act
    await tester.pumpWidget(
      ChangeNotifierProvider<StockViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(
          home: StockScreen(),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Arrange 2
    when(mockViewModel.isLoading).thenReturn(false);
    when(mockViewModel.prices).thenReturn([
      StockPrice(date: DateTime.now(), price: 100),
    ]);
    when(mockViewModel.recommendation).thenReturn(
      Recommendation(
        strategy: RecommendationStrategy.twentyDayMovingAverage,
        reason: 'Test Reason',
      ),
    );

    // Act 2
    await tester.pumpWidget(
      ChangeNotifierProvider<StockViewModel>.value(
        value: mockViewModel,
        child: const MaterialApp(
          home: StockScreen(),
        ),
      ),
    );
    await tester.pump(); // Rebuild the widget

    // Assert 2
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('StockView'), findsOneWidget);
    expect(find.textContaining('Test Reason'), findsOneWidget);
  });
}