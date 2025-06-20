import 'package:matcha/mock_data/existing_tags.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_viewmodel.g.dart';

//
@riverpod
class DataState extends _$DataState {
  bool _isUpdated = true;

  @override
  bool build() {
    return _isUpdated;
  }

  void stateHasChanged() {
    _isUpdated = false;

    state = _isUpdated;
  }

  void completeUpdate() {
    _isUpdated = true;

    state = _isUpdated;
  }
}

@riverpod
Future<List<String>> existingTags(Ref ref) async {
  // read from database
  // no need to database , if save sussessful,
  // next time will read from database
  final tags = mockExistingTags;

  return tags;
}
