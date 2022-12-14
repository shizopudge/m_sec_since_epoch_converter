import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_sec_since_epoch_converter/home_page.dart';
import 'package:m_sec_since_epoch_converter/responsive.dart';
import 'package:m_sec_since_epoch_converter/theme.dart';

class SecondConverter extends ConsumerWidget {
  final double maxWidth;
  final double maxHeight;
  const SecondConverter({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool themeMode =
        ref.watch(themeNotifierProvider.notifier).mode == ThemeMode.dark;
    int yearValue = ref.watch(yearValueStateProvider);
    int monthValue = ref.watch(monthValueStateProvider);
    int dayValue = ref.watch(dayValueStateProvider);
    int hourValue = ref.watch(hourValueStateProvider);
    int minuteValue = ref.watch(minuteValueStateProvider);
    int enteredMSSEValue = ref.watch(enteredMSSEValueStateProvider);
    TextEditingController yearController =
        TextEditingController(text: yearValue.toString());
    TextEditingController monthController =
        TextEditingController(text: monthValue.toString());
    TextEditingController dayController =
        TextEditingController(text: dayValue.toString());
    TextEditingController hourController =
        TextEditingController(text: hourValue.toString());
    TextEditingController minuteController =
        TextEditingController(text: minuteValue.toString());
    TextEditingController enteredMSSEController = TextEditingController(
        text: ref.watch(enteredMSSEValueStateProvider).toString());
    TextEditingController convertedMSSEController = TextEditingController(
      text: dateFormat.format(
        ref.watch(convertedDateTECValueStateProvider),
      ),
    );
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0.0);
    return Responsive(
      maxWidth: maxWidth,
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.bottom,
        controller: scrollController,
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    InkWell(
                      radius: 12,
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        ref.invalidate(yearValueStateProvider);
                        ref.invalidate(monthValueStateProvider);
                        ref.invalidate(dayValueStateProvider);
                        ref.invalidate(hourValueStateProvider);
                        ref.invalidate(minuteValueStateProvider);
                        ref.invalidate(isConvertedCheckStateProvider);
                        ref.invalidate(enteredMSSEValueStateProvider);
                        ref
                            .watch(isConvertFromDateModeStateProvider.notifier)
                            .state = true;
                      },
                      child: Icon(
                        Icons.switch_left_rounded,
                        size: 65,
                        color: themeMode ? Colors.red : Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'MILLISECONDS SINCE EPOCH ',
                          style: AppTheme.txtStyle1Dark
                              .copyWith(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'TO DATE CONVERTER',
                          style: themeMode
                              ? AppTheme.txtStyle1Dark
                              : AppTheme.txtStyle1Light,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            radius: 21,
                            borderRadius: BorderRadius.circular(21),
                            onTap: () {
                              ref.invalidate(yearValueStateProvider);
                              ref.invalidate(monthValueStateProvider);
                              ref.invalidate(dayValueStateProvider);
                              ref.invalidate(hourValueStateProvider);
                              ref.invalidate(minuteValueStateProvider);
                              ref.invalidate(enteredMSSEValueStateProvider);
                              ref.invalidate(isConvertedCheckStateProvider);
                            },
                            child: const Icon(
                              Icons.change_circle,
                              size: 50,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        width: 750,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          color: themeMode ? Colors.white : Colors.black,
                        ),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                          ),
                          controller: enteredMSSEController,
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              enteredMSSEValue = int.parse(value);
                            } else {
                              enteredMSSEValue = 0;
                              ref
                                  .read(enteredMSSEValueStateProvider.notifier)
                                  .state = 0;
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              if (newValue.text == '') {
                                return newValue;
                              }
                              final i = int.tryParse(newValue.text);
                              if (i == null) return oldValue;
                              if (i > 864000000000000) {
                                return newValue.copyWith(
                                    text: '864000000000000',
                                    selection: const TextSelection.collapsed(
                                        offset: 2));
                              }
                              if (i < 0) {
                                return newValue.copyWith(
                                    text: '0',
                                    selection: const TextSelection.collapsed(
                                        offset: 2));
                              }
                              return newValue;
                            })
                          ],
                          cursorColor: themeMode ? Colors.black : Colors.white,
                          style: themeMode
                              ? AppTheme.txtStyle3Light
                              : AppTheme.txtStyle3Dark,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(isConvertedCheckStateProvider.notifier).state =
                            true;
                        ref.read(enteredMSSEValueStateProvider.notifier).state =
                            enteredMSSEValue;
                        ref.read(yearValueStateProvider.notifier).state =
                            DateTime.fromMillisecondsSinceEpoch(
                                    enteredMSSEValue)
                                .year;
                        ref.read(monthValueStateProvider.notifier).state =
                            DateTime.fromMillisecondsSinceEpoch(
                                    enteredMSSEValue)
                                .month;
                        ref.read(dayValueStateProvider.notifier).state =
                            DateTime.fromMillisecondsSinceEpoch(
                                    enteredMSSEValue)
                                .day;
                        ref.read(hourValueStateProvider.notifier).state =
                            DateTime.fromMillisecondsSinceEpoch(
                                    enteredMSSEValue)
                                .hour;
                        ref.read(minuteValueStateProvider.notifier).state =
                            DateTime.fromMillisecondsSinceEpoch(
                                    enteredMSSEValue)
                                .minute;

                        ref
                                .read(convertedDateTECValueStateProvider.notifier)
                                .state =
                            DateTime.fromMillisecondsSinceEpoch(
                                enteredMSSEValue);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            themeMode ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        foregroundColor: themeMode ? Colors.red : Colors.white,
                        maximumSize: const Size(225, 90),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CONVERT',
                            style: themeMode
                                ? AppTheme.txtStyle3Light
                                : AppTheme.txtStyle3Dark,
                          ),
                          const Icon(
                            Icons.compare_arrows_rounded,
                            color: Colors.red,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                    ref.watch(isConvertedCheckStateProvider)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'CONVERTED ',
                                      style: themeMode
                                          ? AppTheme.txtStyle2Dark
                                          : AppTheme.txtStyle2Light,
                                    ),
                                    Text(
                                      'MILLISECONDS SINCE EPOCH',
                                      style: AppTheme.txtStyle2Dark
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'YEAR',
                                            style: themeMode
                                                ? AppTheme.txtStyle3Dark
                                                : AppTheme.txtStyle3Light,
                                          ),
                                          Container(
                                            width: 125,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(21),
                                              color: themeMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                            child: Center(
                                              child: TextFormField(
                                                showCursor: false,
                                                readOnly: true,
                                                textAlign: TextAlign.center,
                                                controller: yearController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                ),
                                                maxLength: 4,
                                                style: themeMode
                                                    ? AppTheme.txtStyle2Light
                                                    : AppTheme.txtStyle2Dark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'MONTH',
                                            style: themeMode
                                                ? AppTheme.txtStyle3Dark
                                                : AppTheme.txtStyle3Light,
                                          ),
                                          Container(
                                            width: 125,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(21),
                                              color: themeMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                            child: Center(
                                              child: TextFormField(
                                                showCursor: false,
                                                readOnly: true,
                                                textAlign: TextAlign.center,
                                                controller: monthController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                ),
                                                style: themeMode
                                                    ? AppTheme.txtStyle2Light
                                                    : AppTheme.txtStyle2Dark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'DAY',
                                            style: themeMode
                                                ? AppTheme.txtStyle3Dark
                                                : AppTheme.txtStyle3Light,
                                          ),
                                          Container(
                                            width: 125,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(21),
                                              color: themeMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                            child: Center(
                                              child: TextFormField(
                                                showCursor: false,
                                                readOnly: true,
                                                textAlign: TextAlign.center,
                                                controller: dayController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                ),
                                                maxLength: 2,
                                                style: themeMode
                                                    ? AppTheme.txtStyle2Light
                                                    : AppTheme.txtStyle2Dark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'HOUR',
                                            style: themeMode
                                                ? AppTheme.txtStyle3Dark
                                                : AppTheme.txtStyle3Light,
                                          ),
                                          Container(
                                            width: 125,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(21),
                                              color: themeMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                            child: Center(
                                              child: TextFormField(
                                                showCursor: false,
                                                readOnly: true,
                                                textAlign: TextAlign.center,
                                                controller: hourController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                ),
                                                maxLength: 2,
                                                style: themeMode
                                                    ? AppTheme.txtStyle2Light
                                                    : AppTheme.txtStyle2Dark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'MINUTE',
                                            style: themeMode
                                                ? AppTheme.txtStyle3Dark
                                                : AppTheme.txtStyle3Light,
                                          ),
                                          Container(
                                            width: 125,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(21),
                                              color: themeMode
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            padding: const EdgeInsets.all(12),
                                            child: Center(
                                              child: TextFormField(
                                                showCursor: false,
                                                readOnly: true,
                                                textAlign: TextAlign.center,
                                                controller: minuteController,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  counterText: '',
                                                ),
                                                maxLength: 2,
                                                style: themeMode
                                                    ? AppTheme.txtStyle2Light
                                                    : AppTheme.txtStyle2Dark,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Container(
                                    width: 750,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: convertedMSSEController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                      readOnly: true,
                                      style: themeMode
                                          ? AppTheme.txtStyle3Light
                                          : AppTheme.txtStyle3Dark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
