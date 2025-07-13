import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:matcha/ui/widgets/settings/data/safety_backups.dart';
import 'package:matcha/ui/widgets/shared/loading_dialog.dart';
import 'package:matcha/view_model/settings/data_viewmodel.dart';

class DataSection extends StatelessWidget {
  const DataSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ImportTile(),

        ExportTile(),

        ExpansionTile(
          leading: Icon(Icons.info_outline),
          title: Text('Safety Backups'),
          children: [SafetyBackupsAction(), SafetyBackupsListRx()],
        ),
      ],
    );
  }
}

class ImportTile extends ConsumerWidget {
  const ImportTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(importExportDbProvider);

    return ListTile(
      leading: Icon(Icons.format_size),
      title: Text('Import from File'),
      subtitle: Text('Import from a database file'),
      trailing: OutlinedButton(
        onPressed: () async {
          showLoadingDialog(context, 'Importing...');

          await ref.read(importExportDbProvider.notifier).import();

          Navigator.of(context).pop(); // Close the loading dialog
        },
        child: Text('Import'),
      ),
    );
  }
}

class ExportTile extends ConsumerWidget {
  const ExportTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(importExportDbProvider);

    return ListTile(
      leading: Icon(Icons.format_size),
      title: Text('Export to File'),
      subtitle: Text('Export to a database file'),
      trailing: OutlinedButton(
        onPressed: () async {
          showLoadingDialog(context, 'Exporting...');

          await ref.read(importExportDbProvider.notifier).export();

          Navigator.of(context).pop(); // Close the loading dialog
        },
        child: Text('Export'),
      ),
    );
  }
}
