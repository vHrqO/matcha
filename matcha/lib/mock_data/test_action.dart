import 'package:matcha/mock_data/session.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/repository/session_repo.dart';
import 'package:matcha/view_model/shared/database_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/mock_data/session_list.dart';
import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/repository/session_list_repo.dart';

part 'test_action.g.dart';

//
@riverpod
class TestAction extends _$TestAction {
  @override
  Future<void> build() async {
    // This is just a placeholder
  }

  Future<void> addMockSessionList() async {
    // final link =  ref.keepAlive();
    print('Start - addMockSessionList');

    // use viewmodel

    for (final session in mockSessionList1) {
      await ref.read(sessionListRepoProvider.notifier).add(session.name);
    }

    print('Finished - addMockSessionList');
    // link.close();
  }

  Future<void> addPartMockTabsItem() async {
    // final link =  ref.keepAlive();
    print('Start - addPartMockTabsItem');

    final sessionId = 1;
    

    final need_tab = mockSession1.tabsItemList[0];
    await ref.watch(sessionContentProvider(sessionId).notifier).updateTabsItem(need_tab);

    final need_group = mockSession1.tabsItemList[2];
    await ref.watch(sessionContentProvider(sessionId).notifier).updateTabsItem(need_group);

    final need_tabin =
        (mockSession1.tabsItemList[2] as matcha_tab_group.TabGroup).tabList[0];
    await ref.watch(sessionContentProvider(sessionId).notifier).updateTabsItem(need_tabin);

    print('Finished - addPartMockTabsItem');
    // link.close();
  }


  Future<void> custom() async {
    // final link =  ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    // final result = await tabDb.testQuery().get();
    // for (var element in result) {
    //   print(element);
    // }
    


    // link.close();
  }
}
