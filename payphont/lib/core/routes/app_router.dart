const String content = '''import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../modules/auth/views/pin_login_page.dart';
import '../../modules/auth/views/change_pin_page.dart';
import '../../modules/contacts/views/contact_list_page.dart';
import '../../modules/finance/views/finance_page.dart';
import '../../modules/finance/views/add_transaction_page.dart';
import '../../modules/dashboard/views/dashboard_page.dart';
import '../../modules/settings/views/settings_page.dart';
import '../../modules/reports/views/report_page.dart';
import '../../modules/media/views/media_page.dart';
import '../../modules/messaging/views/schedule_message_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => _slide(child: const PinLoginPage()),
      ),
      GoRoute(
        path: '/dashboard',
        pageBuilder: (context, state) => _slide(child: const DashboardPage()),
      ),
      GoRoute(
        path: '/contacts',
        pageBuilder: (context, state) => _slide(child: const ContactListPage()),
      ),
      GoRoute(
        path: '/finance',
        pageBuilder: (context, state) => _slide(child: const FinancePage()),
      ),
      GoRoute(
        path: '/add_transaction',
        pageBuilder: (context, state) => _slide(child: const AddTransactionPage()),
      ),
      GoRoute(
        path: '/reports',
        pageBuilder: (context, state) => _slide(child: const ReportPage()),
      ),
      GoRoute(
        path: '/media',
        pageBuilder: (context, state) => _slide(child: const MediaPage()),
      ),
      GoRoute(
        path: '/schedule_message',
        pageBuilder: (context, state) =>
            _slide(child: const ScheduleMessagePage()),
      ),
      GoRoute(
        path: '/settings',
        pageBuilder: (context, state) => _slide(child: const SettingsPage()),
      ),
      GoRoute(
        path: '/change_pin',
        pageBuilder: (context, state) => _slide(child: const ChangePinPage()),
      ),
    ],
  );

  static CustomTransitionPage _slide({required Widget child}) =>
      CustomTransitionPage<void>(
        child: child,
        transitionsBuilder: (_, animation, __, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
      );
}''';