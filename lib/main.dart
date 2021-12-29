import 'dart:io';
import 'package:flutter/services.dart';

import './widgets/chart.dart';

import './widgets/transaction_list.dart';

import './widgets/new_transactions.dart';
import 'package:flutter/material.dart';

import './models/transaction.dart';

void main() {
 // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Quicksand",
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.blueGrey),
        textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(
                   color: Colors.blue 
              ),
              
              ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6:
                    const TextStyle(fontFamily: 'OpenSans', fontSize: 20),
              ),
        ),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  final List<Transaction> list = [];

  List<Transaction> get _resentData {
    return list.where((element) {
      return element.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _deletetransaction(String id){
    setState(() {
      list.removeWhere((element)=> element.id == id);  
    });
  }

  void _addTransaction(String title, double amount,DateTime? date) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date: date!,
      id: DateTime.now().toString(),
    );
    setState(() {
      list.add(newTx);
    });
  }

  _addUserTransactionDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(
            callback: _addTransaction,
          ),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
  
  bool _isShowChart = true; 
 
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void onDispose(){
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;
    var appBar = AppBar(
        title: const Text("Expense Details"),
        actions: <Widget>[
          IconButton(
              onPressed: () => _addUserTransactionDialog(context),
              icon: const Icon(Icons.add))
        ],
      );

    
    final containerlist = Container(
                      height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top)* 0.7,
                      child: list.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: mediaQuery.size.height * 0.1,
                                  child: Text(
                                    'No Data Found!',
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                ),
                                SizedBox(
                                  height: mediaQuery.size.height * 0.05,
                                ),
                                Container(
                                    height: mediaQuery.size.height * 0.3,
                                    child: Image.asset('assets/images/waiting.png'))
                              ],
                            ),
                          )
                        :
                        TransactionList(
                  list: list,
                   removetx: _deletetransaction,
                ),
                    );
        
    return Scaffold(
      appBar: appBar,
      body:Column(
        children: [
          if(isLandScape) ..._buildLandScape(mediaQuery,appBar,containerlist),
          if(!isLandScape) ..._buildPortrait(mediaQuery,appBar,containerlist),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS ?Container() : FloatingActionButton(
        onPressed: () => _addUserTransactionDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> _buildPortrait(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget containerlist,
  ){
    return [
      Container(height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,child: Chart(list: _resentData)),
      containerlist,
    ];
  }


  List<Widget> _buildLandScape(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget containerlist,
  ){
    return [
      Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Show Chart"),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: _isShowChart,
                onChanged: (value){
                  setState(() {
                      _isShowChart = value;  
                  });
                  
              },),
            ],
          ),
          _isShowChart ?
          Container(height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,child: Chart(list: _resentData)):
          containerlist
          
    ];
  }
}
