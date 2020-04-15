import '../models/list_tile_base.dart';
import 'package:flutter/material.dart';
import './account_screen.dart';
import 'package:provider/provider.dart';
import '../providers/accounts_provider.dart';
import '../widgets/list_Item_Row.dart';

class AccountsScreen extends StatelessWidget {
  static const routeName = 'AccountsScreen';
  final bool dialog;

  AccountsScreen([this.dialog]);

  Future<void> _refreshAccounts(BuildContext context) async {
    try{
      await Provider.of<AccountsProvider>(context).fetchAndSetAccounts();     
    } catch (error){
      throw Exception('AccountsScreen._refreshAccounts: ' + error.toString());
    }
  }
  int numberChilderen(AccountsProvider data){
    if(data.items == null){
      data.fetchAndSetAccounts();
    }    
    return data.items.length;
  }

  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
        body: FutureBuilder(
          future: _refreshAccounts(context),
          builder: (ctx, snapshot,) => 
          snapshot.connectionState == ConnectionState.waiting
          ?  Center(
            child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            onRefresh: () => _refreshAccounts(context),
            child: Consumer<AccountsProvider>(
              builder: (context, accountsData, _) => Padding(
                padding: EdgeInsets.all(8),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.black26,),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add,),
                          onPressed: () {
                            Navigator.of(context).pushNamed(AccountScreen.routeName);
                          },
                        ),              
                      ],
                      backgroundColor: Colors.white,
                      pinned: true,
                      expandedHeight: 265.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text(
                          'Bank Accounts',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        background: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/strongboxA.png')),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((_, i,){                     
                        return ListItemRow(ListTileBase(
                          id: accountsData.items[i].id, 
                          title: accountsData.items[i].accountName, 
                          description: accountsData.items[i].description, 
                          routeName: accountsData.accountRouteName, 
                          deleteRecord: accountsData.deleteAccount, 
                          price: accountsData.items[i].balance,
                          dialog: dialog,
                          ),
                        );                                    
                      },
                      childCount: numberChilderen(accountsData),             
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),            
        ),
      );
    } catch (error){
      throw Exception(routeName + ': ' + error.toString());
    }
  }
}
