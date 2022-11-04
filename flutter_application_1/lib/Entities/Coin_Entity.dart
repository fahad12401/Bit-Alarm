class Coin {
  late String symbol;
  late String name;
  late double price;
  late double volume;
  late double change24th;

  Coin(
      {required this.name,
      required this.symbol,
      required this.price,
      required this.change24th,
      required this.volume});

  Coin.fromJSON(dynamic json) {
    symbol = json['symbol'];
    name = json['name'];
    price = (json['quote']['USD']['price']).toDouble();
    volume = (json['quote']['USD']['volume_24h']).toDouble();
    change24th = (json['quote']['USD']['percent_change_24h']).toDouble();
  }

  @override
  String toString() => "$symbol ($price)";
}
