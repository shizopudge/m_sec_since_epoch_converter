import 'package:dart_date/dart_date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:m_sec_since_epoch_converter/home_page.dart';
import 'package:m_sec_since_epoch_converter/responsive.dart';
import 'package:m_sec_since_epoch_converter/theme.dart';

class FirstConverter extends ConsumerWidget {
  final double maxWidth;
  final double maxHeight;
  const FirstConverter({
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

    int daysInMonth = DateTime(yearValue, monthValue).getDaysInMonth - 1;
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
    TextEditingController convertedDateController = TextEditingController(
        text: ref.watch(convertedValueStateProvider).toString());
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
                        ref
                            .watch(isConvertFromDateModeStateProvider.notifier)
                            .state = false;
                      },
                      child: Icon(
                        Icons.switch_right_rounded,
                        size: 65,
                        color: themeMode ? Colors.red : Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'DATE ',
                          style: AppTheme.txtStyle1Dark
                              .copyWith(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'TO MILLISECONDS SINCE EPOCH CONVERTER',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (yearController.text.isNotEmpty) {
                                          ref
                                                  .read(yearValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(yearController.text);
                                          if (ref
                                                  .read(yearValueStateProvider
                                                      .notifier)
                                                  .state <
                                              9999) {
                                            ref
                                                .read(yearValueStateProvider
                                                    .notifier)
                                                .state++;
                                          }
                                        } else {
                                          ref
                                              .read(yearValueStateProvider
                                                  .notifier)
                                              .state = 0;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.add_circled_solid,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 125,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: TextFormField(
                                        showCursor: true,
                                        textAlign: TextAlign.center,
                                        controller: yearController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            yearValue = int.parse(value);
                                          } else {
                                            yearValue = 0;
                                          }
                                        },
                                        cursorColor: themeMode
                                            ? Colors.black
                                            : Colors.white,
                                        maxLength: 4,
                                        style: themeMode
                                            ? AppTheme.txtStyle2Light
                                            : AppTheme.txtStyle2Dark,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (yearController.text.isNotEmpty) {
                                          ref
                                                  .read(yearValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(yearController.text);
                                          if (ref
                                                  .read(yearValueStateProvider
                                                      .notifier)
                                                  .state >
                                              0) {
                                            ref
                                                .read(yearValueStateProvider
                                                    .notifier)
                                                .state--;
                                          }
                                        } else {
                                          ref
                                              .read(yearValueStateProvider
                                                  .notifier)
                                              .state = 0;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.minus_circle_fill,
                                        size: 36,
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (monthController.text.isNotEmpty) {
                                          ref
                                                  .read(monthValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(monthController.text);
                                          if (ref
                                                  .read(monthValueStateProvider
                                                      .notifier)
                                                  .state <
                                              12) {
                                            ref
                                                .read(monthValueStateProvider
                                                    .notifier)
                                                .state++;
                                            ref
                                                .read(dayValueStateProvider
                                                    .notifier)
                                                .state = 1;
                                          }
                                        } else {
                                          ref
                                              .read(monthValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                          ref
                                              .read(dayValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.add_circled_solid,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 125,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: TextFormField(
                                        showCursor: true,
                                        textAlign: TextAlign.center,
                                        controller: monthController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            if (newValue.text == '') {
                                              return newValue;
                                            }
                                            final i =
                                                int.tryParse(newValue.text);
                                            if (i == null) return oldValue;
                                            if (i > 12) {
                                              return newValue.copyWith(
                                                  text: '12',
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            if (i < 1) {
                                              return newValue.copyWith(
                                                  text: '1',
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            return newValue;
                                          })
                                        ],
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            monthValue = int.parse(value);
                                            ref
                                                .read(monthValueStateProvider
                                                    .notifier)
                                                .state = int.parse(value);

                                            ref
                                                .read(dayValueStateProvider
                                                    .notifier)
                                                .state = 1;
                                          } else {
                                            monthValue = 1;
                                          }
                                        },
                                        cursorColor: themeMode
                                            ? Colors.black
                                            : Colors.white,
                                        maxLength: 2,
                                        style: themeMode
                                            ? AppTheme.txtStyle2Light
                                            : AppTheme.txtStyle2Dark,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (monthController.text.isNotEmpty) {
                                          ref
                                                  .read(monthValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(monthController.text);
                                          if (ref
                                                  .read(monthValueStateProvider
                                                      .notifier)
                                                  .state >
                                              1) {
                                            ref
                                                .read(monthValueStateProvider
                                                    .notifier)
                                                .state--;
                                            ref
                                                .read(dayValueStateProvider
                                                    .notifier)
                                                .state = 1;
                                          }
                                        } else {
                                          ref
                                              .read(monthValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                          ref
                                              .read(dayValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.minus_circle_fill,
                                        size: 36,
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (dayController.text.isNotEmpty) {
                                          ref
                                                  .read(dayValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(dayController.text);
                                          if (ref
                                                  .read(dayValueStateProvider
                                                      .notifier)
                                                  .state <
                                              daysInMonth) {
                                            ref
                                                .read(dayValueStateProvider
                                                    .notifier)
                                                .state++;
                                          }
                                        } else {
                                          ref
                                              .read(dayValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.add_circled_solid,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 125,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: TextFormField(
                                        showCursor: true,
                                        textAlign: TextAlign.center,
                                        controller: dayController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            if (newValue.text == '') {
                                              return newValue;
                                            }
                                            final i =
                                                int.tryParse(newValue.text);
                                            if (i == null) return oldValue;
                                            if (i > daysInMonth) {
                                              return newValue.copyWith(
                                                  text: daysInMonth.toString(),
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            if (i < 1) {
                                              return newValue.copyWith(
                                                  text: '1',
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            return newValue;
                                          })
                                        ],
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            dayValue = int.parse(value);
                                          } else {
                                            dayValue = 1;
                                          }
                                        },
                                        cursorColor: themeMode
                                            ? Colors.black
                                            : Colors.white,
                                        maxLength: 2,
                                        style: themeMode
                                            ? AppTheme.txtStyle2Light
                                            : AppTheme.txtStyle2Dark,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (dayController.text.isNotEmpty) {
                                          ref
                                                  .read(dayValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(dayController.text);
                                          if (ref
                                                  .read(dayValueStateProvider
                                                      .notifier)
                                                  .state >
                                              1) {
                                            ref
                                                .read(dayValueStateProvider
                                                    .notifier)
                                                .state--;
                                          }
                                        } else {
                                          ref
                                              .read(dayValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.minus_circle_fill,
                                        size: 36,
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (hourController.text.isNotEmpty) {
                                          ref
                                                  .read(hourValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(hourController.text);
                                          if (ref
                                                  .read(hourValueStateProvider
                                                      .notifier)
                                                  .state <
                                              24) {
                                            ref
                                                .read(hourValueStateProvider
                                                    .notifier)
                                                .state++;
                                            ref
                                                .read(minuteValueStateProvider
                                                    .notifier)
                                                .state = 0;
                                          }
                                        } else {
                                          ref
                                              .read(hourValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.add_circled_solid,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 125,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: TextFormField(
                                        showCursor: true,
                                        textAlign: TextAlign.center,
                                        controller: hourController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            if (newValue.text == '') {
                                              return newValue;
                                            }
                                            final i =
                                                int.tryParse(newValue.text);
                                            if (i == null) return oldValue;
                                            if (i > 24) {
                                              return newValue.copyWith(
                                                  text: '24',
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            if (i < 1) {
                                              return newValue.copyWith(
                                                  text: '1',
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            return newValue;
                                          })
                                        ],
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            hourValue = int.parse(value);
                                            ref
                                                .read(hourValueStateProvider
                                                    .notifier)
                                                .state = int.parse(value);
                                            ref
                                                .read(minuteValueStateProvider
                                                    .notifier)
                                                .state = 0;
                                          } else {
                                            hourValue = 1;
                                          }
                                        },
                                        cursorColor: themeMode
                                            ? Colors.black
                                            : Colors.white,
                                        maxLength: 2,
                                        style: themeMode
                                            ? AppTheme.txtStyle2Light
                                            : AppTheme.txtStyle2Dark,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (hourController.text.isNotEmpty) {
                                          ref
                                                  .read(hourValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(hourController.text);
                                          if (ref
                                                  .read(hourValueStateProvider
                                                      .notifier)
                                                  .state >
                                              1) {
                                            ref
                                                .read(hourValueStateProvider
                                                    .notifier)
                                                .state--;
                                            ref
                                                .read(minuteValueStateProvider
                                                    .notifier)
                                                .state = 0;
                                          }
                                        } else {
                                          ref
                                              .read(hourValueStateProvider
                                                  .notifier)
                                              .state = 1;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.minus_circle_fill,
                                        size: 36,
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
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (minuteController.text.isNotEmpty) {
                                          ref
                                                  .read(minuteValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(minuteController.text);
                                          if (ref
                                                      .read(
                                                          minuteValueStateProvider
                                                              .notifier)
                                                      .state <
                                                  59 &&
                                              hourValue < 24) {
                                            ref
                                                .read(minuteValueStateProvider
                                                    .notifier)
                                                .state++;
                                          }
                                        } else {
                                          ref
                                              .read(minuteValueStateProvider
                                                  .notifier)
                                              .state = 0;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.add_circled_solid,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 125,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Center(
                                      child: TextFormField(
                                        showCursor: true,
                                        textAlign: TextAlign.center,
                                        controller: minuteController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            if (newValue.text == '') {
                                              return newValue;
                                            }
                                            final i =
                                                int.tryParse(newValue.text);
                                            if (i == null) return oldValue;
                                            if (i > 59) {
                                              return newValue.copyWith(
                                                  text: '59',
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            if (i < 0) {
                                              return newValue.copyWith(
                                                  text: '0',
                                                  selection: const TextSelection
                                                      .collapsed(offset: 2));
                                            }
                                            return newValue;
                                          })
                                        ],
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          counterText: '',
                                        ),
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            minuteValue = int.parse(value);
                                          } else {
                                            minuteValue = 0;
                                          }
                                        },
                                        cursorColor: themeMode
                                            ? Colors.black
                                            : Colors.white,
                                        maxLength: 2,
                                        style: themeMode
                                            ? AppTheme.txtStyle2Light
                                            : AppTheme.txtStyle2Dark,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(36),
                                      radius: 80,
                                      onTap: () {
                                        if (minuteController.text.isNotEmpty) {
                                          ref
                                                  .read(minuteValueStateProvider
                                                      .notifier)
                                                  .state =
                                              int.parse(minuteController.text);
                                          if (ref
                                                  .read(minuteValueStateProvider
                                                      .notifier)
                                                  .state >
                                              0) {
                                            ref
                                                .read(minuteValueStateProvider
                                                    .notifier)
                                                .state--;
                                          }
                                        } else {
                                          ref
                                              .read(minuteValueStateProvider
                                                  .notifier)
                                              .state = 0;
                                        }
                                      },
                                      child: const Icon(
                                        CupertinoIcons.minus_circle_fill,
                                        size: 36,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(isConvertedCheckStateProvider.notifier).state =
                            true;
                        ref.read(yearValueStateProvider.notifier).state =
                            yearValue;
                        ref.read(monthValueStateProvider.notifier).state =
                            monthValue;
                        ref.read(dayValueStateProvider.notifier).state =
                            dayValue;
                        ref.read(hourValueStateProvider.notifier).state =
                            hourValue;
                        ref.read(minuteValueStateProvider.notifier).state =
                            minuteValue;
                        ref.read(convertedValueStateProvider.notifier).state =
                            DateTime(yearValue, monthValue, dayValue, hourValue,
                                    minuteValue)
                                .millisecondsSinceEpoch;
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
                                      'DATE',
                                      style: AppTheme.txtStyle2Dark
                                          .copyWith(color: Colors.red),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: Container(
                                    width: 350,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(21),
                                      color: themeMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      controller: convertedDateController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                      readOnly: true,
                                      cursorColor: themeMode
                                          ? Colors.black
                                          : Colors.white,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
