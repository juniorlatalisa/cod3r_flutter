import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  final _format = DateFormat('d MMM y');

  _createCard(BuildContext context, Transaction tr) => Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FittedBox(
                child: Text('R\$${tr.value.toStringAsFixed(2)}'),
              ),
            ),
          ),
          title: Text(
            tr.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(_format.format(tr.date)),
        ),
      );

  // _createCard(BuildContext context, Transaction tr) => Card(
  //       child: Row(
  //         children: <Widget>[
  //           Container(
  //             margin: EdgeInsets.symmetric(
  //               horizontal: 15,
  //               vertical: 10,
  //             ),
  //             decoration: BoxDecoration(
  //               border: Border.all(
  //                 color: Theme.of(context).primaryColor,
  //                 width: 2,
  //               ),
  //             ),
  //             padding: EdgeInsets.all(10),
  //             child: Text(
  //               'R\$ ${tr.value.toStringAsFixed(2)}',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 color: Theme.of(context).primaryColor,
  //                 fontSize: 20,
  //               ),
  //             ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 tr.title,
  //                 style: Theme.of(context).textTheme.headline6,
  //               ),
  //               Text(
  //                 DateFormat('d MMM y').format(tr.date),
  //                 style: TextStyle(
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Column(
        children: <Widget>[
          Text(
            'Nenhuma transação cadastrada',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/images/waiting.png',
            height: MediaQuery.of(context).size.height / 2,
          )
        ],
      );
    }

    return Container(
      height: 300,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (ctx, index) => _createCard(context, transactions[index]),
      ),
    );
  }
}
