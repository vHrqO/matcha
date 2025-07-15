import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:matcha/ui/widgets/shared/loading_dialog.dart';
import 'package:matcha/view_model/settings/data_viewmodel.dart';

class SafetyBackupsAction extends ConsumerWidget {
  const SafetyBackupsAction({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: [
        OutlinedButton(
          onPressed: () async {
            ref.invalidate(safetyBackupsListProvider);
          },
          child: Text('Refresh'),
        ),
        OutlinedButton(
          onPressed: () async {
            showLoadingDialog(context, 'Creating backup...');

            await ref
                .read(safetyBackupsListProvider.notifier)
                .addBackup(isManual: true);

            Navigator.of(context).pop(); // Close the loading dialog
          },
          child: Text('Backup Now'),
        ),
        OutlinedButton(
          onPressed: () async {
            showLoadingDialog(context, 'Clearing all backups...');

            await ref.read(safetyBackupsListProvider.notifier).deleteAllBackup();

            Navigator.of(context).pop(); // Close the loading dialog
          },
          child: Text('Clear All'),
        ),
      ],
    );
  }
}

class SafetyBackupsListRx extends ConsumerWidget {
  const SafetyBackupsListRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final backupsAsync = ref.watch(safetyBackupsListProvider);

    switch (backupsAsync) {
      case AsyncData(value: final backups):
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: backups
              .map(
                (backup) => SafetyBackupTile(
                  title: backup.saveTime.toLocal().toString(),
                  subtitle: backup.backupType,
                  onSave: () async {
                    showLoadingDialog(context, 'Saving backup...');

                    await ref
                        .read(safetyBackupsListProvider.notifier)
                        .saveBackup(backup);

                    Navigator.of(context).pop(); // Close the loading dialog
                  },
                  onRestore: () async {
                    showLoadingDialog(context, 'Restoring backup...');

                    await ref
                        .read(safetyBackupsListProvider.notifier)
                        .restoreBackup(backup);

                    Navigator.of(context).pop(); // Close the loading dialog
                  },
                  onDelete: () async {
                    showLoadingDialog(context, 'Deleting backup...');

                    await ref
                        .read(safetyBackupsListProvider.notifier)
                        .deleteBackup(backup);

                    Navigator.of(context).pop(); // Close the loading dialog
                  },
                ),
              )
              .toList(),
        );

      default:
        return Skeletonizer(
          child: SafetyBackupTile(title: 'Backup name', subtitle: 'date here'),
        );
    }
  }
}

class SafetyBackupTile extends StatelessWidget {
  const SafetyBackupTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.onSave,
    this.onRestore,
    this.onDelete,
  });

  final String title;
  final String subtitle;

  final VoidCallback? onSave;
  final VoidCallback? onRestore;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          OutlinedButton.icon(
            icon: Icon(Icons.save),
            label: Text('Save'),
            onPressed: onSave,
          ),
          OutlinedButton.icon(
            icon: Icon(Icons.restore),
            label: Text('Restore'),
            onPressed: onRestore,
          ),
          OutlinedButton.icon(
            icon: Icon(Icons.delete),
            label: Text('Delete'),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
