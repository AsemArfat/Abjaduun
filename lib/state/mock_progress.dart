import 'package:flutter/foundation.dart';

class MockProgress extends ChangeNotifier {
  /// Items considered “Guru” (mastered enough to unlock dependents)
  final Set<String> guruIds = {};

  bool isGuru(String id) => guruIds.contains(id);

  void toggleGuru(String id) {
    if (guruIds.contains(id)) {
      guruIds.remove(id);
    } else {
      guruIds.add(id);
    }
    notifyListeners();
  }

  /// WaniKani-style unlock rule:
  /// - roots/forms: always lesson-available
  /// - vocab: unlocked only if ALL prerequisites are Guru
  bool isUnlocked({
    required String type,
    required List<String> prerequisites,
  }) {
    if (type == 'root' || type == 'form') return true;
    if (type == 'vocab') {
      return prerequisites.every((p) => guruIds.contains(p));
    }
    return false;
  }
}