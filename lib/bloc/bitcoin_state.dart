// Define the states
import 'package:search/model/bitcoin.dart';

abstract class BitCoinState {}
class Initial extends BitCoinState {}
class InProgress extends BitCoinState {}
class Success extends BitCoinState {
    final List<BitCoin> list;
  Success(this.list);

}
class Failure extends BitCoinState {
  final String error;
  Failure(this.error);
}