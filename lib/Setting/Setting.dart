import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:m_finder/main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  void dispose() {
    themeManager.removeListener(themelistener);
    super.dispose();
  }

  @override
  void initState() {
    themeManager.addListener(themelistener);
    super.initState();
  }

  themelistener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Switch(
              value: themeManager.themeMode == ThemeMode.dark,
              onChanged: (newValue) {
                themeManager.toggleTheme(newValue);
              })),
    );
  }
}
