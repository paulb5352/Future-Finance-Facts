//System
import 'package:flutter/material.dart';
//Models
import '../models/list_tile_base.dart';
//Widgets
import '../widgets/list_Item_Row.dart';
//Screens
import './transfer_screen.dart';
//Providers
import 'package:provider/provider.dart';
import '../providers/transfers_provider.dart';


class TransfersScreen extends StatelessWidget {
  static const routeName = 'TransfersScreen';
  final bool dialog;

  TransfersScreen([this.dialog]);

  Future<void> _refreshTransfers(BuildContext context) async {
    try{
      await Provider.of<TransfersProvider>(context).fetchAndSetTransfers();
    } catch(error){
      throw Exception('TransfersScreen._refreshTransfers: ' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
        body: FutureBuilder(
          future: _refreshTransfers(context),
          builder: (ctx, snapshot,) => 
          snapshot.connectionState == ConnectionState.waiting
          ?  Center(
            child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            onRefresh: () => _refreshTransfers(context),
            child: Consumer<TransfersProvider>(
              builder: (context, transferData, _) => Padding(
                padding: EdgeInsets.all(8),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.black26,),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add,),
                          onPressed: () {
                            Navigator.of(context).pushNamed(TransferScreen.routeName);
                          },
                        ),              
                      ],
                      backgroundColor: Colors.white,
                      pinned: true,
                      expandedHeight: 280.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text('Transfers', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),),
                        background: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/transferD.png')),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((_, i,){ 
                        return ListItemRow(ListTileBase(id: transferData.items[i].id, title: transferData.items[i].title, description: transferData.items[i].description, price: transferData.items[i].amount, routeName: transferData.transferRouteName, deleteRecord: transferData.deleteTransaction, dialog: dialog ));                                                     
                      },
                      childCount: transferData.items.length,             
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
      throw Exception('TransfersScreen.build: ' + error.toString());
    }
  }
}
