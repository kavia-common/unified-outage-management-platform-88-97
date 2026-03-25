import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:smart_outage_frontend/src/app.dart';
import 'package:smart_outage_frontend/src/data/database/app_database.dart';
import 'package:smart_outage_frontend/src/state/app_settings_provider.dart';
import 'package:smart_outage_frontend/src/state/auth_provider.dart';
import 'package:smart_outage_frontend/src/state/jobs_provider.dart';
import 'package:smart_outage_frontend/src/state/notifications_provider.dart';
import 'package:smart_outage_frontend/src/state/outages_provider.dart';

class _FakeDb extends AppDatabase {
  @override
  Future<void> init() async {}
}

void main() {
  testWidgets('AppRoot renders', (WidgetTester tester) async {
    // Ensure dotenv is loaded to match runtime initialization path.
    await dotenv.load(fileName: '.env');

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<AppDatabase>.value(value: _FakeDb()),
          ChangeNotifierProvider<AppSettingsProvider>(
            create: (_) => AppSettingsProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider<OutagesProvider>(
            create: (_) => OutagesProvider(database: _FakeDb()),
          ),
          ChangeNotifierProvider<JobsProvider>(
            create: (_) => JobsProvider(database: _FakeDb()),
          ),
          ChangeNotifierProvider<NotificationsProvider>(
            create: (_) => NotificationsProvider(database: _FakeDb()),
          ),
        ],
        child: const AppRoot(),
      ),
    );

    await tester.pump();
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('Ocean app title exists somewhere', (WidgetTester tester) async {
    await dotenv.load(fileName: '.env');

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<AppDatabase>.value(value: _FakeDb()),
          ChangeNotifierProvider<AppSettingsProvider>(
            create: (_) => AppSettingsProvider(),
          ),
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider<OutagesProvider>(
            create: (_) => OutagesProvider(database: _FakeDb()),
          ),
          ChangeNotifierProvider<JobsProvider>(
            create: (_) => JobsProvider(database: _FakeDb()),
          ),
          ChangeNotifierProvider<NotificationsProvider>(
            create: (_) => NotificationsProvider(database: _FakeDb()),
          ),
        ],
        child: const AppRoot(),
      ),
    );

    await tester.pump();
    expect(find.text('Smart Outage'), findsWidgets);
  });
}
