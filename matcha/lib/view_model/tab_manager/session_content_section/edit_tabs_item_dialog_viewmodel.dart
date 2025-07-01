import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';

part 'edit_tabs_item_dialog_viewmodel.g.dart';

@riverpod
class EditTabForm extends _$EditTabForm {
  late int _sessionId;
  matcha_tab.Tab? _tab;

  bool _isValidated = false;
  String _title = '';
  String _url = '';
  List<String> _tagList = [];

  @override
  bool build({required int sessionId, matcha_tab.Tab? tab}) {
    _sessionId = sessionId;

    // edit not add
    if (tab != null) {
      _tab = tab;
      _title = tab.title;
      _url = tab.url;
      _tagList = tab.tagList;
    }

    return _isValidated;
  }

  void setTitle(String title) {
    _title = title;

    _validate();
    state = _isValidated;
  }

  void setUrl(String url) {
    _url = url;

    _validate();
    state = _isValidated;
  }

  void setTagList(List<String> tags) {
    _tagList = tags;

    _validate();
    state = _isValidated;
  }

  void save() async {
    if (!_isValidated) {
      throw Exception('EditTabForm is not valid');
    }

    //
    if (_tab == null) {
      // add new tab

      // tmp , use repository to get from database
      // final tabId = DateTime.now().millisecondsSinceEpoch;

      final newTab = matcha_tab.Tab(
        id: -1,
        type: TabsItemType.app,
        title: _title,
        url: _url,
        tagList: _tagList,
      );

      await ref
          .read(sessionContentProvider(_sessionId).notifier)
          .updateTabsItem(newTab);
    } else {
      // update existing tab
      _tab!.title = _title;
      _tab!.url = _url;
      _tab!.tagList = _tagList;

      await ref.read(sessionContentProvider(_sessionId).notifier).updateTabsItem(_tab!);
    }
  }

  void _validate() {
    // tagList can be empty
    _isValidated = _title.isNotEmpty && _url.isNotEmpty;
  }
}

@riverpod
class EditTabGroupForm extends _$EditTabGroupForm {
  late int _sessionId;
  matcha_tab_group.TabGroup? _tabGroup;

  bool _isValidated = false;
  String _tabGroupTitle = '';
  List<String> _tagList = [];

  @override
  bool build({required int sessionId, matcha_tab_group.TabGroup? tabGroup}) {
    _sessionId = sessionId;

    // edit not add
    if (tabGroup != null) {
      _tabGroup = tabGroup;
      _tabGroupTitle = tabGroup.title;
      _tagList = tabGroup.tagList;
    }

    return _isValidated;
  }

  void setTitle(String title) {
    _tabGroupTitle = title;

    _validate();
    state = _isValidated;
  }

  void setTagList(List<String> tags) {
    _tagList = tags;

    _validate();
    state = _isValidated;
  }

  void save() async {
    if (!_isValidated) {
      throw Exception('EditTabGroupForm is not valid');
    }

    //
    if (_tabGroup == null) {
      // add new tab group

      // tmp , use repository to get from database
      // final tabId = DateTime.now().millisecondsSinceEpoch;

      final newTabGroup = matcha_tab_group.TabGroup(
        id: -1,
        type: TabsItemType.app,
        title: _tabGroupTitle,
        tabList: [],
        tagList: _tagList,
      );

      await ref
          .read(sessionContentProvider(_sessionId).notifier)
          .updateTabsItem(newTabGroup);
    } else {
      // update existing tab
      _tabGroup!.title = _tabGroupTitle;
      _tabGroup!.tagList = _tagList;

      await ref
          .read(sessionContentProvider(_sessionId).notifier)
          .updateTabsItem(_tabGroup!);
    }
  }

  void _validate() {
    // tagList can be empty
    _isValidated = _tabGroupTitle.isNotEmpty;
  }
}
