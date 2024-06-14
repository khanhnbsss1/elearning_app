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

  /// `aa`
  String get app_name {
    return Intl.message(
      'aa',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred!`
  String get notify_error {
    return Intl.message(
      'An error occurred!',
      name: 'notify_error',
      desc: '',
      args: [],
    );
  }

  /// `Username or password is incorrect`
  String get authen_invalid {
    return Intl.message(
      'Username or password is incorrect',
      name: 'authen_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get appcept {
    return Intl.message(
      'Accept',
      name: 'appcept',
      desc: '',
      args: [],
    );
  }

  /// `Processing, please wait...`
  String get loading_message {
    return Intl.message(
      'Processing, please wait...',
      name: 'loading_message',
      desc: '',
      args: [],
    );
  }

  /// `Hide and show items`
  String get show_hide_items {
    return Intl.message(
      'Hide and show items',
      name: 'show_hide_items',
      desc: '',
      args: [],
    );
  }

  /// `Size settings`
  String get size_settings {
    return Intl.message(
      'Size settings',
      name: 'size_settings',
      desc: '',
      args: [],
    );
  }

  /// `Sort List`
  String get sort_list {
    return Intl.message(
      'Sort List',
      name: 'sort_list',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Tracking`
  String get vehicle_tracking {
    return Intl.message(
      'Vehicle Tracking',
      name: 'vehicle_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Save account`
  String get save_account {
    return Intl.message(
      'Save account',
      name: 'save_account',
      desc: '',
      args: [],
    );
  }

  /// `Or sign in with`
  String get sign_in_with {
    return Intl.message(
      'Or sign in with',
      name: 'sign_in_with',
      desc: '',
      args: [],
    );
  }

  /// `You don't have an account yet?`
  String get you_do_not_have_an_account {
    return Intl.message(
      'You don\'t have an account yet?',
      name: 'you_do_not_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message(
      'Sign in',
      name: 'sign_in',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get more {
    return Intl.message(
      'More',
      name: 'more',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Your address`
  String get your_address {
    return Intl.message(
      'Your address',
      name: 'your_address',
      desc: '',
      args: [],
    );
  }

  /// `Do you have an account?`
  String get you_do_have_an_account {
    return Intl.message(
      'Do you have an account?',
      name: 'you_do_have_an_account',
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

  /// `Login name`
  String get user_name {
    return Intl.message(
      'Login name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language_text {
    return Intl.message(
      'Language',
      name: 'language_text',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english_text {
    return Intl.message(
      'English',
      name: 'english_text',
      desc: '',
      args: [],
    );
  }

  /// `Vietnamese`
  String get viet_nam_text {
    return Intl.message(
      'Vietnamese',
      name: 'viet_nam_text',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account_text {
    return Intl.message(
      'Account',
      name: 'account_text',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number_text {
    return Intl.message(
      'Phone number',
      name: 'phone_number_text',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get sign_out_text {
    return Intl.message(
      'Sign out',
      name: 'sign_out_text',
      desc: '',
      args: [],
    );
  }

  /// `Security`
  String get security_text {
    return Intl.message(
      'Security',
      name: 'security_text',
      desc: '',
      args: [],
    );
  }

  /// `Use fingerprint`
  String get use_fingerprint_text {
    return Intl.message(
      'Use fingerprint',
      name: 'use_fingerprint_text',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password_text {
    return Intl.message(
      'Change password',
      name: 'change_password_text',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get terms_of_service_text {
    return Intl.message(
      'Terms of Service',
      name: 'terms_of_service_text',
      desc: '',
      args: [],
    );
  }

  /// `Open source licenses`
  String get open_source_licenses_text {
    return Intl.message(
      'Open source licenses',
      name: 'open_source_licenses_text',
      desc: '',
      args: [],
    );
  }

  /// `Minute`
  String get time_in_minute_str {
    return Intl.message(
      'Minute',
      name: 'time_in_minute_str',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get time_in_hour_str {
    return Intl.message(
      'Hour',
      name: 'time_in_hour_str',
      desc: '',
      args: [],
    );
  }

  /// `Day`
  String get time_in_day_str {
    return Intl.message(
      'Day',
      name: 'time_in_day_str',
      desc: '',
      args: [],
    );
  }

  /// `Month`
  String get time_in_month_str {
    return Intl.message(
      'Month',
      name: 'time_in_month_str',
      desc: '',
      args: [],
    );
  }

  /// `Year`
  String get time_in_year_str {
    return Intl.message(
      'Year',
      name: 'time_in_year_str',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get time_in_second_str {
    return Intl.message(
      'Seconds',
      name: 'time_in_second_str',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get string_next {
    return Intl.message(
      'Next',
      name: 'string_next',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get string_back {
    return Intl.message(
      'Back',
      name: 'string_back',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get string_cancel {
    return Intl.message(
      'Cancel',
      name: 'string_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get string_done {
    return Intl.message(
      'Done',
      name: 'string_done',
      desc: '',
      args: [],
    );
  }

  /// `Time setting`
  String get string_time_setting {
    return Intl.message(
      'Time setting',
      name: 'string_time_setting',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get string_begin_time {
    return Intl.message(
      'Start',
      name: 'string_begin_time',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get string_end_time {
    return Intl.message(
      'End',
      name: 'string_end_time',
      desc: '',
      args: [],
    );
  }

  /// `FFTSolution - Copyright 2022`
  String get copy_right {
    return Intl.message(
      'FFTSolution - Copyright 2022',
      name: 'copy_right',
      desc: '',
      args: [],
    );
  }

  /// `News`
  String get string_newest {
    return Intl.message(
      'News',
      name: 'string_newest',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get string_notify {
    return Intl.message(
      'Notification',
      name: 'string_notify',
      desc: '',
      args: [],
    );
  }

  /// `Hotline`
  String get string_hotline {
    return Intl.message(
      'Hotline',
      name: 'string_hotline',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get string_payment {
    return Intl.message(
      'Payment',
      name: 'string_payment',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get string_info {
    return Intl.message(
      'Information',
      name: 'string_info',
      desc: '',
      args: [],
    );
  }

  /// `No notification`
  String get string_have_not_notify {
    return Intl.message(
      'No notification',
      name: 'string_have_not_notify',
      desc: '',
      args: [],
    );
  }

  /// `No older data`
  String get string_no_more_old_data {
    return Intl.message(
      'No older data',
      name: 'string_no_more_old_data',
      desc: '',
      args: [],
    );
  }

  /// `Agree`
  String get str_accept {
    return Intl.message(
      'Agree',
      name: 'str_accept',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get str_cancel {
    return Intl.message(
      'Cancel',
      name: 'str_cancel',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_search_result {
    return Intl.message(
      'No data',
      name: 'no_search_result',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notify_lable {
    return Intl.message(
      'Notification',
      name: 'notify_lable',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get button_close {
    return Intl.message(
      'Close',
      name: 'button_close',
      desc: '',
      args: [],
    );
  }

  /// `Verify your fingerprint to log in`
  String get header_popup_fingerprint {
    return Intl.message(
      'Verify your fingerprint to log in',
      name: 'header_popup_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Authenticate your biometrics to log in`
  String get header_popup_biometric {
    return Intl.message(
      'Authenticate your biometrics to log in',
      name: 'header_popup_biometric',
      desc: '',
      args: [],
    );
  }

  /// `Login with fingerprint`
  String get title_popup_fingerprint {
    return Intl.message(
      'Login with fingerprint',
      name: 'title_popup_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Log in with biometrics`
  String get title_popup_biometric {
    return Intl.message(
      'Log in with biometrics',
      name: 'title_popup_biometric',
      desc: '',
      args: [],
    );
  }

  /// `Login with face`
  String get title_popup_faceid {
    return Intl.message(
      'Login with face',
      name: 'title_popup_faceid',
      desc: '',
      args: [],
    );
  }

  /// `You have not set up face login. Please log in to your account with a password and set up face authentication`
  String get notify_setup_faceid {
    return Intl.message(
      'You have not set up face login. Please log in to your account with a password and set up face authentication',
      name: 'notify_setup_faceid',
      desc: '',
      args: [],
    );
  }

  /// `You have not set up fingerprint login. Please log in to your account with a password and set up fingerprint authentication`
  String get notify_setup_fingerprint {
    return Intl.message(
      'You have not set up fingerprint login. Please log in to your account with a password and set up fingerprint authentication',
      name: 'notify_setup_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date_str {
    return Intl.message(
      'Date',
      name: 'date_str',
      desc: '',
      args: [],
    );
  }

  /// `Create new`
  String get re_create {
    return Intl.message(
      'Create new',
      name: 're_create',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get str_update {
    return Intl.message(
      'Update',
      name: 'str_update',
      desc: '',
      args: [],
    );
  }

  /// `Technical support`
  String get support_tech {
    return Intl.message(
      'Technical support',
      name: 'support_tech',
      desc: '',
      args: [],
    );
  }

  /// `Service Support`
  String get support_pay {
    return Intl.message(
      'Service Support',
      name: 'support_pay',
      desc: '',
      args: [],
    );
  }

  /// `Feedback to us`
  String get support_feedback {
    return Intl.message(
      'Feedback to us',
      name: 'support_feedback',
      desc: '',
      args: [],
    );
  }

  /// `Suggestions`
  String get support_help {
    return Intl.message(
      'Suggestions',
      name: 'support_help',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get str_warning {
    return Intl.message(
      'Warning',
      name: 'str_warning',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to open our website?`
  String get str_warning_detail {
    return Intl.message(
      'Are you sure you want to open our website?',
      name: 'str_warning_detail',
      desc: '',
      args: [],
    );
  }

  /// `About us`
  String get str_about {
    return Intl.message(
      'About us',
      name: 'str_about',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get str_confirm {
    return Intl.message(
      'Confirm',
      name: 'str_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Recover password`
  String get str_reset_password {
    return Intl.message(
      'Recover password',
      name: 'str_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email you registered with!`
  String get str_reset_password_note {
    return Intl.message(
      'Please enter the email you registered with!',
      name: 'str_reset_password_note',
      desc: '',
      args: [],
    );
  }

  /// `Enter email`
  String get str_type_email {
    return Intl.message(
      'Enter email',
      name: 'str_type_email',
      desc: '',
      args: [],
    );
  }

  /// `Create user`
  String get user_create {
    return Intl.message(
      'Create user',
      name: 'user_create',
      desc: '',
      args: [],
    );
  }

  /// `User information`
  String get user_detail {
    return Intl.message(
      'User information',
      name: 'user_detail',
      desc: '',
      args: [],
    );
  }

  /// `Show more`
  String get show_more {
    return Intl.message(
      'Show more',
      name: 'show_more',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to send the command?`
  String get are_you_ready_send_command {
    return Intl.message(
      'Are you sure you want to send the command?',
      name: 'are_you_ready_send_command',
      desc: '',
      args: [],
    );
  }

  /// `No network connection`
  String get no_internet {
    return Intl.message(
      'No network connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Timeout exceeded, please check your network connection`
  String get time_out_connection {
    return Intl.message(
      'Timeout exceeded, please check your network connection',
      name: 'time_out_connection',
      desc: '',
      args: [],
    );
  }

  /// `Cannot connect to server`
  String get not_connect_to_server {
    return Intl.message(
      'Cannot connect to server',
      name: 'not_connect_to_server',
      desc: '',
      args: [],
    );
  }

  /// `Elevated button`
  String get elevated_button {
    return Intl.message(
      'Elevated button',
      name: 'elevated_button',
      desc: '',
      args: [],
    );
  }

  /// `Primary`
  String get primary {
    return Intl.message(
      'Primary',
      name: 'primary',
      desc: '',
      args: [],
    );
  }

  /// `Secondary`
  String get secondary {
    return Intl.message(
      'Secondary',
      name: 'secondary',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Warning`
  String get warning {
    return Intl.message(
      'Warning',
      name: 'warning',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get info {
    return Intl.message(
      'Info',
      name: 'info',
      desc: '',
      args: [],
    );
  }

  /// `Danger`
  String get danger {
    return Intl.message(
      'Danger',
      name: 'danger',
      desc: '',
      args: [],
    );
  }

  /// `Elevated rounded button`
  String get elevated_rounded_button {
    return Intl.message(
      'Elevated rounded button',
      name: 'elevated_rounded_button',
      desc: '',
      args: [],
    );
  }

  /// `Flat button`
  String get flat_button {
    return Intl.message(
      'Flat button',
      name: 'flat_button',
      desc: '',
      args: [],
    );
  }

  /// `Rounded button`
  String get rounded_button {
    return Intl.message(
      'Rounded button',
      name: 'rounded_button',
      desc: '',
      args: [],
    );
  }

  /// `Outline Button`
  String get outline_button {
    return Intl.message(
      'Outline Button',
      name: 'outline_button',
      desc: '',
      args: [],
    );
  }

  /// `Outline rounded button`
  String get outline_rounded_button {
    return Intl.message(
      'Outline rounded button',
      name: 'outline_rounded_button',
      desc: '',
      args: [],
    );
  }

  /// `Soft button`
  String get soft_button {
    return Intl.message(
      'Soft button',
      name: 'soft_button',
      desc: '',
      args: [],
    );
  }

  /// `Soft rounded button`
  String get soft_rounded_button {
    return Intl.message(
      'Soft rounded button',
      name: 'soft_rounded_button',
      desc: '',
      args: [],
    );
  }

  /// `Text button`
  String get text_button {
    return Intl.message(
      'Text button',
      name: 'text_button',
      desc: '',
      args: [],
    );
  }

  /// `Text rounded button`
  String get text_rounded_button {
    return Intl.message(
      'Text rounded button',
      name: 'text_rounded_button',
      desc: '',
      args: [],
    );
  }

  /// `Sized button`
  String get sized_button {
    return Intl.message(
      'Sized button',
      name: 'sized_button',
      desc: '',
      args: [],
    );
  }

  /// `Small`
  String get small {
    return Intl.message(
      'Small',
      name: 'small',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Large`
  String get large {
    return Intl.message(
      'Large',
      name: 'large',
      desc: '',
      args: [],
    );
  }

  /// `Button group`
  String get button_group {
    return Intl.message(
      'Button group',
      name: 'button_group',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system {
    return Intl.message(
      'System',
      name: 'system',
      desc: '',
      args: [],
    );
  }

  /// `Buttons`
  String get buttons {
    return Intl.message(
      'Buttons',
      name: 'buttons',
      desc: '',
      args: [],
    );
  }

  /// `UI`
  String get ui {
    return Intl.message(
      'UI',
      name: 'ui',
      desc: '',
      args: [],
    );
  }

  /// `Cards`
  String get cards {
    return Intl.message(
      'Cards',
      name: 'cards',
      desc: '',
      args: [],
    );
  }

  /// `Card title`
  String get card_title {
    return Intl.message(
      'Card title',
      name: 'card_title',
      desc: '',
      args: [],
    );
  }

  /// `Click me`
  String get click_me {
    return Intl.message(
      'Click me',
      name: 'click_me',
      desc: '',
      args: [],
    );
  }

  /// `Text actions`
  String get text_actions {
    return Intl.message(
      'Text actions',
      name: 'text_actions',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
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

  /// `Subtitle is more useful`
  String get subtitle_is_more_useful {
    return Intl.message(
      'Subtitle is more useful',
      name: 'subtitle_is_more_useful',
      desc: '',
      args: [],
    );
  }

  /// `No shadow`
  String get no_shadow {
    return Intl.message(
      'No shadow',
      name: 'no_shadow',
      desc: '',
      args: [],
    );
  }

  /// `Bordered`
  String get bordered {
    return Intl.message(
      'Bordered',
      name: 'bordered',
      desc: '',
      args: [],
    );
  }

  /// `Shadow`
  String get shadow {
    return Intl.message(
      'Shadow',
      name: 'shadow',
      desc: '',
      args: [],
    );
  }

  /// `Very high`
  String get very_high {
    return Intl.message(
      'Very high',
      name: 'very_high',
      desc: '',
      args: [],
    );
  }

  /// `Card customizer`
  String get card_customizer {
    return Intl.message(
      'Card customizer',
      name: 'card_customizer',
      desc: '',
      args: [],
    );
  }

  /// `Shadow position`
  String get shadow_position {
    return Intl.message(
      'Shadow position',
      name: 'shadow_position',
      desc: '',
      args: [],
    );
  }

  /// `Shadow size`
  String get shadow_size {
    return Intl.message(
      'Shadow size',
      name: 'shadow_size',
      desc: '',
      args: [],
    );
  }

  /// `Shadow color`
  String get shadow_color {
    return Intl.message(
      'Shadow color',
      name: 'shadow_color',
      desc: '',
      args: [],
    );
  }

  /// `Result`
  String get result {
    return Intl.message(
      'Result',
      name: 'result',
      desc: '',
      args: [],
    );
  }

  /// `Animated`
  String get animated {
    return Intl.message(
      'Animated',
      name: 'animated',
      desc: '',
      args: [],
    );
  }

  /// `Carousels`
  String get carousels {
    return Intl.message(
      'Carousels',
      name: 'carousels',
      desc: '',
      args: [],
    );
  }

  /// `Simple`
  String get simple {
    return Intl.message(
      'Simple',
      name: 'simple',
      desc: '',
      args: [],
    );
  }

  /// `Dialogs`
  String get dialogs {
    return Intl.message(
      'Dialogs',
      name: 'dialogs',
      desc: '',
      args: [],
    );
  }

  /// `Type / size`
  String get type_size {
    return Intl.message(
      'Type / size',
      name: 'type_size',
      desc: '',
      args: [],
    );
  }

  /// `Alert`
  String get alert {
    return Intl.message(
      'Alert',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Standard`
  String get standard {
    return Intl.message(
      'Standard',
      name: 'standard',
      desc: '',
      args: [],
    );
  }

  /// `Full width`
  String get full_width {
    return Intl.message(
      'Full width',
      name: 'full_width',
      desc: '',
      args: [],
    );
  }

  /// `Positions`
  String get positions {
    return Intl.message(
      'Positions',
      name: 'positions',
      desc: '',
      args: [],
    );
  }

  /// `Left`
  String get left {
    return Intl.message(
      'Left',
      name: 'left',
      desc: '',
      args: [],
    );
  }

  /// `Top`
  String get top {
    return Intl.message(
      'Top',
      name: 'top',
      desc: '',
      args: [],
    );
  }

  /// `Right`
  String get right {
    return Intl.message(
      'Right',
      name: 'right',
      desc: '',
      args: [],
    );
  }

  /// `Bottom`
  String get bottom {
    return Intl.message(
      'Bottom',
      name: 'bottom',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `Static`
  String get static {
    return Intl.message(
      'Static',
      name: 'static',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation?`
  String get confirmation {
    return Intl.message(
      'Confirmation?',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure, you want to delete history?`
  String get are_you_sure_you_want_to_delete_history {
    return Intl.message(
      'Are you sure, you want to delete history?',
      name: 'are_you_sure_you_want_to_delete_history',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Dialog title`
  String get dialog_title {
    return Intl.message(
      'Dialog title',
      name: 'dialog_title',
      desc: '',
      args: [],
    );
  }

  /// `Right dialog`
  String get right_dialog {
    return Intl.message(
      'Right dialog',
      name: 'right_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Bottom dialog`
  String get bottom_dialog {
    return Intl.message(
      'Bottom dialog',
      name: 'bottom_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Top dialog`
  String get top_dialog {
    return Intl.message(
      'Top dialog',
      name: 'top_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Left dialog`
  String get left_dialog {
    return Intl.message(
      'Left dialog',
      name: 'left_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Static dialog`
  String get static_dialog {
    return Intl.message(
      'Static dialog',
      name: 'static_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Banner`
  String get banner {
    return Intl.message(
      'Banner',
      name: 'banner',
      desc: '',
      args: [],
    );
  }

  /// `Toast`
  String get toast {
    return Intl.message(
      'Toast',
      name: 'toast',
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

  /// `Title text`
  String get title_text {
    return Intl.message(
      'Title text',
      name: 'title_text',
      desc: '',
      args: [],
    );
  }

  /// `toast_text`
  String get toast_text {
    return Intl.message(
      'toast_text',
      name: 'toast_text',
      desc: '',
      args: [],
    );
  }

  /// `Color variant`
  String get color_variant {
    return Intl.message(
      'Color variant',
      name: 'color_variant',
      desc: '',
      args: [],
    );
  }

  /// `Floating type`
  String get floating_type {
    return Intl.message(
      'Floating type',
      name: 'floating_type',
      desc: '',
      args: [],
    );
  }

  /// `Actions`
  String get actions {
    return Intl.message(
      'Actions',
      name: 'actions',
      desc: '',
      args: [],
    );
  }

  /// `Show close icon`
  String get show_close_icon {
    return Intl.message(
      'Show close icon',
      name: 'show_close_icon',
      desc: '',
      args: [],
    );
  }

  /// `Show ok action`
  String get show_ok_action {
    return Intl.message(
      'Show ok action',
      name: 'show_ok_action',
      desc: '',
      args: [],
    );
  }

  /// `Show leading icon`
  String get show_leading_icon {
    return Intl.message(
      'Show leading icon',
      name: 'show_leading_icon',
      desc: '',
      args: [],
    );
  }

  /// `Timeout`
  String get timeout {
    return Intl.message(
      'Timeout',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Infinite`
  String get infinite {
    return Intl.message(
      'Infinite',
      name: 'infinite',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get show {
    return Intl.message(
      'Show',
      name: 'show',
      desc: '',
      args: [],
    );
  }

  /// `Tabs`
  String get tabs {
    return Intl.message(
      'Tabs',
      name: 'tabs',
      desc: '',
      args: [],
    );
  }

  /// `Default tabs`
  String get default_tabs {
    return Intl.message(
      'Default tabs',
      name: 'default_tabs',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `Background indicator`
  String get background_indicator {
    return Intl.message(
      'Background indicator',
      name: 'background_indicator',
      desc: '',
      args: [],
    );
  }

  /// `Bordered indicator`
  String get bordered_indicator {
    return Intl.message(
      'Bordered indicator',
      name: 'bordered_indicator',
      desc: '',
      args: [],
    );
  }

  /// `Soft indicator`
  String get soft_indicator {
    return Intl.message(
      'Soft indicator',
      name: 'soft_indicator',
      desc: '',
      args: [],
    );
  }

  /// `Custom indicator`
  String get custom_indicator {
    return Intl.message(
      'Custom indicator',
      name: 'custom_indicator',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Ecommerce`
  String get ecommerce {
    return Intl.message(
      'Ecommerce',
      name: 'ecommerce',
      desc: '',
      args: [],
    );
  }

  /// `Total revenue`
  String get total_revenue {
    return Intl.message(
      'Total revenue',
      name: 'total_revenue',
      desc: '',
      args: [],
    );
  }

  /// `Today sales`
  String get today_sales {
    return Intl.message(
      'Today sales',
      name: 'today_sales',
      desc: '',
      args: [],
    );
  }

  /// `On delivery`
  String get on_delivery {
    return Intl.message(
      'On delivery',
      name: 'on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Website visits`
  String get website_visits {
    return Intl.message(
      'Website visits',
      name: 'website_visits',
      desc: '',
      args: [],
    );
  }

  /// `Revenue`
  String get revenue {
    return Intl.message(
      'Revenue',
      name: 'revenue',
      desc: '',
      args: [],
    );
  }

  /// `Target`
  String get target {
    return Intl.message(
      'Target',
      name: 'target',
      desc: '',
      args: [],
    );
  }

  /// `Last week`
  String get last_week {
    return Intl.message(
      'Last week',
      name: 'last_week',
      desc: '',
      args: [],
    );
  }

  /// `Last month`
  String get last_month {
    return Intl.message(
      'Last month',
      name: 'last_month',
      desc: '',
      args: [],
    );
  }

  /// `Product comparison`
  String get product_comparison {
    return Intl.message(
      'Product comparison',
      name: 'product_comparison',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get product {
    return Intl.message(
      'Product',
      name: 'product',
      desc: '',
      args: [],
    );
  }

  /// `Trending products`
  String get trending_products {
    return Intl.message(
      'Trending products',
      name: 'trending_products',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get view_all {
    return Intl.message(
      'View all',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get id {
    return Intl.message(
      'ID',
      name: 'id',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get stock {
    return Intl.message(
      'Stock',
      name: 'stock',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Action`
  String get action {
    return Intl.message(
      'Action',
      name: 'action',
      desc: '',
      args: [],
    );
  }

  /// `Customers`
  String get customers {
    return Intl.message(
      'Customers',
      name: 'customers',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Create product`
  String get create_product {
    return Intl.message(
      'Create product',
      name: 'create_product',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `SKU`
  String get sku {
    return Intl.message(
      'SKU',
      name: 'sku',
      desc: '',
      args: [],
    );
  }

  /// `Created at`
  String get created_at {
    return Intl.message(
      'Created at',
      name: 'created_at',
      desc: '',
      args: [],
    );
  }

  /// `Add products`
  String get add_products {
    return Intl.message(
      'Add products',
      name: 'add_products',
      desc: '',
      args: [],
    );
  }

  /// `GENERAL`
  String get general {
    return Intl.message(
      'GENERAL',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Product name`
  String get product_name {
    return Intl.message(
      'Product name',
      name: 'product_name',
      desc: '',
      args: [],
    );
  }

  /// `Shop name`
  String get shop_name {
    return Intl.message(
      'Shop name',
      name: 'shop_name',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `Tags`
  String get tags {
    return Intl.message(
      'Tags',
      name: 'tags',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Last order at`
  String get last_order_at {
    return Intl.message(
      'Last order at',
      name: 'last_order_at',
      desc: '',
      args: [],
    );
  }

  /// `Basic forms`
  String get basic_forms {
    return Intl.message(
      'Basic forms',
      name: 'basic_forms',
      desc: '',
      args: [],
    );
  }

  /// `Forms`
  String get forms {
    return Intl.message(
      'Forms',
      name: 'forms',
      desc: '',
      args: [],
    );
  }

  /// `Basic`
  String get basic {
    return Intl.message(
      'Basic',
      name: 'basic',
      desc: '',
      args: [],
    );
  }

  /// `Boxed style`
  String get boxed_style {
    return Intl.message(
      'Boxed style',
      name: 'boxed_style',
      desc: '',
      args: [],
    );
  }

  /// `Outline style`
  String get outline_style {
    return Intl.message(
      'Outline style',
      name: 'outline_style',
      desc: '',
      args: [],
    );
  }

  /// `Example form`
  String get example_form {
    return Intl.message(
      'Example form',
      name: 'example_form',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get first_name {
    return Intl.message(
      'First name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get last_name {
    return Intl.message(
      'Last name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Basic input`
  String get basic_input {
    return Intl.message(
      'Basic input',
      name: 'basic_input',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Other settings`
  String get other_settings {
    return Intl.message(
      'Other settings',
      name: 'other_settings',
      desc: '',
      args: [],
    );
  }

  /// `Set profile to private`
  String get set_profile_to_private {
    return Intl.message(
      'Set profile to private',
      name: 'set_profile_to_private',
      desc: '',
      args: [],
    );
  }

  /// `Opt-in daily newsletter at the email`
  String get opt_in_daily_newsletter_at_the_email {
    return Intl.message(
      'Opt-in daily newsletter at the email',
      name: 'opt_in_daily_newsletter_at_the_email',
      desc: '',
      args: [],
    );
  }

  /// `I agree with `
  String get i_agree_with {
    return Intl.message(
      'I agree with ',
      name: 'i_agree_with',
      desc: '',
      args: [],
    );
  }

  /// `terms & conditions`
  String get terms_conditions {
    return Intl.message(
      'terms & conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `More inputs`
  String get more_inputs {
    return Intl.message(
      'More inputs',
      name: 'more_inputs',
      desc: '',
      args: [],
    );
  }

  /// `Date time pickers`
  String get date_time_pickers {
    return Intl.message(
      'Date time pickers',
      name: 'date_time_pickers',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get select_date {
    return Intl.message(
      'Select date',
      name: 'select_date',
      desc: '',
      args: [],
    );
  }

  /// `Select time`
  String get select_time {
    return Intl.message(
      'Select time',
      name: 'select_time',
      desc: '',
      args: [],
    );
  }

  /// `Select range`
  String get select_range {
    return Intl.message(
      'Select range',
      name: 'select_range',
      desc: '',
      args: [],
    );
  }

  /// `Select date & time`
  String get select_date_time {
    return Intl.message(
      'Select date & time',
      name: 'select_date_time',
      desc: '',
      args: [],
    );
  }

  /// `Sliders`
  String get sliders {
    return Intl.message(
      'Sliders',
      name: 'sliders',
      desc: '',
      args: [],
    );
  }

  /// `Builder`
  String get builder {
    return Intl.message(
      'Builder',
      name: 'builder',
      desc: '',
      args: [],
    );
  }

  /// `Floating label type`
  String get floating_label_type {
    return Intl.message(
      'Floating label type',
      name: 'floating_label_type',
      desc: '',
      args: [],
    );
  }

  /// `Border type`
  String get border_type {
    return Intl.message(
      'Border type',
      name: 'border_type',
      desc: '',
      args: [],
    );
  }

  /// `Filled`
  String get filled {
    return Intl.message(
      'Filled',
      name: 'filled',
      desc: '',
      args: [],
    );
  }

  /// `Output`
  String get output {
    return Intl.message(
      'Output',
      name: 'output',
      desc: '',
      args: [],
    );
  }

  /// `Validation forms`
  String get validation_forms {
    return Intl.message(
      'Validation forms',
      name: 'validation_forms',
      desc: '',
      args: [],
    );
  }

  /// `Validation`
  String get validation {
    return Intl.message(
      'Validation',
      name: 'validation',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Wizard`
  String get wizard {
    return Intl.message(
      'Wizard',
      name: 'wizard',
      desc: '',
      args: [],
    );
  }

  /// `Enable validation`
  String get enable_validation {
    return Intl.message(
      'Enable validation',
      name: 'enable_validation',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phone_number {
    return Intl.message(
      'Phone number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Prev`
  String get prev {
    return Intl.message(
      'Prev',
      name: 'prev',
      desc: '',
      args: [],
    );
  }

  /// `Your registration process is finished`
  String get your_registration_process_is_finished {
    return Intl.message(
      'Your registration process is finished',
      name: 'your_registration_process_is_finished',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message(
      'Account',
      name: 'account',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message(
      'Complete',
      name: 'complete',
      desc: '',
      args: [],
    );
  }

  /// `Basic tables`
  String get basic_tables {
    return Intl.message(
      'Basic tables',
      name: 'basic_tables',
      desc: '',
      args: [],
    );
  }

  /// `Basic table`
  String get basic_table {
    return Intl.message(
      'Basic table',
      name: 'basic_table',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Qty`
  String get qty {
    return Intl.message(
      'Qty',
      name: 'qty',
      desc: '',
      args: [],
    );
  }

  /// `Google map`
  String get google_map {
    return Intl.message(
      'Google map',
      name: 'google_map',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Syncfusion charts`
  String get syncfusion_charts {
    return Intl.message(
      'Syncfusion charts',
      name: 'syncfusion_charts',
      desc: '',
      args: [],
    );
  }

  /// `Charts`
  String get charts {
    return Intl.message(
      'Charts',
      name: 'charts',
      desc: '',
      args: [],
    );
  }

  /// `Area chart`
  String get area_chart {
    return Intl.message(
      'Area chart',
      name: 'area_chart',
      desc: '',
      args: [],
    );
  }

  /// `Bar chart`
  String get bar_chart {
    return Intl.message(
      'Bar chart',
      name: 'bar_chart',
      desc: '',
      args: [],
    );
  }

  /// `Bubble chart`
  String get bubble_chart {
    return Intl.message(
      'Bubble chart',
      name: 'bubble_chart',
      desc: '',
      args: [],
    );
  }

  /// `Column chart`
  String get column_chart {
    return Intl.message(
      'Column chart',
      name: 'column_chart',
      desc: '',
      args: [],
    );
  }

  /// `Doughnut chart`
  String get doughnut_chart {
    return Intl.message(
      'Doughnut chart',
      name: 'doughnut_chart',
      desc: '',
      args: [],
    );
  }

  /// `Pie chart`
  String get pie_chart {
    return Intl.message(
      'Pie chart',
      name: 'pie_chart',
      desc: '',
      args: [],
    );
  }

  /// `Radial chart`
  String get radial_chart {
    return Intl.message(
      'Radial chart',
      name: 'radial_chart',
      desc: '',
      args: [],
    );
  }

  /// `Pyramid chart`
  String get pyramid_chart {
    return Intl.message(
      'Pyramid chart',
      name: 'pyramid_chart',
      desc: '',
      args: [],
    );
  }

  /// `Product a`
  String get product_a {
    return Intl.message(
      'Product a',
      name: 'product_a',
      desc: '',
      args: [],
    );
  }

  /// `Product b`
  String get product_b {
    return Intl.message(
      'Product b',
      name: 'product_b',
      desc: '',
      args: [],
    );
  }

  /// `Average sales comparison`
  String get average_sales_comparison {
    return Intl.message(
      'Average sales comparison',
      name: 'average_sales_comparison',
      desc: '',
      args: [],
    );
  }

  /// `Tourism - number`
  String get tourism_number {
    return Intl.message(
      'Tourism - number',
      name: 'tourism_number',
      desc: '',
      args: [],
    );
  }

  /// `of arrivals`
  String get of_arrivals {
    return Intl.message(
      'of arrivals',
      name: 'of_arrivals',
      desc: '',
      args: [],
    );
  }

  /// `World countries details`
  String get world_countries_details {
    return Intl.message(
      'World countries details',
      name: 'world_countries_details',
      desc: '',
      args: [],
    );
  }

  /// `Literacy rate`
  String get literacy_rate {
    return Intl.message(
      'Literacy rate',
      name: 'literacy_rate',
      desc: '',
      args: [],
    );
  }

  /// `GDP growth rate`
  String get gdp_growth_rate {
    return Intl.message(
      'GDP growth rate',
      name: 'gdp_growth_rate',
      desc: '',
      args: [],
    );
  }

  /// `Population growth of various countries`
  String get population_growth_of_various_countries {
    return Intl.message(
      'Population growth of various countries',
      name: 'population_growth_of_various_countries',
      desc: '',
      args: [],
    );
  }

  /// `Composition of ocean water`
  String get composition_of_ocean_water {
    return Intl.message(
      'Composition of ocean water',
      name: 'composition_of_ocean_water',
      desc: '',
      args: [],
    );
  }

  /// `Sales by sales person`
  String get sales_by_sales_person {
    return Intl.message(
      'Sales by sales person',
      name: 'sales_by_sales_person',
      desc: '',
      args: [],
    );
  }

  /// `Shot put distance`
  String get shot_put_distance {
    return Intl.message(
      'Shot put distance',
      name: 'shot_put_distance',
      desc: '',
      args: [],
    );
  }

  /// `Comparison of calories`
  String get comparison_of_calories {
    return Intl.message(
      'Comparison of calories',
      name: 'comparison_of_calories',
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

  /// `I haven't account`
  String get i_haven_t_account {
    return Intl.message(
      'I haven\'t account',
      name: 'i_haven_t_account',
      desc: '',
      args: [],
    );
  }

  /// `Back to log in`
  String get back_to_log_in {
    return Intl.message(
      'Back to log in',
      name: 'back_to_log_in',
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

  /// `Email password`
  String get email_password {
    return Intl.message(
      'Email password',
      name: 'email_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Your password will be reset`
  String get your_password_will_be_reset {
    return Intl.message(
      'Your password will be reset',
      name: 'your_password_will_be_reset',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Locked`
  String get locked {
    return Intl.message(
      'Locked',
      name: 'locked',
      desc: '',
      args: [],
    );
  }

  /// `Unlock`
  String get unlock {
    return Intl.message(
      'Unlock',
      name: 'unlock',
      desc: '',
      args: [],
    );
  }

  /// `FAQs`
  String get faqs {
    return Intl.message(
      'FAQs',
      name: 'faqs',
      desc: '',
      args: [],
    );
  }

  /// `Extra pages`
  String get extra_pages {
    return Intl.message(
      'Extra pages',
      name: 'extra_pages',
      desc: '',
      args: [],
    );
  }

  /// `Frequently asked questions`
  String get frequently_asked_questions {
    return Intl.message(
      'Frequently asked questions',
      name: 'frequently_asked_questions',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contact_us {
    return Intl.message(
      'Contact us',
      name: 'contact_us',
      desc: '',
      args: [],
    );
  }

  /// `Email us your question`
  String get email_us_your_question {
    return Intl.message(
      'Email us your question',
      name: 'email_us_your_question',
      desc: '',
      args: [],
    );
  }

  /// `License & copyright`
  String get license_copyright {
    return Intl.message(
      'License & copyright',
      name: 'license_copyright',
      desc: '',
      args: [],
    );
  }

  /// `Apps`
  String get apps {
    return Intl.message(
      'Apps',
      name: 'apps',
      desc: '',
      args: [],
    );
  }

  /// `Add product`
  String get add_product {
    return Intl.message(
      'Add product',
      name: 'add_product',
      desc: '',
      args: [],
    );
  }

  /// `Pages`
  String get pages {
    return Intl.message(
      'Pages',
      name: 'pages',
      desc: '',
      args: [],
    );
  }

  /// `Auth`
  String get auth {
    return Intl.message(
      'Auth',
      name: 'auth',
      desc: '',
      args: [],
    );
  }

  /// `Widgets`
  String get widgets {
    return Intl.message(
      'Widgets',
      name: 'widgets',
      desc: '',
      args: [],
    );
  }

  /// `Form`
  String get form {
    return Intl.message(
      'Form',
      name: 'form',
      desc: '',
      args: [],
    );
  }

  /// `Validations`
  String get validations {
    return Intl.message(
      'Validations',
      name: 'validations',
      desc: '',
      args: [],
    );
  }

  /// `Starter`
  String get starter {
    return Intl.message(
      'Starter',
      name: 'starter',
      desc: '',
      args: [],
    );
  }

  /// `Faqs`
  String get FAQs {
    return Intl.message(
      'Faqs',
      name: 'FAQs',
      desc: '',
      args: [],
    );
  }

  /// `Syncfusion chart`
  String get syncfusion_chart {
    return Intl.message(
      'Syncfusion chart',
      name: 'syncfusion_chart',
      desc: '',
      args: [],
    );
  }

  /// `Purchase now`
  String get purchase_now {
    return Intl.message(
      'Purchase now',
      name: 'purchase_now',
      desc: '',
      args: [],
    );
  }

  /// `Product`
  String get Product {
    return Intl.message(
      'Product',
      name: 'Product',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password1 {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password1',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get oK {
    return Intl.message(
      'Ok',
      name: 'oK',
      desc: '',
      args: [],
    );
  }

  /// `Basic`
  String get Basic {
    return Intl.message(
      'Basic',
      name: 'Basic',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get str_calendar {
    return Intl.message(
      'Calendar',
      name: 'str_calendar',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get str_chat {
    return Intl.message(
      'Chat',
      name: 'str_chat',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get str_contacts {
    return Intl.message(
      'Contacts',
      name: 'str_contacts',
      desc: '',
      args: [],
    );
  }

  /// `Members`
  String get str_members {
    return Intl.message(
      'Members',
      name: 'str_members',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get str_edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'str_edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `CRM`
  String get str_CRM {
    return Intl.message(
      'CRM',
      name: 'str_CRM',
      desc: '',
      args: [],
    );
  }

  /// `Opportunities`
  String get str_opportunities {
    return Intl.message(
      'Opportunities',
      name: 'str_opportunities',
      desc: '',
      args: [],
    );
  }

  /// `Product detail`
  String get str_product_detail {
    return Intl.message(
      'Product detail',
      name: 'str_product_detail',
      desc: '',
      args: [],
    );
  }

  /// `Invoice`
  String get str_invoice {
    return Intl.message(
      'Invoice',
      name: 'str_invoice',
      desc: '',
      args: [],
    );
  }

  /// `Manager`
  String get str_manager {
    return Intl.message(
      'Manager',
      name: 'str_manager',
      desc: '',
      args: [],
    );
  }

  /// `Upload`
  String get str_upload {
    return Intl.message(
      'Upload',
      name: 'str_upload',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get str_projects {
    return Intl.message(
      'Projects',
      name: 'str_projects',
      desc: '',
      args: [],
    );
  }

  /// `Project List`
  String get str_project_list {
    return Intl.message(
      'Project List',
      name: 'str_project_list',
      desc: '',
      args: [],
    );
  }

  /// `Project Detail`
  String get str_project_detail {
    return Intl.message(
      'Project Detail',
      name: 'str_project_detail',
      desc: '',
      args: [],
    );
  }

  /// `Create Project`
  String get str_create_project {
    return Intl.message(
      'Create Project',
      name: 'str_create_project',
      desc: '',
      args: [],
    );
  }

  /// `NFT Dashboard`
  String get str_NFT_dashboard {
    return Intl.message(
      'NFT Dashboard',
      name: 'str_NFT_dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Customer`
  String get str_customer {
    return Intl.message(
      'Customer',
      name: 'str_customer',
      desc: '',
      args: [],
    );
  }

  /// `Fitness`
  String get str_fitness {
    return Intl.message(
      'Fitness',
      name: 'str_fitness',
      desc: '',
      args: [],
    );
  }

  /// `Mail Box`
  String get str_mailbox {
    return Intl.message(
      'Mail Box',
      name: 'str_mailbox',
      desc: '',
      args: [],
    );
  }

  /// `Landing`
  String get str_Landing {
    return Intl.message(
      'Landing',
      name: 'str_Landing',
      desc: '',
      args: [],
    );
  }

  /// `Coming Soon`
  String get str_coming_soon {
    return Intl.message(
      'Coming Soon',
      name: 'str_coming_soon',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance`
  String get str_maintenance {
    return Intl.message(
      'Maintenance',
      name: 'str_maintenance',
      desc: '',
      args: [],
    );
  }

  /// `Extra Pages`
  String get str_extra_pages {
    return Intl.message(
      'Extra Pages',
      name: 'str_extra_pages',
      desc: '',
      args: [],
    );
  }

  /// `Faqs`
  String get str_faqs {
    return Intl.message(
      'Faqs',
      name: 'str_faqs',
      desc: '',
      args: [],
    );
  }

  /// `Pricing`
  String get str_pricing {
    return Intl.message(
      'Pricing',
      name: 'str_pricing',
      desc: '',
      args: [],
    );
  }

  /// `TimeLine`
  String get str_timeLine {
    return Intl.message(
      'TimeLine',
      name: 'str_timeLine',
      desc: '',
      args: [],
    );
  }

  /// `Form Mask`
  String get str_form_mask {
    return Intl.message(
      'Form Mask',
      name: 'str_form_mask',
      desc: '',
      args: [],
    );
  }

  /// `Quill Editor`
  String get str_quill_editor {
    return Intl.message(
      'Quill Editor',
      name: 'str_quill_editor',
      desc: '',
      args: [],
    );
  }

  /// `Drag drop`
  String get str_drag_drop {
    return Intl.message(
      'Drag drop',
      name: 'str_drag_drop',
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
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'vi'),
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
