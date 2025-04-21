class BitCoin {
  final String id;
  final String name;
  final String symbol;
  final double priceUsd;

  BitCoin({
    required this.id,
    required this.name,
    required this.symbol,
    required this.priceUsd,
  });

  factory BitCoin.fromJson(Map<String, dynamic> json) {
    return BitCoin(
      id: json['id'],
      name: json['name'],
      symbol: json['symbol'],
      priceUsd: double.parse(json['priceUsd']),
    );
  }
}