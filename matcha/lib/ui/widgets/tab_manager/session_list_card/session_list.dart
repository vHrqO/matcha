import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:matcha/app/constants.dart';
import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/mock_data/session_list.dart';
import 'package:matcha/view_model/tab_manager/session_list_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

class SessionListRx extends ConsumerWidget {
  const SessionListRx({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortedSessionListAsync = ref.watch(sortedSessionListProvider);

    switch (sortedSessionListAsync) {
      case AsyncData(value: final List<SessionMeta> sessionList):
      case AsyncLoading(value: final List<SessionMeta> sessionList):
        if (sessionList.isEmpty) {
          return const Text('No sessions available.');
        } else {
          return SessionList(sessionList);
        }

      case AsyncError(error: final error, stackTrace: final stackTrace):
        // to_do: use notification
        return Text('Oops, something unexpected happened: $error');

      default:
        return Skeletonizer(child: SessionList(mockSessionList));
    }
  }
}

class SessionList extends ConsumerStatefulWidget {
  const SessionList(this.sessionList, {super.key});

  final List<SessionMeta> sessionList;

  @override
  ConsumerState<SessionList> createState() => _SessionsListState();
}

class _SessionsListState extends ConsumerState<SessionList> {
  @override
  Widget build(BuildContext context) {
    // if selectedSessionId is null, use default
    final int selectedSessionId =
        ref.watch(selectedSessionIdProvider).value ?? widget.sessionList[0].id;

    final sessionListSortOrder = ref.watch(sessionListSortOrderProvider);

    return ReorderableListView.builder(
      buildDefaultDragHandles: false,
      itemCount: widget.sessionList.length,
      itemBuilder: (context, index) {
        return ReorderableDelayedDragStartListener(
          key: ObjectKey(widget.sessionList[index]),
          enabled: sessionListSortOrder == SortOrder.custom,
          index: index,

          child: ListTile(
            dense: true,
            leading: const Icon(FluentIcons.library_24_regular),
            title: Text(widget.sessionList[index].name),
            selected: widget.sessionList[index].id == selectedSessionId,
            // to_do: ui modify?
            // selectedTileColor: Colors.grey.withValues(alpha: 0.5),
            onTap: () {
              setState(() {
                ref
                    .read(selectedSessionIdProvider.notifier)
                    .updateSelected(widget.sessionList[index].id);
              });
            },
          ),
        );
      },

      onReorder: (int oldIndex, int newIndex) async {
        setState(() {
          // The newIndex provided by Flutter is the index after the target item.
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = widget.sessionList.removeAt(oldIndex);
          widget.sessionList.insert(newIndex, item);
        });

        await ref.read(sessionListProvider.notifier).reorder(oldIndex, newIndex);
      },
    );
  }
}
