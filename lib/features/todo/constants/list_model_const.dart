enum ListType { title, icon, color }

enum ListItemType { title, note, completed }

class ListConstant {
  static const Map<ListType, String> listFormKeys = <ListType, String>{
    ListType.title: 'title',
    ListType.icon: 'icon',
    ListType.color: 'color',
  };
  static const Map<ListItemType, String> listItemFormKeys =
      <ListItemType, String>{
    ListItemType.title: 'title',
    ListItemType.note: 'note',
    ListItemType.completed: 'completed',
  };
}
