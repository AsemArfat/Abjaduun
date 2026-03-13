import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'seed_level1.dart';

class DevToolsPage extends StatefulWidget {
  const DevToolsPage({super.key});

  @override
  State<DevToolsPage> createState() => _DevToolsPageState();
}

class _DevToolsPageState extends State<DevToolsPage> {
  String status = "Ready";

  Future<void> seed() async {
    setState(() => status = "Seeding Level 1...");
    try {
      await Level1Seeder.seed();
      setState(() => status = "✅ Seeded Level 1 successfully!");
    } catch (e) {
      setState(() => status = "❌ Error: $e");
    }
  }

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> fetchLevel1() async {
    final snap = await FirebaseFirestore.instance
        .collection('items')
        .where('level', isEqualTo: 1)
        .where('track', isEqualTo: 'quran')
        .get();

    final docs = snap.docs.toList();
    docs.sort((a, b) {
      final ta = (a.data()['type'] ?? '') as String;
      final tb = (b.data()['type'] ?? '') as String;
      if (ta != tb) return ta.compareTo(tb);
      final da = (a.data()['display_ar'] ?? '') as String;
      final db = (b.data()['display_ar'] ?? '') as String;
      return da.compareTo(db);
    });
    return docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dev Tools")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(status),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: seed,
              child: const Text("Seed Level 1 content to Firestore"),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: FutureBuilder(
                future: fetchLevel1(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                  final docs = snapshot.data ?? [];
                  if (docs.isEmpty) {
                    return const Text("No Level 1 items found yet. Click Seed.");
                  }
                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, i) {
                      final data = docs[i].data();
                      final type = data['type'] ?? '';
                      final ar = data['display_ar'] ?? '';
                      final prereq = (data['prerequisites'] as List?)?.join(', ') ?? '';
                      return ListTile(
                        title: Text("$ar  —  $type"),
                        subtitle: prereq.isEmpty ? null : Text("Prereq: $prereq"),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}