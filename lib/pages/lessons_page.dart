import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/content_item.dart';
import '../state/mock_progress.dart';

class LessonsPage extends StatefulWidget {
  final MockProgress progress;
  const LessonsPage({super.key, required this.progress});

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  Stream<List<ContentItem>> streamLevel1() {
    return FirebaseFirestore.instance
        .collection('items')
        .where('track', isEqualTo: 'quran')
        .where('level', isEqualTo: 1)
        .snapshots()
        .map((snap) {
      final items = snap.docs
          .map((d) => ContentItem.fromMap(d.data()))
          .where((x) => x.id.isNotEmpty)
          .toList();

      // Sort: roots -> forms -> vocab, then alphabetically by display
      final order = {'root': 0, 'form': 1, 'vocab': 2};
      items.sort((a, b) {
        final oa = order[a.type] ?? 99;
        final ob = order[b.type] ?? 99;
        if (oa != ob) return oa.compareTo(ob);
        return a.displayAr.compareTo(b.displayAr);
      });

      return items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.progress,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Lessons (Level 1)')),
          body: StreamBuilder<List<ContentItem>>(
            stream: streamLevel1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              final items = snapshot.data ?? [];
              if (items.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No items found. Did you seed Level 1 to Firestore?',
                  ),
                );
              }

              final unlocked = items.where((item) {
                return widget.progress.isUnlocked(
                  type: item.type,
                  prerequisites: item.prerequisites,
                );
              }).toList();

              final locked = items.where((item) => !unlocked.contains(item)).toList();

              return ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  _sectionHeader(
                    title: 'Available Lessons',
                    subtitle:
                        'Roots & Forms are always available. Vocab unlocks when prerequisites are Guru.',
                    count: unlocked.length,
                  ),
                  const SizedBox(height: 8),
                  ...unlocked.map((item) => _itemTile(item, unlocked: true)),
                  const SizedBox(height: 18),
                  _sectionHeader(
                    title: 'Locked (Needs Guru prerequisites)',
                    subtitle:
                        'To simulate: toggle Guru on a root+form, then vocab unlocks.',
                    count: locked.length,
                  ),
                  const SizedBox(height: 8),
                  ...locked.map((item) => _itemTile(item, unlocked: false)),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _sectionHeader({
    required String title,
    required String subtitle,
    required int count,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title ($count)',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            Text(subtitle),
          ],
        ),
      ),
    );
  }

  Widget _itemTile(ContentItem item, {required bool unlocked}) {
    final isGuru = widget.progress.isGuru(item.id);
    final typeLabel = item.type.toUpperCase();

    return Card(
      child: ListTile(
        title: Text('${item.displayAr}  —  $typeLabel'),
        subtitle: item.prerequisites.isEmpty
            ? Text(item.mnemonic)
            : Text('Prereq: ${item.prerequisites.join(', ')}\n${item.mnemonic}'),
        trailing: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (item.type == 'root' || item.type == 'form')
              TextButton(
                onPressed: () => widget.progress.toggleGuru(item.id),
                child: Text(isGuru ? 'Guru ✅' : 'Mark Guru'),
              ),
            Icon(
              unlocked ? Icons.lock_open : Icons.lock,
              color: unlocked ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}