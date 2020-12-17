import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/components/chart.dart';
import 'package:expenses/main.dart';
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

  Widget _getIconButton(IconData icon, Function fn) => isIOSPlatform
      ? GestureDetector(child: Icon(icon), onTap: fn)
      : IconButton(icon: Icon(icon), onPressed: fn);

  @override
  Widget build(BuildContext context) {
    _openTransactionFormModal() => showModalBottomSheet(
          context: context,
          builder: (_) => TransactionForm(_addTransaction),
        );
    final _mqd = MediaQuery.of(context);
    final _isLandscape = _mqd.orientation == Orientation.landscape;
    final IconData _showChart =
        isIOSPlatform ? CupertinoIcons.chart_bar : Icons.show_chart;
    final IconData _showList =
        isIOSPlatform ? CupertinoIcons.list_dash : Icons.list;
    final _actions = <Widget>[
      if (_isLandscape)
        _getIconButton(
          showGrafico ? _showList : _showChart,
          () => setState(() => showGrafico = !showGrafico),
        ),
      _getIconButton(
        isIOSPlatform ? CupertinoIcons.add : Icons.add,
        _openTransactionFormModal,
      ),
    ];
    const _title = const Text('Despessas pessoais');
    final PreferredSizeWidget _appBar = isIOSPlatform
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
        if (showGrafico || !_isLandscape) _chart,
        if (!showGrafico || !_isLandscape) _list,
      ],
    );
    final _bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: _body,
      ),
    );
    return isIOSPlatform
        ? CupertinoPageScaffold(
            navigationBar: _appBar,
            child: _bodyPage,
          )
        : Scaffold(
            appBar: _appBar,
            body: _bodyPage,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: _openTransactionFormModal,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
