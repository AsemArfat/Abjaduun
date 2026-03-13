import 'package:cloud_firestore/cloud_firestore.dart';

class Level1Seeder {
  static Future<void> seed() async {
    final db = FirebaseFirestore.instance;

    // Collection name where we store all content items
    final col = db.collection('items');

    // Level 1 content (roots, forms, vocab) — based on what we generated earlier
    final items = <Map<String, dynamic>>[
      // ---- ROOTS ----
      {
        "id": "root_ktb",
        "type": "root",
        "level": 1,
        "track": "quran",
        "display_ar": "كتب",
        "answers": ["كتب", "ktb"],
        "prerequisites": [],
        "mnemonic": "Theme: writing/recording (meaning can be added later).",
        "notes": "Optional fallback accepts ktb.",
        "tags": ["root", "level1"]
      },
      {
        "id": "root_qwl",
        "type": "root",
        "level": 1,
        "track": "quran",
        "display_ar": "قول",
        "answers": ["قول", "qwl"],
        "prerequisites": [],
        "mnemonic": "Theme: saying/speech (meaning later).",
        "notes": "Optional fallback qwl.",
        "tags": ["root", "level1"]
      },
      {
        "id": "root_alm",
        "type": "root",
        "level": 1,
        "track": "quran",
        "display_ar": "علم",
        "answers": ["علم", "alm", "3lm"],
        "prerequisites": [],
        "mnemonic": "Theme: knowledge/knowing (meaning later).",
        "notes": "Optional fallback: 3lm for ع.",
        "tags": ["root", "level1"]
      },
      {
        "id": "root_amn",
        "type": "root",
        "level": 1,
        "track": "quran",
        "display_ar": "امن",
        "answers": ["امن", "amn"],
        "prerequisites": [],
        "mnemonic": "Theme: belief/trust/safety (meaning later).",
        "notes": "Later: آمن/يؤمن/إيمان.",
        "tags": ["root", "level1"]
      },
      {
        "id": "root_aml",
        "type": "root",
        "level": 1,
        "track": "quran",
        "display_ar": "عمل",
        "answers": ["عمل", "aml"],
        "prerequisites": [],
        "mnemonic": "Theme: doing/acting (meaning later).",
        "notes": "Later: عمل/يعمل/عملًا.",
        "tags": ["root", "level1"]
      },

      // ---- FORMS ----
      {
        "id": "form_I_past",
        "type": "form",
        "level": 1,
        "track": "quran",
        "display_ar": "فَعَلَ",
        "answers": ["fa3ala", "fa'ala"],
        "prerequisites": [],
        "mnemonic": "Pattern: basic past verb template (Form I).",
        "notes": "Used to unlock vocab.",
        "tags": ["form", "level1"]
      },
      {
        "id": "form_I_imperfect",
        "type": "form",
        "level": 1,
        "track": "quran",
        "display_ar": "يَفْعَلُ",
        "answers": ["yaf3alu", "yaf'alu"],
        "prerequisites": [],
        "mnemonic": "Pattern: basic present/imperfect template (Form I).",
        "notes": "Used for يكتب/يقول/يعلم/يعمل.",
        "tags": ["form", "level1"]
      },
      {
        "id": "form_masdar_basic",
        "type": "form",
        "level": 1,
        "track": "quran",
        "display_ar": "فِعْل",
        "answers": ["fi3l", "fi'l"],
        "prerequisites": [],
        "mnemonic": "Pattern: simple masdar starter (verbal noun).",
        "notes": "Used for عِلْم / قَوْل / عَمَل style nouns.",
        "tags": ["form", "level1"]
      },

      // ---- VOCAB (unlock concept: root + form) ----
      {
        "id": "v_qala",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "قَالَ",
        "answers": ["قال", "qala"],
        "prerequisites": ["root_qwl", "form_I_past"],
        "mnemonic": "Read it: قَا + لَ (long ā + la).",
        "notes": "Answer by typing قال (no harakat). Optional qala.",
        "tags": ["vocab", "level1", "qwl"]
      },
      {
        "id": "v_yaqulu",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "يَقُولُ",
        "answers": ["يقول", "yaqulu"],
        "prerequisites": ["root_qwl", "form_I_imperfect"],
        "mnemonic": "يَ + قُو + لُ (u + long ū).",
        "notes": "Answer: يقول. Optional yaqulu.",
        "tags": ["vocab", "level1", "qwl"]
      },
      {
        "id": "v_qawl",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "قَوْل",
        "answers": ["قول", "qawl"],
        "prerequisites": ["root_qwl", "form_masdar_basic"],
        "mnemonic": "وْ makes 'aw' sound here: qawl.",
        "notes": "Answer: قول. Optional qawl.",
        "tags": ["vocab", "level1", "qwl"]
      },

      {
        "id": "v_kataba",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "كَتَبَ",
        "answers": ["كتب", "kataba"],
        "prerequisites": ["root_ktb", "form_I_past"],
        "mnemonic": "Short a vowels: ka-ta-ba.",
        "notes": "Answer: كتب. Optional kataba.",
        "tags": ["vocab", "level1", "ktb"]
      },
      {
        "id": "v_yaktubu",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "يَكْتُبُ",
        "answers": ["يكتب", "yaktubu"],
        "prerequisites": ["root_ktb", "form_I_imperfect"],
        "mnemonic": "يَ + كْ + تُ + بُ (cluster + u).",
        "notes": "Answer: يكتب. Optional yaktubu.",
        "tags": ["vocab", "level1", "ktb"]
      },
      {
        "id": "v_kitab",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "كِتَاب",
        "answers": ["كتاب", "kitab"],
        "prerequisites": ["root_ktb", "form_masdar_basic"],
        "mnemonic": "Long ā at the end: ki-tāb.",
        "notes": "Answer: كتاب. Optional kitab.",
        "tags": ["vocab", "level1", "ktb"]
      },

      {
        "id": "v_alima",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "عَلِمَ",
        "answers": ["علم", "alima", "3alima"],
        "prerequisites": ["root_alm", "form_I_past"],
        "mnemonic": "عَ + لِ + مَ (a-i-a).",
        "notes": "Answer: علم. Optional 3alima.",
        "tags": ["vocab", "level1", "alm"]
      },
      {
        "id": "v_yalamu",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "يَعْلَمُ",
        "answers": ["يعلم", "ya3lamu", "ya'lamu"],
        "prerequisites": ["root_alm", "form_I_imperfect"],
        "mnemonic": "يَ + عْ + لَ + مُ (cluster then a-u).",
        "notes": "Answer: يعلم. Optional ya3lamu.",
        "tags": ["vocab", "level1", "alm"]
      },
      {
        "id": "v_ilm",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "عِلْم",
        "answers": ["علم", "ilm", "3ilm"],
        "prerequisites": ["root_alm", "form_masdar_basic"],
        "mnemonic": "Kasra under ع gives 'i': ʿilm.",
        "notes": "Answer: علم (same letters). Optional 3ilm.",
        "tags": ["vocab", "level1", "alm"]
      },

      {
        "id": "v_amana",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "آمَنَ",
        "answers": ["امن", "آمن", "amana", "aamana"],
        "prerequisites": ["root_amn", "form_I_past"],
        "mnemonic": "Long ā at start: ā-ma-na.",
        "notes": "Answer: آمن or امن depending on keyboard. Optional aamana.",
        "tags": ["vocab", "level1", "amn"]
      },
      {
        "id": "v_yuminu",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "يُؤْمِنُ",
        "answers": ["يؤمن", "yuminu", "yu'minu"],
        "prerequisites": ["root_amn", "form_I_imperfect"],
        "mnemonic": "Hamza + sukun cluster: yu’minu.",
        "notes": "Answer: يؤمن. Optional yuminu.",
        "tags": ["vocab", "level1", "amn"]
      },
      {
        "id": "v_iman",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "إِيمَان",
        "answers": ["ايمان", "إيمان", "iman", "iiman"],
        "prerequisites": ["root_amn", "form_masdar_basic"],
        "mnemonic": "Long ī: ī-mān.",
        "notes": "Answer: ايمان/إيمان. Optional iman.",
        "tags": ["vocab", "level1", "amn"]
      },

      {
        "id": "v_amila",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "عَمِلَ",
        "answers": ["عمل", "amila", "3amila"],
        "prerequisites": ["root_aml", "form_I_past"],
        "mnemonic": "عَ + مِ + لَ (a-i-a).",
        "notes": "Answer: عمل. Optional 3amila.",
        "tags": ["vocab", "level1", "aml"]
      },
      {
        "id": "v_yamalu",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "يَعْمَلُ",
        "answers": ["يعمل", "ya3malu", "ya'malu"],
        "prerequisites": ["root_aml", "form_I_imperfect"],
        "mnemonic": "Cluster عْ then a-u: yaʿmalu.",
        "notes": "Answer: يعمل. Optional ya3malu.",
        "tags": ["vocab", "level1", "aml"]
      },
      {
        "id": "v_amal",
        "type": "vocab",
        "level": 1,
        "track": "quran",
        "display_ar": "عَمَل",
        "answers": ["عمل", "amal", "3amal"],
        "prerequisites": ["root_aml", "form_masdar_basic"],
        "mnemonic": "Short vowels: ʿa-mal.",
        "notes": "Answer: عمل. Optional 3amal.",
        "tags": ["vocab", "level1", "aml"]
      },
    ];

    // Batch write for speed
    final batch = db.batch();
    for (final item in items) {
      final docId = item["id"] as String;
      batch.set(col.doc(docId), item, SetOptions(merge: true));
    }

    // Optional: store a tiny metadata doc
    batch.set(
      db.collection('meta').doc('content'),
      {
        "updatedAt": FieldValue.serverTimestamp(),
        "version": 1,
        "notes": "Level 1 seed (roots/forms/vocab) uploaded from app."
      },
      SetOptions(merge: true),
    );

    await batch.commit();
  }
}