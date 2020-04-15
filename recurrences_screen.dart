//System
import 'package:flutter/material.dart';
//Models
import '../models/list_tile_base.dart';
//Widgets
import '../widgets/list_Item_Row.dart';
//Screens
import './recurrence_screen.dart';
//Providers
import 'package:provider/provider.dart';
import '../providers/recurrences_provider.dart';


class RecurrencesScreen extends StatelessWidget {
  static const routeName = 'RecurrencesScreen';
  final bool dialog;

  RecurrencesScreen([this.dialog]);

  Future<void> _refreshRecurrences(BuildContext context) async {
    try{
      await Provider.of<RecurrencesProvider>(context).fetchAndSetRecurrences();      
    } catch (error){
      throw Exception('RecurrencesScreen._refreshRecurrences: ' + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
        body: FutureBuilder(
          future: _refreshRecurrences(context),
          builder: (ctx, snapshot,) => 
          snapshot.connectionState == ConnectionState.waiting
          ?  Center(
            child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            onRefresh: () => _refreshRecurrences(context),
            child: Consumer<RecurrencesProvider>(
              builder: (context, recurrencesData, _) => Padding(
                padding: EdgeInsets.all(8),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.black26,),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add,),
                          onPressed: () {
                            Navigator.of(context).pushNamed(RecurrenceScreen.routeName);
                          },
                        ),              
                      ],
                      backgroundColor: Colors.white,
                      pinned: true,
                      expandedHeight: 280.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text('Recurrences', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),),
                        background: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/recurrence.jpg')),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((_, i,){ 
                        return ListItemRow(ListTileBase(id: recurrencesData.items[i].id, title: recurrencesData.items[i].title, description: recurrencesData.items[i].description, iconPath: recurrencesData.items[i].iconPath, routeName: recurrencesData.recurrenceRouteName, deleteRecord: recurrencesData.deleteRecurrence, dialog: dialog));                                                     
                      },
                      childCount: recurrencesData.items.length,             
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
      throw Exception('RecurrencesScreen.build: ' + error.toString());
    }
  }
}
