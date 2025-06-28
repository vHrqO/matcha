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

    for (final session in mockSessionList1) {
      await ref.read(sessionListRepoProvider.notifier).add(session.name);
    }

    print('Finished - addMockSessionList');
    // link.close();
  }
}
