import 'package:equatable/equatable.dart';

class Coin extends Equatable {
  final String id;
  final String symbol;
  final String name;

  const Coin({
    required this.id,
    required this.symbol,
    required this.name,
  });

  @override
  List<Object?> get props => [id, symbol, name];
}
