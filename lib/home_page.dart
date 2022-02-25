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
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => _startAddTx(context), icon: Icon(Icons.add))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddTx(context),
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Chart(_recentTransactions),
              TransactionList(_usertransactions, _deleteTransaction),
            ],
          ),
        ),
      ),
    );
  }
}
