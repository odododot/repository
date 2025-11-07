import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled1/domain/entity/ohlc_data.dart';
import 'package:untitled1/domain/entity/recommendation.dart';

class StockChart extends StatefulWidget {
  final List<OhlcData> ohlcData;
  final Recommendation? recommendation;
  final String coinId;

  const StockChart({
    Key? key,
    required this.ohlcData,
    required this.coinId,
    this.recommendation,
  }) : super(key: key);

  @override
  State<StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<StockChart> {
  late ZoomPanBehavior _zoomPanBehavior;
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enablePanning: true,
      enableMouseWheelZooming: true,
      zoomMode: ZoomMode.x,
    );
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.singleTap, // Changed from mouseOver
      lineType: TrackballLineType.vertical,
      tooltipDisplayMode: TrackballDisplayMode.groupAllPoints,
      lineDashArray: const [5, 5],
      tooltipSettings: const InteractiveTooltip(enable: true),
      shouldAlwaysShow: false, // Changed to false, will show on tap
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ohlcData.isEmpty) {
      return const Center(child: Text('No data available'));
    }

    final Color chartBackgroundColor = const Color.fromRGBO(22, 25, 39, 1);
    final Color gridLineColor = Colors.white.withOpacity(0.2);

    return SfCartesianChart(
      backgroundColor: chartBackgroundColor,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        dateFormat: DateFormat.yMMMd(),
        majorGridLines: MajorGridLines(width: 1, color: gridLineColor),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        labelStyle: const TextStyle(color: Colors.grey),
      ),
      primaryYAxis: NumericAxis(
        numberFormat: NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 2),
        opposedPosition: true,
        majorGridLines: MajorGridLines(width: 1, color: gridLineColor),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        labelStyle: const TextStyle(color: Colors.grey),
      ),
      series: <CartesianSeries>[
        CandleSeries<OhlcData, DateTime>(
          dataSource: widget.ohlcData,
          xValueMapper: (OhlcData data, _) => data.date,
          lowValueMapper: (OhlcData data, _) => data.low,
          highValueMapper: (OhlcData data, _) => data.high,
          openValueMapper: (OhlcData data, _) => data.open,
          closeValueMapper: (OhlcData data, _) => data.close,
          enableSolidCandles: true,
          bullColor: const Color.fromRGBO(0, 178, 124, 1),
          bearColor: const Color.fromRGBO(242, 54, 69, 1),
        ),
      ],
      zoomPanBehavior: _zoomPanBehavior,
      trackballBehavior: _trackballBehavior,
      annotations: _buildAnnotations(),
    );
  }

  List<CartesianChartAnnotation> _buildAnnotations() {
    final List<CartesianChartAnnotation> annotations = [];

    // Watermark
    if (widget.ohlcData.isNotEmpty) {
      final double minY = widget.ohlcData.map((d) => d.low).reduce((a, b) => a < b ? a : b);
      final double maxY = widget.ohlcData.map((d) => d.high).reduce((a, b) => a > b ? a : b);
      annotations.add(
        CartesianChartAnnotation(
          widget: Text(
            widget.coinId.toUpperCase(),
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          coordinateUnit: CoordinateUnit.point,
          x: widget.ohlcData[widget.ohlcData.length ~/ 2].date, // Center date
          y: (minY + maxY) / 2, // Center price
        ),
      );
    }

    // Recommendation Marker
    if (widget.recommendation != null) {
      OhlcData? triggerData;
      try {
        triggerData = widget.ohlcData.firstWhere((d) =>
        d.date.year == widget.recommendation!.triggerDate.year &&
            d.date.month == widget.recommendation!.triggerDate.month &&
            d.date.day == widget.recommendation!.triggerDate.day);
      } catch (e) {
        // Not found
      }

      if (triggerData != null) {
        annotations.add(
          CartesianChartAnnotation(
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text('BUY', style: TextStyle(color: Color.fromRGBO(0, 178, 124, 1), fontWeight: FontWeight.bold, fontSize: 12)),
                Icon(Icons.arrow_downward, color: Color.fromRGBO(0, 178, 124, 1), size: 18),
              ],
            ),
            coordinateUnit: CoordinateUnit.point,
            x: triggerData.date,
            y: triggerData.high,
            verticalAlignment: ChartAlignment.near,
            horizontalAlignment: ChartAlignment.center,
          ),
        );
      }
    }

    return annotations;
  }
}