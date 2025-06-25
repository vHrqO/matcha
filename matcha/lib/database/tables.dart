import 'package:drift/drift.dart';

// CREATE TABLE Session (
//     id INTEGER PRIMARY KEY,
//     name TEXT NOT NULL
// );
//
class Session extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

// CREATE TABLE TabsItem (
//     id INTEGER PRIMARY KEY,
//     session_id INTEGER NOT NULL,

//     is_group BOOLEAN NOT NULL DEFAULT false,

//     tabs_item_type TEXT NOT NULL,
//     title TEXT NOT NULL,

//     FOREIGN KEY (session_id) REFERENCES Session(id) ON DELETE CASCADE,

//     CHECK (tabs_item_type IN ('app', 'browser'))
// );
//
class TabsItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId =>
      integer().references(Session, #id, onDelete: KeyAction.cascade)();

  BoolColumn get isGroup => boolean().clientDefault(() => false)();

  TextColumn get tabsItemType => text().check(tabsItemType.isIn(['app', 'browser']))();

  TextColumn get title => text()();
}

// CREATE TABLE TabGroup (
//     id INTEGER PRIMARY KEY,

//     FOREIGN KEY (id) REFERENCES TabsItem(id) ON DELETE CASCADE
// );
class TabGroup extends Table {
  IntColumn get id => integer().autoIncrement().references(
    TabsItem,
    #id,
    onDelete: KeyAction.cascade,
  )();
}

// CREATE TABLE Tab (
//     id INTEGER PRIMARY KEY,
//     group_id INTEGER,
//
//     url TEXT NOT NULL,
//
//     FOREIGN KEY (id) REFERENCES TabsItem(id) ON DELETE CASCADE,
//     FOREIGN KEY (group_id) REFERENCES TabGroup(id) ON DELETE CASCADE
// );
//
class Tab extends Table {
  IntColumn get id => integer().autoIncrement().references(
    TabsItem,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get group_id =>
      integer().references(TabGroup, #id, onDelete: KeyAction.cascade)();

  TextColumn get url => text()();
}

// CREATE TABLE TabsItemTag (
//     id INTEGER PRIMARY KEY,
//     tabs_item_id INTEGER NOT NULL,
//     tag TEXT NOT NULL,

//     FOREIGN KEY (tabs_item_id) REFERENCES TabsItem(id) ON DELETE CASCADE
//     UNIQUE (tabs_item_id, tag)
// );
class TabsItemTag extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tabs_item_id =>
      integer().references(TabsItem, #id, onDelete: KeyAction.cascade)();

  TextColumn get tag => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
        {tabs_item_id, tag}
      ];
}
