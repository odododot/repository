import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/presentation/view/stock_screen.dart';
import 'package:untitled1/presentation/viewmodel/coin_list_view_model.dart';

class CoinListScreen extends StatefulWidget {
  const CoinListScreen({Key? key}) : super(key: key);

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<CoinListViewModel>().fetchCoins());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CoinListViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Top 20 Coins by Market Cap'),
      ),
      body: viewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: viewModel.coins.length,
              itemBuilder: (context, index) {
                final coin = viewModel.coins[index];
                return Card(
                  child: ListTile(
                    title: Text(coin.name),
                    subtitle: Text(coin.symbol.toUpperCase()),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StockScreen(coinId: coin.id),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
