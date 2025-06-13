import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/bloc/bitcoin_bloc.dart';
import 'package:search/repository/bitcoin_repository.dart';
import 'package:search/widget/load_shimmer.dart';
import 'bloc/bitcoin_event.dart';
import 'bloc/bitcoin_state.dart';

// Wrap the app with BlocProvider
void main() {
  runApp(
    BlocProvider(
      create: (context) => BitCoinBloc(BitcoinRepository()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final BitCoinBloc _bitcoinBloc;

  @override
  void initState() {
    super.initState();
    _bitcoinBloc = BitCoinBloc(BitcoinRepository());
    _bitcoinBloc.add(LoadBitCoin()); // where the loading is trim
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocConsumer<BitCoinBloc, BitCoinState>(
        bloc: _bitcoinBloc,
        listener: (context, state) {
          if (state is Failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          if (state is InProgress) {
            return Center(child: LoaderShimmer());
          } else if (state is Success) {
            return RefreshIndicator(
              onRefresh: () async {
                _bitcoinBloc.add(LoadBitCoin());
              },
              child: ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (context, index) {
                  final bitcoin = state.list[index];
                  return ListTile(
                    leading: Icon(Icons.currency_bitcoin),
                    title: Text(bitcoin.name),
                    subtitle: Text('Price: ${bitcoin.priceUsd.toStringAsFixed(2)} USD'),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text('Press the button to load data.'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _bitcoinBloc.close();
    super.dispose();
  }
}
