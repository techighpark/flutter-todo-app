enum ListType { id, title, icon, color, createdAt }

enum ListItemType { id, title, note, completed, createdAt }

class ListConstant {
  static const Map<ListType, String> listFormKeys = <ListType, String>{
    ListType.id: 'id',
    ListType.title: 'title',
    ListType.icon: 'icon',
    ListType.color: 'color',
    ListType.createdAt: 'createdAt',
  };

  static const Map<ListItemType, String> listItemFormKeys =
      <ListItemType, String>{
    ListItemType.id: 'id',
    ListItemType.title: 'title',
    ListItemType.note: 'note',
    ListItemType.completed: 'completed',
    ListItemType.createdAt: 'createdAt',
  };
}
