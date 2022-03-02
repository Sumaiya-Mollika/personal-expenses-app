import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/new_transaction.dart';

import './models/transection.dart';
import './widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _usertransactions = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 1000, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'New Watch', amount: 1000.99, date: DateTime.now()),
    // Transaction(
    //     id: 't3',
    //     title: 'Weekly Groceries',
    //     amount: 500.50,
    //     date: DateTime.now()),
    // Transaction(id: 't4', title: 'Medcine', amount: 700, date: DateTime.now()),
  ];

  bool _showChart = false;
  List<Transaction> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double tXAmount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: tXAmount,
        date: chosenDate);

    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _startAddTx(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text('Personal Expenses'),
      centerTitle: true,
      actions: [
        IconButton(onPressed: () => _startAddTx(context), icon: Icon(Icons.add))
      ],
    );
    final txListWidget = Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_usertransactions, _deleteTransaction));

    return Scaffold(
      appBar: appbar,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTx(context),
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_isLandscape)
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Show Chart',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  Switch(
                    activeColor: Theme.of(context).colorScheme.secondary,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ]),
              if (!_isLandscape)
                Container(
                    height: (mediaQuery.size.height -
                            appbar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(_recentTransactions)),
              if (!_isLandscape) txListWidget,
              if (_isLandscape)
                _showChart
                    ? Container(
                        height: (mediaQuery.size.height -
                                appbar.preferredSize.height -
                                mediaQuery.padding.top) *
                            0.7,
                        child: Chart(_recentTransactions))
                    : txListWidget,
            ],
          ),
        ),
      ),
    );
  }
}
