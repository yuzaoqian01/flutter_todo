import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LangePage extends StatefulWidget {
  const LangePage({super.key});

  @override
  State<LangePage> createState() => _LangePageState();
}

class _LangePageState extends State<LangePage> {
  final Map<String, String> _localizedValues = {
    'en': 'English',
    'zh': '中文',
    'es': '西班牙语',
  };
  String _currentLanguage = 'en';
  void _changeLanguage(String languageCode) {
    setState(() {
      _currentLanguage = languageCode;
    });
  }
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.helloWorld)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('语言测试'),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: _currentLanguage,
              items: _localizedValues.keys.map((String key) {
                return DropdownMenuItem<String>(
                  value: key,
                  child: Text(_localizedValues[key]!),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  _changeLanguage(newValue);  
                }
              },
            ),
            Localizations.override(
              context: context,
              locale:  Locale(_currentLanguage),
              child: Builder(
                builder: (context) {
                  return Column(
                    children: [
                      Text('自定义语言'),
                      Text(AppLocalizations.of(context)!.helloWorld),
                      const SizedBox(height: 20),
                      Text('当前语言: ${_localizedValues[_currentLanguage]}'),
                      CalendarDatePicker(
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                        onDateChanged: (value) {},
                      ),
                    ],
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