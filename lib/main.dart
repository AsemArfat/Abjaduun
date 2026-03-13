import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

// Pages / state
import 'dev/dev_tools_page.dart';
import 'pages/lessons_page.dart';
import 'state/mock_progress.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ArabicSrsApp());
}

/// Make the app Stateful so we keep one shared progress instance
/// (otherwise it can reset on rebuild).
class ArabicSrsApp extends StatefulWidget {
  const ArabicSrsApp({super.key});

  @override
  State<ArabicSrsApp> createState() => _ArabicSrsAppState();
}

class _ArabicSrsAppState extends State<ArabicSrsApp> {
  final MockProgress progress = MockProgress();

  late final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/lessons',
        builder: (context, state) => LessonsPage(progress: progress),
      ),
      GoRoute(
        path: '/dev',
        builder: (context, state) => const DevToolsPage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Qur’anic Arabic SRS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E7D32)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.menu_book, size: 64),
                const SizedBox(height: 12),
                const Text(
                  'Qur’anic Arabic, made structured.',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'WaniKani-style: Lessons + Reviews + unlocking.\n'
                  'Today: content pipeline (seed → lessons list).',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => context.go('/dashboard'),
                      icon: const Icon(Icons.dashboard),
                      label: const Text('Go to Dashboard'),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => context.go('/dev'),
                      icon: const Icon(Icons.build),
                      label: const Text('Dev Tools (Seed Content)'),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const Text(
                  'إن شاء الله we ship step by step.',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Qur’anic Arabic Dashboard',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),

                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.go('/lessons'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Column(
                            children: [
                              Text('Lessons', style: TextStyle(fontSize: 18)),
                              SizedBox(height: 6),
                              Text('Level 1', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Reviews coming next step 👀'),
                            ),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Column(
                            children: [
                              Text('Reviews', style: TextStyle(fontSize: 18)),
                              SizedBox(height: 6),
                              Text('Soon', style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Unlock Logic (WaniKani-style)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '• Roots + Forms are lesson-available\n'
                          '• Vocab unlocks when prerequisites are Guru\n'
                          '• Right now Guru is simulated (temporary)\n'
                          'Next step: real SRS stages + due reviews',
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.go('/dev'),
                  child: const Text('Dev Tools: Seed/Check Firestore content'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}