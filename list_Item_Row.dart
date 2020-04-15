import '../models/list_tile_base.dart';
import 'package:flutter/material.dart';
import '../widgets/circle_price.dart';
import '../widgets/icon_list_image.dart';
import 'package:flutter/services.dart';
import '../settings/help/help_common.dart';

class ListItemRow extends StatelessWidget {
  final ListTileBase _ab;

  ListItemRow(this._ab);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(_ab.title),
          subtitle: _ab.subtitile == null ? null : Text(_ab.subtitile, style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.black38),),
          leading: _ab.price != null && _ab.price != 0.0
              ? CirclePrice(price: _ab.price)
              : _ab.iconPath == null ? null : IconListImage(_ab.iconPath),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  color: HC.clbk,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(_ab.routeName, arguments: _ab);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: HC.cltx,
                  onPressed: () async {
                    try {
                      await _ab.deleteRecord(context, _ab.id);
                    } catch (error) {
                      var output = error.toString();
                      Clipboard.setData(new ClipboardData(text: output));
                      scaffold.showSnackBar(SnackBar(content: Text('Deleting failed: Error copied to the clipboard'), duration: Duration(seconds: 8),));                          
                    }
                  },
                ),
              ],
            ),
          ),
          onTap: () {
            if (_ab.dialog != null && _ab.dialog) {
              Navigator.pop(context, _ab.id);
            }
          },
        ),
        Divider(thickness: 1,),
      ],
    );
  }
}
