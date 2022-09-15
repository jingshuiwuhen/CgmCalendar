// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Never`
  String get repeat_type_none {
    return Intl.message(
      'Never',
      name: 'repeat_type_none',
      desc: '',
      args: [],
    );
  }

  /// `Every Day`
  String get repeat_type_every_day {
    return Intl.message(
      'Every Day',
      name: 'repeat_type_every_day',
      desc: '',
      args: [],
    );
  }

  /// `Every Week`
  String get repeat_type_every_week {
    return Intl.message(
      'Every Week',
      name: 'repeat_type_every_week',
      desc: '',
      args: [],
    );
  }

  /// `Every Month`
  String get repeat_type_every_month {
    return Intl.message(
      'Every Month',
      name: 'repeat_type_every_month',
      desc: '',
      args: [],
    );
  }

  /// `Personal`
  String get schedule_type_personal {
    return Intl.message(
      'Personal',
      name: 'schedule_type_personal',
      desc: '',
      args: [],
    );
  }

  /// `Work`
  String get schedule_type_work {
    return Intl.message(
      'Work',
      name: 'schedule_type_work',
      desc: '',
      args: [],
    );
  }

  /// `No Schedules`
  String get schedule_not_exist {
    return Intl.message(
      'No Schedules',
      name: 'schedule_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Mon`
  String get monday {
    return Intl.message(
      'Mon',
      name: 'monday',
      desc: '',
      args: [],
    );
  }

  /// `Tue`
  String get tuesday {
    return Intl.message(
      'Tue',
      name: 'tuesday',
      desc: '',
      args: [],
    );
  }

  /// `Wed`
  String get wedsday {
    return Intl.message(
      'Wed',
      name: 'wedsday',
      desc: '',
      args: [],
    );
  }

  /// `Thu`
  String get thursday {
    return Intl.message(
      'Thu',
      name: 'thursday',
      desc: '',
      args: [],
    );
  }

  /// `Fri`
  String get friday {
    return Intl.message(
      'Fri',
      name: 'friday',
      desc: '',
      args: [],
    );
  }

  /// `Sat`
  String get saturday {
    return Intl.message(
      'Sat',
      name: 'saturday',
      desc: '',
      args: [],
    );
  }

  /// `Sun`
  String get sunday {
    return Intl.message(
      'Sun',
      name: 'sunday',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `All Day`
  String get all_day {
    return Intl.message(
      'All Day',
      name: 'all_day',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Detail`
  String get schedule_detail {
    return Intl.message(
      'Schedule Detail',
      name: 'schedule_detail',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete Schedule`
  String get delete_schedule {
    return Intl.message(
      'Delete Schedule',
      name: 'delete_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Repeat`
  String get repeat {
    return Intl.message(
      'Repeat',
      name: 'repeat',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Until`
  String get repeat_until {
    return Intl.message(
      'Repeat Until',
      name: 'repeat_until',
      desc: '',
      args: [],
    );
  }

  /// `Never`
  String get repeat_until_none {
    return Intl.message(
      'Never',
      name: 'repeat_until_none',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message(
      'Type',
      name: 'type',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notes {
    return Intl.message(
      'Notes',
      name: 'notes',
      desc: '',
      args: [],
    );
  }

  /// `For this schedule only`
  String get for_this_schedule_only {
    return Intl.message(
      'For this schedule only',
      name: 'for_this_schedule_only',
      desc: '',
      args: [],
    );
  }

  /// `For future schedule`
  String get for_future_schedule {
    return Intl.message(
      'For future schedule',
      name: 'for_future_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete this schedule?`
  String get wish_to_delete {
    return Intl.message(
      'Are you sure to delete this schedule?',
      name: 'wish_to_delete',
      desc: '',
      args: [],
    );
  }

  /// `New Schedule`
  String get new_schedule {
    return Intl.message(
      'New Schedule',
      name: 'new_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Edit Schedule`
  String get edit_schedule {
    return Intl.message(
      'Edit Schedule',
      name: 'edit_schedule',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get Setting {
    return Intl.message(
      'Setting',
      name: 'Setting',
      desc: '',
      args: [],
    );
  }

  /// `Clear All Data`
  String get clear_all_data {
    return Intl.message(
      'Clear All Data',
      name: 'clear_all_data',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `System error. Please call to support.`
  String get system_error {
    return Intl.message(
      'System error. Please call to support.',
      name: 'system_error',
      desc: '',
      args: [],
    );
  }

  /// `Please login again`
  String get token_verify_failed {
    return Intl.message(
      'Please login again',
      name: 'token_verify_failed',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Verification Code`
  String get verification_code {
    return Intl.message(
      'Verification Code',
      name: 'verification_code',
      desc: '',
      args: [],
    );
  }

  /// `At least 6 digit password. Only number and letter`
  String get password {
    return Intl.message(
      'At least 6 digit password. Only number and letter',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Get Code`
  String get get_code {
    return Intl.message(
      'Get Code',
      name: 'get_code',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get second {
    return Intl.message(
      's',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `Please input email`
  String get input_email {
    return Intl.message(
      'Please input email',
      name: 'input_email',
      desc: '',
      args: [],
    );
  }

  /// `This is not email`
  String get not_email {
    return Intl.message(
      'This is not email',
      name: 'not_email',
      desc: '',
      args: [],
    );
  }

  /// `Email has ben registed`
  String get email_exist {
    return Intl.message(
      'Email has ben registed',
      name: 'email_exist',
      desc: '',
      args: [],
    );
  }

  /// `Please input password`
  String get input_password {
    return Intl.message(
      'Please input password',
      name: 'input_password',
      desc: '',
      args: [],
    );
  }

  /// `This is not password`
  String get not_password {
    return Intl.message(
      'This is not password',
      name: 'not_password',
      desc: '',
      args: [],
    );
  }

  /// `Please input verification code`
  String get input_verification_code {
    return Intl.message(
      'Please input verification code',
      name: 'input_verification_code',
      desc: '',
      args: [],
    );
  }

  /// `Verification code is not right`
  String get auth_code_wrong {
    return Intl.message(
      'Verification code is not right',
      name: 'auth_code_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Verification code has expired`
  String get auth_code_expired {
    return Intl.message(
      'Verification code has expired',
      name: 'auth_code_expired',
      desc: '',
      args: [],
    );
  }

  /// `Account is not existed`
  String get email_not_exist {
    return Intl.message(
      'Account is not existed',
      name: 'email_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `Password is not right`
  String get password_wrong {
    return Intl.message(
      'Password is not right',
      name: 'password_wrong',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
