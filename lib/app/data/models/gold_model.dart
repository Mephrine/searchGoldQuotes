import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_gold.dart';

class GoldModel extends HomeGold {
  final String jewelryType;
  final String goldPurity;
  final String goldPriceType;

  GoldModel(
      {@required this.jewelryType,
      @required String goldDate,
      @required this.goldPurity,
      @required this.goldPriceType,
      @required String goldCurrency,
      @required String goldPrice})
      : super(
            date: goldDate,
            price: goldPrice,
            day: _dateToDay(goldDate),
            goldCurrency: goldCurrency);

  @override
  List<Object> get props =>
      [jewelryType, date, goldPurity, goldPriceType, price];

  static String _dateToDay(String date) {
    if (date == '2021-02-10') {
      return '오늘';
    }
    return '과거';
  }

  factory GoldModel.fromJson(Map<String, dynamic> jsonMap) {
    return GoldModel(
        jewelryType: jsonMap['jewelryType'],
        goldDate: jsonMap['goldDate'],
        goldPurity: jsonMap['goldPurity'],
        goldPriceType: jsonMap['goldPriceType'],
        goldPrice: jsonMap['goldPrice'],
        goldCurrency: jsonMap['goldCurrency']);
  }

  Map<String, dynamic> toJson() {
    return {
      "jewelryType": jewelryType,
      "goldDate": date,
      "goldPurity": goldPurity,
      "goldPriceType": goldPriceType,
      "goldPrice": price,
      "goldCurrency": goldCurrency
    };
  }
}