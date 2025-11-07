import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled1/domain/entity/coin.dart';
import 'package:untitled1/domain/use_case/get_coin_list_use_case.dart';

class CoinListViewModel with ChangeNotifier {
  final GetCoinListUseCase _getCoinListUseCase;

  CoinListViewModel({
    required GetCoinListUseCase getCoinListUseCase,
  }) : _getCoinListUseCase = getCoinListUseCase;

  List<Coin> _coins = [];
  List<Coin> get coins => _coins;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchCoins() async {
    _isLoading = true;
    notifyListeners();

    try {
      _coins = await _getCoinListUseCase();
      log('Fetched ${_coins.length} coins.');
    } catch (e) {
      log('Error fetching coins: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
