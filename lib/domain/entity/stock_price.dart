import 'package:equatable/equatable.dart';

class StockPrice extends Equatable {
  final DateTime date;
  final double price;

  const StockPrice({required this.date, required this.price});

  @override
  List<Object?> get props => [date, price];
}
