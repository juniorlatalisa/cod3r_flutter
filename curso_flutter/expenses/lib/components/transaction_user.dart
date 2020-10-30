import 'dart:math';

import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsUser extends StatefulWidget {
  @override
  _TransactionsUserState createState() => _TransactionsUserState();
}

class _TransactionsUserState extends State<TransactionsUser> {
  final _transactions = <Transaction>[
    // Transaction(
    //   id: 't1',
    //   title: 'Novo Tênis de corrida',
    //   value: 310.76,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Conta de luz',
    //   value: 211.3,
    //   date: DateTime.now(),
    // ),
  ];

  _addTransaction(String title, double value) {
    Navigator.of(context).pop();

    final newTransction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() => _transactions.add(newTransction));
  }

  @override
  Widget build(BuildContext context) {
    _openTransactionFormModal() => showModalBottomSheet(
          context: context,
          builder: (_) => TransactionForm(_addTransaction),
        );

    final _add = Icon(Icons.add);

    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas'),
        actions: <Widget>[
          IconButton(
            icon: _add,
            onPressed: _openTransactionFormModal,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: Card(
                color: Colors.blue,
                child: Text('Gráfico'),
                elevation: 5,
              ),
            ),
            TransactionList(_transactions),
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
