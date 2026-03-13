class ContentItem {
  final String id;
  final String type; // root, form, vocab
  final int level;
  final String track; // quran
  final String displayAr;
  final List<String> answers;
  final List<String> prerequisites;
  final String mnemonic;
  final String notes;
  final List<String> tags;

  ContentItem({
    required this.id,
    required this.type,
    required this.level,
    required this.track,
    required this.displayAr,
    required this.answers,
    required this.prerequisites,
    required this.mnemonic,
    required this.notes,
    required this.tags,
  });

  factory ContentItem.fromMap(Map<String, dynamic> data) {
    return ContentItem(
      id: (data['id'] ?? '') as String,
      type: (data['type'] ?? '') as String,
      level: (data['level'] ?? 0) as int,
      track: (data['track'] ?? '') as String,
      displayAr: (data['display_ar'] ?? '') as String,
      answers: List<String>.from((data['answers'] ?? const <String>[]) as List),
      prerequisites:
          List<String>.from((data['prerequisites'] ?? const <String>[]) as List),
      mnemonic: (data['mnemonic'] ?? '') as String,
      notes: (data['notes'] ?? '') as String,
      tags: List<String>.from((data['tags'] ?? const <String>[]) as List),
    );
  }
}