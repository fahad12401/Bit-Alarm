import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter_application_1/Entities/OrderBook_Entity.dart';
import 'package:dio/adapter.dart';
import 'package:flutter_application_1/Services/Api_key.dart';

import '../Entities/Coin_Entity.dart';

class CoinService {
  Dio dio = Dio();

  CoinService() {
    dio.interceptors.add(DioCacheManager(
            CacheConfig(baseUrl: "https://pro-api.coinmarketcap.com"))
        .interceptor);
  }
  Future<List<Coin>> getAllprices() async {
    String url =
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=100';

    var options = buildCacheOptions(Duration(minutes: 15));
    options.headers['X-CMC_PRO_API_KEY'] = COIN_MARKETCAP_APIKEY;
    Response response = await dio.get(url, options: options);
    List<dynamic> data = response.data['data'];
    List<Coin> coins = data.map((dynamic coin) => Coin.fromJSON(coin)).toList();
    return coins.toList();
  }

  Future<List<Coin>> getPriceForSymbols(List<String> symbols) async {
    var prices = await getAllprices();
    return prices.where((coin) => symbols.indexOf(coin.symbol) != -1).toList();
  }

  Future<List<double>> getHistoricalCoinData(String symbol) async {
    var now = DateTime.now();
    var nowTimestamp =
        now.toIso8601String().replaceFirst('', 'T').substring(0, 19);
    var startDate = now
        .subtract(Duration(days: 365))
        .toIso8601String()
        .replaceFirst('', 'T')
        .substring(0, 19);

    String url =
        "https://rest.coinapi.io/v1/ohlcv/BITSTAMP_SPOT_${symbol}_USD/history?period_id=1DAY&time_start=$startDate&time_end=$nowTimestamp";

    var options = buildCacheOptions(Duration(days: 1));
    options.headers['X-CoinAPI-Key'] = COIN_API_APIKEY;
    Response response = await dio.get(url, options: options);
    List<dynamic> quotes = response.data;
    return quotes.map((quote) {
      double price = quote['price_close'];
      return price;
    }).toList();
  }

  Future<OrderBookModel> getOrderBook(String symbol, {int limit = 50}) async {
    var api =
        "https://api.cryptowat.ch/markets/kraken/${symbol}usd/orderbook?limit=$limit";
    var response = await dio.get(api);
    Map<String, dynamic> result = response.data['result'];
    return OrderBookModel(asks: result['asks'], bids: result['bids']);
  }
}
