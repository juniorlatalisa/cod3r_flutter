import 'dart:math';
import 'dart:io';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/chart.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/cupertino.dart';
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

  final _isIOS = !Platform.isIOS;

  Widget _getIconButton(IconData icon, Function fn) {
    return _isIOS
        ? GestureDetector(child: Icon(icon), onTap: fn)
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    _openTransactionFormModal() => showModalBottomSheet(
          context: context,
          builder: (_) => TransactionForm(_addTransaction),
        );
    final _mqd = MediaQuery.of(context);
    final _isLandscape = _mqd.orientation == Orientation.landscape;
    final _actions = <Widget>[
      if (_isLandscape)
        _getIconButton(
          showGrafico ? Icons.list : Icons.show_chart,
          () => setState(() => showGrafico = !showGrafico),
        ),
      _getIconButton(
        _isIOS ? CupertinoIcons.add : Icons.add,
        _openTransactionFormModal,
      ),
    ];
    final _title = Text('Despessas pessoais');
    final PreferredSizeWidget _appBar = _isIOS
        ? CupertinoNavigationBar(
            middle: _title,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: _actions,
            ),
          )
        : AppBar(
            title: _title,
            actions: _actions,
          );

    final _height =
        _mqd.size.height - _mqd.padding.top - _appBar.preferredSize.height;
    final _chartHeight =
        _height * (_isLandscape ? (showGrafico ? 0.7 : 0.0) : 0.3);
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
    final _body = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text('Exibir gráfico'),
        //     Switch.adaptive(
        //         activeColor: Theme.of(context).accentColor,
        //         value: showGrafico,
        //         onChanged: (newValue) =>
        //             setState(() => showGrafico = newValue))
        //   ],
        // ),
        if (showGrafico || !_isLandscape) _chart,
        if (!showGrafico || !_isLandscape) _list,
      ],
    );

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: _body,
      ),
      floatingActionButton: _isIOS
          ? null
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _openTransactionFormModal,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
