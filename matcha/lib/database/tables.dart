import 'package:drift/drift.dart';

/// Note: By default, Drift translates Dart names to snake_case in SQL

class Session extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get position => integer().unique()();

  TextColumn get name => text()();
}

class TabsItem extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get sessionId =>
      integer().references(Session, #id, onDelete: KeyAction.cascade)();
  IntColumn get position => integer()();

  BoolColumn get isGroup => boolean().clientDefault(() => false)();

  TextColumn get title => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {sessionId, position},
  ];
}

class TabGroup extends Table {
  IntColumn get id => integer().autoIncrement().references(
    TabsItem,
    #id,
    onDelete: KeyAction.cascade,
  )();
}

class Tab extends Table {
  IntColumn get id => integer().autoIncrement().references(
    TabsItem,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get groupId =>
      integer().nullable().references(TabGroup, #id, onDelete: KeyAction.cascade)();

  IntColumn get position => integer().nullable().check(
    // If in group, must have position
    // If not in group, position must be NULL
    groupId.isNull().equalsExp(position.isNull()),
  )();

  TextColumn get url => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {groupId, position},
  ];
}

class TabsItemTag extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get tabsItemId =>
      integer().references(TabsItem, #id, onDelete: KeyAction.cascade)();

  TextColumn get tag => text()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {tabsItemId, tag},
  ];
}
