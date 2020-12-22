import 'dart:io';

import 'package:expenses/components/transaction_user.dart';
import 'package:flutter/material.dart';

final isIOSPlatform = !Platform.isIOS;

// main() => runApp(const ExpensesApp());

main(List<String> args) {
  const myHomePage = MyHomePage();
  runApp(const ExpensesApp(myHomePage));
  WidgetsBinding.instance.addObserver(myHomePage);
  myHomePage.didChangeAppLifecycleState(AppLifecycleState.resumed);
}

class ExpensesApp extends StatelessWidget {
  final StatelessWidget myHomePage;

  const ExpensesApp(this.myHomePage);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: myHomePage,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ),
      );
}

class MyHomePage extends StatelessWidget with WidgetsBindingObserver {
  const MyHomePage();

  // @override
  // Widget build(BuildContext context) {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //   ]);
  //   return TransactionsUser();
  // }

  @override
  Widget build(BuildContext context) => TransactionsUser();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('The app state is $state');
  }
}
