import 'package:equatable/equatable.dart';

class OhlcData extends Equatable {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;

  const OhlcData({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
  });

  @override
  List<Object?> get props => [date, open, high, low, close];
}
