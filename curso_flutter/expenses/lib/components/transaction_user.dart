import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsUser extends StatefulWidget {
  @override
  _TransactionsUserState createState() => _TransactionsUserState();
}

class _TransactionsUserState extends State<TransactionsUser> {
  var showGrafico = true;
  final _transactions = <Transaction>[
    // Transaction(
    //   id: 't0',
    //   title: 'Conta antiga',
    //   value: 400.0,
    //   date: DateTime.now().subtract(Duration(days: 33)),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Novo Tênis de corrida',
    //   value: 10.76,
    //   date: DateTime.now().subtract(Duration(days: 3)),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Conta de luz',
    //   value: 11.3,
    //   date: DateTime.now().subtract(Duration(days: 1)),
    // ),
    // Transaction(
    //   id: 't3',
    //   title: 'Conta de luz 2',
    //   value: 8.7,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'Conta de luz 3',
    //   value: 8.7,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    final startWeek = DateTime.now().subtract(Duration(days: 7));
    return _transactions.where((tr) => tr.date.isAfter(startWeek)).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    Navigator.of(context).pop();

    final newTransction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() => _transactions.add(newTransction));
  }

  _delTransaction(String id) {
    setState(() => _transactions.removeWhere((tr) => id == tr.id));
  }

  @override
  Widget build(BuildContext context) {
    _openTransactionFormModal() => showModalBottomSheet(
          context: context,
          builder: (_) => TransactionForm(_addTransaction),
        );

    final _add = Icon(Icons.add);
    final _appBar = AppBar(
      title: Text('Despesas'),
      actions: <Widget>[
        IconButton(
          icon: _add,
          onPressed: _openTransactionFormModal,
        )
      ],
    );
    final _mqd = MediaQuery.of(context);
    final _height =
        _mqd.size.height - _mqd.padding.top - _appBar.preferredSize.height;
    final _chartHeight = _height * 0.3;
    final _chartHeightMin = 150.0;
    final _chart = Container(
      height: _chartHeight < _chartHeightMin ? _chartHeightMin : _chartHeight,
      child: Chart(_recentTransactions),
    );
    final _list = Container(
      height: _height -
          (_chartHeight < _chartHeightMin ? _chartHeightMin : _chartHeight),
      child: TransactionList(_transactions, _delTransaction),
    );

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Exibir gráfico'),
                Switch(
                    value: showGrafico,
                    onChanged: (newValue) =>
                        setState(() => showGrafico = newValue))
              ],
            ),
            if (showGrafico) _chart,
            _list,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: _add,
        onPressed: _openTransactionFormModal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
