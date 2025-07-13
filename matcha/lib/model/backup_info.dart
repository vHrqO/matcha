import 'package:freezed_annotation/freezed_annotation.dart';

part 'backup_info.freezed.dart';
part 'backup_info.g.dart';

@unfreezed
abstract class BackupInfo with _$BackupInfo {
  factory BackupInfo({
    //
    required String name,

    required String backupType,

    required DateTime saveTime,
  }) = _BackupInfo;

  factory BackupInfo.fromJson(Map<String, Object?> json) => _$BackupInfoFromJson(json);
}
