//System
import 'package:flutter/material.dart';
//Models
import '../models/list_tile_base.dart';
//Widgets
import '../widgets/list_Item_Row.dart';
//Screens
import './category_screen.dart';
//Providers
import 'package:provider/provider.dart';
import '../providers/categories_provider.dart';


class CategoriesScreen extends StatelessWidget {
  static const routeName = 'CategoriesScreen';
  final bool dialog;

  CategoriesScreen([this.dialog]);

  Future<void> _refreshCategories(BuildContext context, ) async {
    try{
      await Provider.of<CategoriesProvider>(context).fetchAndSetCategories();
    } catch (error){
      throw Exception('CategoriesScreen._refreshCategories: ' + error.toString());
    }      
  }

  @override
  Widget build(BuildContext context) {
    try{
      return Scaffold(
        body: FutureBuilder(
          future: _refreshCategories(context),
          builder: (ctx, snapshot,) => 
          snapshot.connectionState == ConnectionState.waiting
          ?  Center(
            child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
            onRefresh: () => _refreshCategories(context),
            child: Consumer<CategoriesProvider>(
              builder: (context, catData, _) => Padding(
                padding: EdgeInsets.all(8),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      iconTheme: IconThemeData(color: Colors.black26,),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.add,),
                          onPressed: () {
                            Navigator.of(context).pushNamed(CategoryScreen.routeName);
                          },
                        ),              
                      ],
                      backgroundColor: Colors.white,
                      pinned: true,
                      expandedHeight: 240.0,
                      flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        title: Text('Categories', style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),),
                        background: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/category.jpg')),
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate((_, i,){ 
                        return ListItemRow(ListTileBase(id: catData.items[i].id, title: catData.items[i].categoryName, description: catData.items[i].description, iconPath:catData.items[i].iconPath, routeName: catData.categoryRouteName, deleteRecord: catData.deleteCategory, dialog: dialog));                                                     
                      },
                      childCount: catData.items.length,             
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
      throw Exception('CategoriesScreen.build: ' + error.toString());
    }
  }
}
