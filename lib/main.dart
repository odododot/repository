import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/data/data_source/local_stock_data_source.dart';
import 'package:untitled1/data/data_source/remote_stock_data_source.dart';
import 'package:untitled1/data/repository/stock_repository_impl.dart';
import 'package:untitled1/domain/repository/stock_repository.dart';
import 'package:untitled1/domain/use_case/get_coin_list_use_case.dart';
import 'package:untitled1/domain/use_case/get_ohlc_data_use_case.dart';
import 'package:untitled1/domain/use_case/get_recommendation_use_case.dart';
import 'package:untitled1/presentation/view/coin_list_screen.dart';
import 'package:untitled1/presentation/viewmodel/coin_list_view_model.dart';
import 'package:untitled1/presentation/viewmodel/stock_view_model.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  final StockRepository repository = StockRepositoryImpl(
    localDataSource: LocalStockDataSource(),
    remoteDataSource: RemoteStockDataSource(),
  );
  final getOhlcDataUseCase = GetOhlcDataUseCase(repository);
  final getRecommendationUseCase = GetRecommendationUseCase();
  final getCoinListUseCase = GetCoinListUseCase(repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CoinListViewModel(
            getCoinListUseCase: getCoinListUseCase,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => StockViewModel(
            getOhlcDataUseCase: getOhlcDataUseCase,
            getRecommendationUseCase: getRecommendationUseCase,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StockView',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.robotoTextTheme(ThemeData.dark().textTheme),
      ),
      home: const CoinListScreen(),
    );
  }
}

