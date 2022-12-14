import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_sec_since_epoch_converter/first_converter.dart';
import 'package:m_sec_since_epoch_converter/seconds_converter.dart';
import 'package:m_sec_since_epoch_converter/theme.dart';

final yearValueStateProvider = StateProvider<int>((ref) => DateTime.now().year);

final monthValueStateProvider =
    StateProvider<int>((ref) => DateTime.now().month);

final dayValueStateProvider = StateProvider<int>((ref) => DateTime.now().day);

final hourValueStateProvider = StateProvider<int>((ref) => DateTime.now().hour);

final minuteValueStateProvider =
    StateProvider<int>((ref) => DateTime.now().minute);

final enteredMSSEValueStateProvider = StateProvider<int>((ref) => 0);

final convertedValueStateProvider = StateProvider<int>((ref) => 0);

final convertedDateTECValueStateProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

final isConvertedCheckStateProvider = StateProvider<bool>((ref) => false);

final isPickWithCalendarStateProvider = StateProvider<bool>((ref) => false);

final isConvertFromDateModeStateProvider = StateProvider<bool>((ref) => true);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  void toggleTheme() {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    bool themeMode =
        ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.dark;
    bool convertFromDateMode = ref.watch(isConvertFromDateModeStateProvider);
    final maxWidth = MediaQuery.of(context).size.width;
    final maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                themeMode
                    ? const Icon(
                        Icons.mode_night_rounded,
                        size: 50,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.sunny,
                        size: 50,
                        color: Colors.red,
                      ),
                CupertinoSwitch(
                  value: themeMode,
                  onChanged: (value) => toggleTheme(),
                  activeColor: Colors.red,
                  trackColor: Colors.black87,
                ),
              ],
            ),
          ),
          if (convertFromDateMode)
            Expanded(
              child: FirstConverter(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              ),
            )
          else
            Expanded(
              child: SecondConverter(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
              ),
            ),
        ],
      ),
    );
  }
}
