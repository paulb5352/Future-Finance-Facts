//System
import 'package:flutter/material.dart';
//Models
import '../models/list_tile_base.dart';
import '../models/account.dart';
import '../models/category.dart';
//Widgets
import '../widgets/list_Item_Row.dart';
//Screens
import './planned_transaction_screen.dart';
//Providers
import 'package:provider/provider.dart';
import '../providers/accounts_provider.dart';
import '../providers/categories_provider.dart';
import '../providers/recurrences_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/planned_transactions_provider.dart';


class PlannedTransactionsScreen extends StatefulWidget {
  static const routeName = 'PlannedTransactionsScreen';
  final bool dialog;
  

  PlannedTransactionsScreen([this.dialog]);

  @override
  _PlannedTransactionsScreenState createState() => _PlannedTransactionsScreenState();
}

class _PlannedTransactionsScreenState extends State<PlannedTransactionsScreen> {
  int sortType;
  AccountsProvider accountProv;
  CategoriesProvider categoryProv;
  var top = 0.0;

  Future<void> _refreshTransactions(BuildContext context, ) async {
    try{
      await Provider.of<PlannedTransactionProvider>(context).fetchAndSetTransactions(); 
      await Provider.of<SettingsProvider>(context, listen: false).fetchAndSetSettings(); 
      categoryProv = Provider.of<CategoriesProvider>(context, listen: false);
      await categoryProv.fetchAndSetCategories(); 
      accountProv = Provider.of<AccountsProvider>(context, listen: false);
      await accountProv.fetchAndSetAccounts();
      await Provider.of<RecurrencesProvider>(context, listen: false).fetchAndSetRecurrences();
    } catch(error){
      throw Exception('PlannedTransactionsScreen._refreshTransactions: ' + error.toString());
    }
  }

  String getSubtitle(int i){
    try{
      switch(sortType){
        case PlannedTransactionNames.byAccount:
          Account account = accountProv.items.firstWhere((account) => account.id == i);
          return account.accountName;
        case PlannedTransactionNames.byCategory:
          Category category = categoryProv.items.firstWhere((category) => category.id == i);
          return category.categoryName;
      }
    } catch(error){
      throw Exception('PlannedTransactionsScreen.getSubtitle: ' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
        body: FutureBuilder(
          future: _refreshTransactions(context),
          builder: (ctx, snapshot,) => 
          snapshot.connectionState == ConnectionState.waiting
          ?  Center(
            child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            onRefresh: () => _refreshTransactions(context),
            child: Consumer<PlannedTransactionProvider>(
              builder: (context, transactionData, _) => Padding(
                padding: EdgeInsets.all(8),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.black26,),
                      actions: <Widget>[                     
                        IconButton(
                          icon: Icon(Icons.add,),
                          onPressed: () {
                            Navigator.of(context).pushNamed(PlannedTransactionScreen.routeName);
                          },
                        ),
                        PopupMenuButton(
                          onSelected: (int byChosen){
                            switch(byChosen){
                              case PlannedTransactionNames.byAccount:
                                setState(() {
                                  sortType == PlannedTransactionNames.byAccount ? null : transactionData.sortTransactions(context, PlannedTransactionNames.byAccount);
                                  sortType = PlannedTransactionNames.byAccount;                            
                                });
                                break;
                              case PlannedTransactionNames.byCategory:
                                setState(() {
                                  sortType == PlannedTransactionNames.byCategory ? null : transactionData.sortTransactions(context, PlannedTransactionNames.byCategory);
                                  sortType = PlannedTransactionNames.byCategory;
                                });
                                break; 
                              case PlannedTransactionNames.byName:
                                setState(() {
                                  sortType == PlannedTransactionNames.byName ? null : transactionData.sortTransactions(context, PlannedTransactionNames.byName);
                                  sortType = PlannedTransactionNames.byName;
                                }); 
                                break;                                                                                  
                            }
                          },
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              child: Text('By Account'),
                              value: PlannedTransactionNames.byAccount,
                            ),
                            PopupMenuItem(
                              child: Text('By Category'),
                              value: PlannedTransactionNames.byCategory,
                            ),
                            PopupMenuItem(
                              child: Text('By Name'),
                              value: PlannedTransactionNames.byName,
                            ),                                    
                          ],                         
                        ),
                      ],
                      backgroundColor: Colors.white,
                      pinned: true,
                      expandedHeight: 260.0,                    
                      flexibleSpace: LayoutBuilder(
                        builder: (context, contraints){
                          top = contraints.biggest.height;
                            return FlexibleSpaceBar(
                            centerTitle: true,
                            title: Text('Planned Transactions', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),), 
                            background: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/transaction.jpg')),
                              ),
                            ),
                          );
                        },
                      )
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((_, i,){ 
                        return ListItemRow(ListTileBase(
                          id: transactionData.items[i].id, 
                          title: transactionData.items[i].title,
                          subtitile: sortType == PlannedTransactionNames.byName 
                          ? null 
                          : sortType == PlannedTransactionNames.byAccount 
                            ? getSubtitle(transactionData.items[i].accountId)
                            : getSubtitle(transactionData.items[i].categoryId), 
                          description: transactionData.items[i].description, 
                          routeName: transactionData.plannedTransactionRouteName, 
                          deleteRecord: transactionData.deleteTransaction, 
                          price: transactionData.items[i].amount, 
                          dialog: false
                          )
                        );                                                     
                      },
                      childCount: transactionData.items.length,             
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),            
        ),
      );
    } catch(error){
      throw Exception('PlannedTransactionsScreen.build: ' + error.toString());
    }
  }
}
