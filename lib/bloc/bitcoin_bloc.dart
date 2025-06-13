// Define the Bloc
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/bitcoin_event.dart';
import 'package:search/bloc/bitcoin_state.dart';
import 'package:search/repository/bitcoin_repository.dart';

class BitCoinBloc extends Bloc<BitCoinEvent, BitCoinState> {
  final BitcoinRepository _bitcoinRepository;

  BitCoinBloc(this._bitcoinRepository) : super(Initial()) {
    on<LoadBitCoin>((event, emit) async {
      emit(InProgress());
      // add a delay so that the shimmer effect can be seen
      await Future.delayed(const Duration(seconds: 4));
      try {
        final bitcoins = await _bitcoinRepository.fetchBitcoins();
        emit(Success(bitcoins));
      } catch (error) {
        emit(Failure(error.toString()));
      }
    });
  }
}