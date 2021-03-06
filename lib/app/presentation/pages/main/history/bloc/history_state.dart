part of 'history_bloc.dart';

@immutable
abstract class HistoryState extends Equatable {}

class InitialHistoryState extends HistoryState {
  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends InitialHistoryState {}

class Loading extends InitialHistoryState {}

class Loaded extends InitialHistoryState {
  final Period period;
  final ExchangeState exchangeState;
  final HistoryJewelryList historyList;
  final List<HistoryJewelry> chartList;
  final List<double> sortedPriceList;

  Loaded(
      {@required this.period,
      @required this.exchangeState,
      @required this.historyList,
      @required this.chartList,
      @required this.sortedPriceList});
}

class Error extends InitialHistoryState {
  final String errorMessage;
  Error({@required this.errorMessage});
}
