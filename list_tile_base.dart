class ListTileBase {
  final int id;
  final String title;
  final String description;
  final String routeName;
  final Function deleteRecord;
  final double price;
  final bool dialog;
  final String iconPath;
  final String subtitile;

  ListTileBase({this.id, this.title, this.description, this.routeName, this.deleteRecord, this.price = 0.0, this.iconPath, this.subtitile, this.dialog = false});

}