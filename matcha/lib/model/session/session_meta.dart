import 'package:freezed_annotation/freezed_annotation.dart';

part 'session_meta.freezed.dart';

@unfreezed
abstract class SessionMeta with _$SessionMeta {
  factory SessionMeta({
    //
    required int id,

    required String name,
  }) = _SessionMeta;
}
