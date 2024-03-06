import 'package:call_master/routes/router.dart';
import 'package:call_master/theme/theme.dart';
import 'package:flutter/material.dart';

class CallMasterApp extends StatelessWidget {
  const CallMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Master',
      theme: theme,
      routes: routes,
    );
  }
}
