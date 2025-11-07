import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/stock_view_model.dart';
import '../widget/recommendation_view.dart';
import '../widget/stock_chart.dart';

class StockScreen extends StatefulWidget {
  final String coinId;
  const StockScreen({Key? key, required this.coinId}) : super(key: key);

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch initial data
    Future.microtask(() => context.read<StockViewModel>().fetchData(widget.coinId));
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StockViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.coinId),
      ),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 4, // Give more space to the chart
                  child: StockChart(
                    ohlcData: viewModel.ohlcData,
                    recommendation: viewModel.recommendation,
                    coinId: widget.coinId,
                  ),
                ),
                if (viewModel.recommendation != null)
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RecommendationView(recommendation: viewModel.recommendation),
                    ),
                  ),
              ],
            ),
    );
  }
}
