import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/model/session/session.dart';

part 'edit_session_dialog_viewmodel.g.dart';

@riverpod
class EditSessionForm extends _$EditSessionForm {
  late Session _session;

  bool _isValidated = false;
  String _sessionName = '';

  @override
  bool build(Session session) {
    _session = session;
    _sessionName = session.name;

    return _isValidated;
  }

  void setSessionName(String name) {
    _sessionName = name;

    _isValidated = _sessionName.isNotEmpty;

    state = _isValidated;
  }

  void save() async {
    if (!_isValidated) {
      throw Exception('EditSessionForm is not valid');
    }

    await ref
        .read(sessionContentProvider(_session.id).notifier)
        .updateSessionName(_sessionName);
  }
}
