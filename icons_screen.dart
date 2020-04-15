import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//Providers
import '../providers/categories_provider.dart';
import '../providers/recurrences_provider.dart';

class IconsScreen extends StatefulWidget {

  final bool  catOrRef;
  final String givenIconPath;
    
  IconsScreen({this.catOrRef, this.givenIconPath});

  @override
  _IconsScreenState createState() => _IconsScreenState();
}
  void _onTileClicked(BuildContext context, String iconPath){
    Navigator.pop(context, iconPath);
  } 
  List<Widget> _getTiles(BuildContext context, List<String> iconList) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < iconList.length; i++) {
      tiles.add(GridTile(
          child: InkResponse(
        enableFeedback: true,
        child: Image.asset(iconList[i], 
                fit: BoxFit.fitHeight,
                height: 10,        
        ),       
        onTap: () => _onTileClicked(context, iconList[i]),
      )));
    }
    return tiles;
  }
class _IconsScreenState extends State<IconsScreen> {

  
  @override
  Widget build(BuildContext context) {
    List<String> _imageList = [];

    widget.catOrRef == true 
    ? _imageList = Provider.of<CategoriesProvider>(context).imageList()
    : _imageList = Provider.of<RecurrencesProvider>(context).imageList();
    
    return Scaffold(
      appBar: AppBar(title: Text('Icons'),),
      body: GridView.count(
        crossAxisCount: 8,
        padding: EdgeInsets.all(5),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: _getTiles(context, _imageList),
      ),      
    );
  }
}