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

  factory OhlcData.fromJson(List<dynamic> json) {
    return OhlcData(
      date: DateTime.fromMillisecondsSinceEpoch(json[0]),
      open: json[1].toDouble(),
      high: json[2].toDouble(),
      low: json[3].toDouble(),
      close: json[4].toDouble(),
    );
  }

  @override
  List<Object?> get props => [date, open, high, low, close];
}
