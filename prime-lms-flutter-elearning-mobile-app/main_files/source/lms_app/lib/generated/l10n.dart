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

  /// `Prime LMS`
  String get app_name {
    return Intl.message(
      'Prime LMS',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred!`
  String get notify_error {
    return Intl.message(
      'An error has occurred!',
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

  /// `Loading, please wait...`
  String get loading_message {
    return Intl.message(
      'Loading, please wait...',
      name: 'loading_message',
      desc: '',
      args: [],
    );
  }

  /// `Filter List`
  String get fitter_list {
    return Intl.message(
      'Filter List',
      name: 'fitter_list',
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

  /// `Size Settings`
  String get size_settings {
    return Intl.message(
      'Size Settings',
      name: 'size_settings',
      desc: '',
      args: [],
    );
  }

  /// `Change size of images`
  String get change_size_of_images {
    return Intl.message(
      'Change size of images',
      name: 'change_size_of_images',
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

  /// `Change layout behavior`
  String get change_layout_behavior {
    return Intl.message(
      'Change layout behavior',
      name: 'change_layout_behavior',
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

  /// `Forgot pin code?`
  String get forgot_password {
    return Intl.message(
      'Forgot pin code?',
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

  /// `You don't have an account?`
  String get you_do_not_have_an_account {
    return Intl.message(
      'You don\'t have an account?',
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

  /// `Sign In`
  String get sign_in {
    return Intl.message(
      'Sign In',
      name: 'sign_in',
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

  /// `Vehical`
  String get vehicle {
    return Intl.message(
      'Vehical',
      name: 'vehicle',
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

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
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

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get date_of_birth {
    return Intl.message(
      'Date of Birth',
      name: 'date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get your_address {
    return Intl.message(
      'Your Address',
      name: 'your_address',
      desc: '',
      args: [],
    );
  }

  /// `You have an account?`
  String get you_do_have_an_account {
    return Intl.message(
      'You have an account?',
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

  /// `User Name`
  String get user_name {
    return Intl.message(
      'User Name',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get state_expired {
    return Intl.message(
      'Expired',
      name: 'state_expired',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get state_all {
    return Intl.message(
      'All',
      name: 'state_all',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get state_stop {
    return Intl.message(
      'Stop',
      name: 'state_stop',
      desc: '',
      args: [],
    );
  }

  /// `Running`
  String get state_running {
    return Intl.message(
      'Running',
      name: 'state_running',
      desc: '',
      args: [],
    );
  }

  /// `GPS Poor`
  String get state_poor_GPS {
    return Intl.message(
      'GPS Poor',
      name: 'state_poor_GPS',
      desc: '',
      args: [],
    );
  }

  /// `GPRS Poor`
  String get state_poor_GPRS {
    return Intl.message(
      'GPRS Poor',
      name: 'state_poor_GPRS',
      desc: '',
      args: [],
    );
  }

  /// `Tranfer history`
  String get state_tranfer_history {
    return Intl.message(
      'Tranfer history',
      name: 'state_tranfer_history',
      desc: '',
      args: [],
    );
  }

  /// `Parking`
  String get state_parking {
    return Intl.message(
      'Parking',
      name: 'state_parking',
      desc: '',
      args: [],
    );
  }

  /// `No GPS`
  String get state_not_GPS {
    return Intl.message(
      'No GPS',
      name: 'state_not_GPS',
      desc: '',
      args: [],
    );
  }

  /// `No GPRS`
  String get state_not_GPRS {
    return Intl.message(
      'No GPRS',
      name: 'state_not_GPRS',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get state_inactive {
    return Intl.message(
      'Inactive',
      name: 'state_inactive',
      desc: '',
      args: [],
    );
  }

  /// `Invalid status`
  String get state_invalid_status {
    return Intl.message(
      'Invalid status',
      name: 'state_invalid_status',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting_text {
    return Intl.message(
      'Settings',
      name: 'setting_text',
      desc: '',
      args: [],
    );
  }

  /// `Common`
  String get common_text {
    return Intl.message(
      'Common',
      name: 'common_text',
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

  /// `Environment`
  String get environment_text {
    return Intl.message(
      'Environment',
      name: 'environment_text',
      desc: '',
      args: [],
    );
  }

  /// `Production`
  String get production_text {
    return Intl.message(
      'Production',
      name: 'production_text',
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

  /// `Lock app in background`
  String get lock_app_in_background_text {
    return Intl.message(
      'Lock app in background',
      name: 'lock_app_in_background_text',
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

  /// `Enable Notifications`
  String get enable_notifications_text {
    return Intl.message(
      'Enable Notifications',
      name: 'enable_notifications_text',
      desc: '',
      args: [],
    );
  }

  /// `Misc`
  String get miss_text {
    return Intl.message(
      'Misc',
      name: 'miss_text',
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

  /// `Version`
  String get version_text {
    return Intl.message(
      'Version',
      name: 'version_text',
      desc: '',
      args: [],
    );
  }

  /// `Map setting`
  String get map_setting_title {
    return Intl.message(
      'Map setting',
      name: 'map_setting_title',
      desc: '',
      args: [],
    );
  }

  /// `Show traffic`
  String get showTraffic {
    return Intl.message(
      'Show traffic',
      name: 'showTraffic',
      desc: '',
      args: [],
    );
  }

  /// `Show car group`
  String get showCarGroup {
    return Intl.message(
      'Show car group',
      name: 'showCarGroup',
      desc: '',
      args: [],
    );
  }

  /// `Show my location`
  String get showMyLocation {
    return Intl.message(
      'Show my location',
      name: 'showMyLocation',
      desc: '',
      args: [],
    );
  }

  /// `Show car icon`
  String get showCarIcon {
    return Intl.message(
      'Show car icon',
      name: 'showCarIcon',
      desc: '',
      args: [],
    );
  }

  /// `Show geofence`
  String get showGeofence {
    return Intl.message(
      'Show geofence',
      name: 'showGeofence',
      desc: '',
      args: [],
    );
  }

  /// `Allow traction`
  String get showFocusToVehicle {
    return Intl.message(
      'Allow traction',
      name: 'showFocusToVehicle',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get category_account {
    return Intl.message(
      'Account',
      name: 'category_account',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category_category {
    return Intl.message(
      'Category',
      name: 'category_category',
      desc: '',
      args: [],
    );
  }

  /// `Photo - Video`
  String get category_media_data {
    return Intl.message(
      'Photo - Video',
      name: 'category_media_data',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get category_report {
    return Intl.message(
      'Report',
      name: 'category_report',
      desc: '',
      args: [],
    );
  }

  /// `Devices`
  String get category_device {
    return Intl.message(
      'Devices',
      name: 'category_device',
      desc: '',
      args: [],
    );
  }

  /// `Service-support`
  String get category_service_support {
    return Intl.message(
      'Service-support',
      name: 'category_service_support',
      desc: '',
      args: [],
    );
  }

  /// `News and notify`
  String get category_tracking {
    return Intl.message(
      'News and notify',
      name: 'category_tracking',
      desc: '',
      args: [],
    );
  }

  /// `News and notify`
  String get category_news_notify {
    return Intl.message(
      'News and notify',
      name: 'category_news_notify',
      desc: '',
      args: [],
    );
  }

  /// `Tracking`
  String get map_tracking {
    return Intl.message(
      'Tracking',
      name: 'map_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Trip`
  String get map_trip {
    return Intl.message(
      'Trip',
      name: 'map_trip',
      desc: '',
      args: [],
    );
  }

  /// `Replay`
  String get map_replay {
    return Intl.message(
      'Replay',
      name: 'map_replay',
      desc: '',
      args: [],
    );
  }

  /// `Info`
  String get map_info {
    return Intl.message(
      'Info',
      name: 'map_info',
      desc: '',
      args: [],
    );
  }

  /// `Command`
  String get map_command {
    return Intl.message(
      'Command',
      name: 'map_command',
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

  /// ` Hour `
  String get time_in_hour_str {
    return Intl.message(
      ' Hour ',
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

  /// `Second`
  String get time_in_second_str {
    return Intl.message(
      'Second',
      name: 'time_in_second_str',
      desc: '',
      args: [],
    );
  }

  /// ` Battery `
  String get battery_str {
    return Intl.message(
      ' Battery ',
      name: 'battery_str',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get door_status_open_str {
    return Intl.message(
      'Open',
      name: 'door_status_open_str',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get door_status_close_str {
    return Intl.message(
      'Close',
      name: 'door_status_close_str',
      desc: '',
      args: [],
    );
  }

  /// `ON`
  String get basic_status_on {
    return Intl.message(
      'ON',
      name: 'basic_status_on',
      desc: '',
      args: [],
    );
  }

  /// `OFF`
  String get basic_status_off {
    return Intl.message(
      'OFF',
      name: 'basic_status_off',
      desc: '',
      args: [],
    );
  }

  /// `Continuous driving: `
  String get continuous_driving {
    return Intl.message(
      'Continuous driving: ',
      name: 'continuous_driving',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance_driving {
    return Intl.message(
      'Distance',
      name: 'distance_driving',
      desc: '',
      args: [],
    );
  }

  /// `Fuel and Utilities`
  String get detail_fuel_and_utility {
    return Intl.message(
      'Fuel and Utilities',
      name: 'detail_fuel_and_utility',
      desc: '',
      args: [],
    );
  }

  /// `Air conditioner`
  String get detail_air {
    return Intl.message(
      'Air conditioner',
      name: 'detail_air',
      desc: '',
      args: [],
    );
  }

  /// `Engine`
  String get detail_engine {
    return Intl.message(
      'Engine',
      name: 'detail_engine',
      desc: '',
      args: [],
    );
  }

  /// `Door`
  String get detail_door {
    return Intl.message(
      'Door',
      name: 'detail_door',
      desc: '',
      args: [],
    );
  }

  /// `Remaining fuel`
  String get detail_fuel {
    return Intl.message(
      'Remaining fuel',
      name: 'detail_fuel',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get detail_temp {
    return Intl.message(
      'Temperature',
      name: 'detail_temp',
      desc: '',
      args: [],
    );
  }

  /// `Lock the car`
  String get detail_acc {
    return Intl.message(
      'Lock the car',
      name: 'detail_acc',
      desc: '',
      args: [],
    );
  }

  /// `Raise the bin`
  String get detail_ben {
    return Intl.message(
      'Raise the bin',
      name: 'detail_ben',
      desc: '',
      args: [],
    );
  }

  /// `Car light`
  String get detail_light {
    return Intl.message(
      'Car light',
      name: 'detail_light',
      desc: '',
      args: [],
    );
  }

  /// `Right turn light`
  String get detail_right_turn_signal {
    return Intl.message(
      'Right turn light',
      name: 'detail_right_turn_signal',
      desc: '',
      args: [],
    );
  }

  /// `Left turn light`
  String get detail_left_turn_signal {
    return Intl.message(
      'Left turn light',
      name: 'detail_left_turn_signal',
      desc: '',
      args: [],
    );
  }

  /// `Brake`
  String get detail_brake {
    return Intl.message(
      'Brake',
      name: 'detail_brake',
      desc: '',
      args: [],
    );
  }

  /// `Car information`
  String get detail_car_info {
    return Intl.message(
      'Car information',
      name: 'detail_car_info',
      desc: '',
      args: [],
    );
  }

  /// `License plate`
  String get detail_license_plate {
    return Intl.message(
      'License plate',
      name: 'detail_license_plate',
      desc: '',
      args: [],
    );
  }

  /// `VIN`
  String get detail_VIN {
    return Intl.message(
      'VIN',
      name: 'detail_VIN',
      desc: '',
      args: [],
    );
  }

  /// `Expiration date`
  String get detail_date_expected {
    return Intl.message(
      'Expiration date',
      name: 'detail_date_expected',
      desc: '',
      args: [],
    );
  }

  /// `Driver information`
  String get detail_driver_information {
    return Intl.message(
      'Driver information',
      name: 'detail_driver_information',
      desc: '',
      args: [],
    );
  }

  /// `Tracking vehicle`
  String get detail_car_tracking {
    return Intl.message(
      'Tracking vehicle',
      name: 'detail_car_tracking',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get detail_car_status {
    return Intl.message(
      'Status',
      name: 'detail_car_status',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get detail_car_speed {
    return Intl.message(
      'Speed',
      name: 'detail_car_speed',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get detail_car_tracking_day_time {
    return Intl.message(
      'Time',
      name: 'detail_car_tracking_day_time',
      desc: '',
      args: [],
    );
  }

  /// `Km of the day`
  String get detail_car_tracking_day_distance {
    return Intl.message(
      'Km of the day',
      name: 'detail_car_tracking_day_distance',
      desc: '',
      args: [],
    );
  }

  /// `Update at`
  String get detail_car_update_time {
    return Intl.message(
      'Update at',
      name: 'detail_car_update_time',
      desc: '',
      args: [],
    );
  }

  /// `Current address`
  String get detail_car_address {
    return Intl.message(
      'Current address',
      name: 'detail_car_address',
      desc: '',
      args: [],
    );
  }

  /// `Coordinates`
  String get detail_position_lat_lng {
    return Intl.message(
      'Coordinates',
      name: 'detail_position_lat_lng',
      desc: '',
      args: [],
    );
  }

  /// `There are no vehicles in this state!`
  String get message_notify_not_have_car_in_this_state {
    return Intl.message(
      'There are no vehicles in this state!',
      name: 'message_notify_not_have_car_in_this_state',
      desc: '',
      args: [],
    );
  }

  /// `There are no start/stop in this time. Please choose other time!`
  String get message_notify_not_have_start_stop_points_in_this_time {
    return Intl.message(
      'There are no start/stop in this time. Please choose other time!',
      name: 'message_notify_not_have_start_stop_points_in_this_time',
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

  /// `Time start`
  String get string_begin_time {
    return Intl.message(
      'Time start',
      name: 'string_begin_time',
      desc: '',
      args: [],
    );
  }

  /// `Time end`
  String get string_end_time {
    return Intl.message(
      'Time end',
      name: 'string_end_time',
      desc: '',
      args: [],
    );
  }

  /// `None`
  String get string_none {
    return Intl.message(
      'None',
      name: 'string_none',
      desc: '',
      args: [],
    );
  }

  /// `Last photo`
  String get string_last_photo {
    return Intl.message(
      'Last photo',
      name: 'string_last_photo',
      desc: '',
      args: [],
    );
  }

  /// `All photo`
  String get string_all_photo {
    return Intl.message(
      'All photo',
      name: 'string_all_photo',
      desc: '',
      args: [],
    );
  }

  /// `Live stream`
  String get string_live_stream {
    return Intl.message(
      'Live stream',
      name: 'string_live_stream',
      desc: '',
      args: [],
    );
  }

  /// `Play back`
  String get string_play_back {
    return Intl.message(
      'Play back',
      name: 'string_play_back',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get string_summary_report {
    return Intl.message(
      'Summary',
      name: 'string_summary_report',
      desc: '',
      args: [],
    );
  }

  /// `Summary fuel`
  String get string_summary_fuel_report {
    return Intl.message(
      'Summary fuel',
      name: 'string_summary_fuel_report',
      desc: '',
      args: [],
    );
  }

  /// `Summary route`
  String get string_summary_route_report {
    return Intl.message(
      'Summary route',
      name: 'string_summary_route_report',
      desc: '',
      args: [],
    );
  }

  /// `Stop point`
  String get string_stop_point_report {
    return Intl.message(
      'Stop point',
      name: 'string_stop_point_report',
      desc: '',
      args: [],
    );
  }

  /// `stop parking`
  String get string_stop_parking_report {
    return Intl.message(
      'stop parking',
      name: 'string_stop_parking_report',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get string_temp_report {
    return Intl.message(
      'Temperature',
      name: 'string_temp_report',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get string_photo_report {
    return Intl.message(
      'Photo',
      name: 'string_photo_report',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get string_language {
    return Intl.message(
      'Languages',
      name: 'string_language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get string_english {
    return Intl.message(
      'English',
      name: 'string_english',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get string_spanish {
    return Intl.message(
      'Spanish',
      name: 'string_spanish',
      desc: '',
      args: [],
    );
  }

  /// `Chinese`
  String get string_Chinese {
    return Intl.message(
      'Chinese',
      name: 'string_Chinese',
      desc: '',
      args: [],
    );
  }

  /// `German`
  String get string_German {
    return Intl.message(
      'German',
      name: 'string_German',
      desc: '',
      args: [],
    );
  }

  /// `VietNamese`
  String get string_viet_names {
    return Intl.message(
      'VietNamese',
      name: 'string_viet_names',
      desc: '',
      args: [],
    );
  }

  /// `FFTSolution - Copyright 2024`
  String get copy_right {
    return Intl.message(
      'FFTSolution - Copyright 2024',
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

  /// `Device information`
  String get string_device_info {
    return Intl.message(
      'Device information',
      name: 'string_device_info',
      desc: '',
      args: [],
    );
  }

  /// `Command`
  String get string_device_command {
    return Intl.message(
      'Command',
      name: 'string_device_command',
      desc: '',
      args: [],
    );
  }

  /// `View log`
  String get string_device_log {
    return Intl.message(
      'View log',
      name: 'string_device_log',
      desc: '',
      args: [],
    );
  }

  /// `Device list`
  String get string_device_list {
    return Intl.message(
      'Device list',
      name: 'string_device_list',
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

  /// `No older messages`
  String get string_no_more_old_data {
    return Intl.message(
      'No older messages',
      name: 'string_no_more_old_data',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get report_group_summary {
    return Intl.message(
      'Summary',
      name: 'report_group_summary',
      desc: '',
      args: [],
    );
  }

  /// `Fuel`
  String get report_group_fuel {
    return Intl.message(
      'Fuel',
      name: 'report_group_fuel',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get report_group_device {
    return Intl.message(
      'Device',
      name: 'report_group_device',
      desc: '',
      args: [],
    );
  }

  /// `Trip`
  String get report_group_trip {
    return Intl.message(
      'Trip',
      name: 'report_group_trip',
      desc: '',
      args: [],
    );
  }

  /// `Sensor`
  String get report_group_sensor {
    return Intl.message(
      'Sensor',
      name: 'report_group_sensor',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get report_group_speed {
    return Intl.message(
      'Speed',
      name: 'report_group_speed',
      desc: '',
      args: [],
    );
  }

  /// `Geofence`
  String get report_group_geofence {
    return Intl.message(
      'Geofence',
      name: 'report_group_geofence',
      desc: '',
      args: [],
    );
  }

  /// `Summary by day`
  String get report_summary_by_day {
    return Intl.message(
      'Summary by day',
      name: 'report_summary_by_day',
      desc: '',
      args: [],
    );
  }

  /// `History data`
  String get report_history_data {
    return Intl.message(
      'History data',
      name: 'report_history_data',
      desc: '',
      args: [],
    );
  }

  /// `Summary by vehicle`
  String get report_summary_by_vehicle {
    return Intl.message(
      'Summary by vehicle',
      name: 'report_summary_by_vehicle',
      desc: '',
      args: [],
    );
  }

  /// `Summary by driver`
  String get report_summary_by_driver {
    return Intl.message(
      'Summary by driver',
      name: 'report_summary_by_driver',
      desc: '',
      args: [],
    );
  }

  /// `Summary transfer data`
  String get report_summary_tranfer_data {
    return Intl.message(
      'Summary transfer data',
      name: 'report_summary_tranfer_data',
      desc: '',
      args: [],
    );
  }

  /// `Fuel summary`
  String get report_fuel_summary {
    return Intl.message(
      'Fuel summary',
      name: 'report_fuel_summary',
      desc: '',
      args: [],
    );
  }

  /// `Fuel chart`
  String get report_fuel_chart {
    return Intl.message(
      'Fuel chart',
      name: 'report_fuel_chart',
      desc: '',
      args: [],
    );
  }

  /// `Fuel change`
  String get report_fuel_change {
    return Intl.message(
      'Fuel change',
      name: 'report_fuel_change',
      desc: '',
      args: [],
    );
  }

  /// `Device summary`
  String get report_device_summary {
    return Intl.message(
      'Device summary',
      name: 'report_device_summary',
      desc: '',
      args: [],
    );
  }

  /// `Device Status`
  String get report_device_status {
    return Intl.message(
      'Device Status',
      name: 'report_device_status',
      desc: '',
      args: [],
    );
  }

  /// `Status history`
  String get report_device_status_history {
    return Intl.message(
      'Status history',
      name: 'report_device_status_history',
      desc: '',
      args: [],
    );
  }

  /// `Engine on of Device`
  String get report_device_by_engine_on {
    return Intl.message(
      'Engine on of Device',
      name: 'report_device_by_engine_on',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get report_route {
    return Intl.message(
      'Route',
      name: 'report_route',
      desc: '',
      args: [],
    );
  }

  /// `Mini route`
  String get report_route_mini {
    return Intl.message(
      'Mini route',
      name: 'report_route_mini',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle trip`
  String get report_vehicle_trip {
    return Intl.message(
      'Vehicle trip',
      name: 'report_vehicle_trip',
      desc: '',
      args: [],
    );
  }

  /// `Continuous driving time`
  String get report_continuous_driving_time {
    return Intl.message(
      'Continuous driving time',
      name: 'report_continuous_driving_time',
      desc: '',
      args: [],
    );
  }

  /// `Stop parking`
  String get report_stop_parking {
    return Intl.message(
      'Stop parking',
      name: 'report_stop_parking',
      desc: '',
      args: [],
    );
  }

  /// `Driving time of day`
  String get report_on_day_driving_time {
    return Intl.message(
      'Driving time of day',
      name: 'report_on_day_driving_time',
      desc: '',
      args: [],
    );
  }

  /// `Photo of the vehicle's trip`
  String get report_photo_of_vehicle_trip {
    return Intl.message(
      'Photo of the vehicle\'s trip',
      name: 'report_photo_of_vehicle_trip',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get report_temperature {
    return Intl.message(
      'Temperature',
      name: 'report_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get report_speed {
    return Intl.message(
      'Speed',
      name: 'report_speed',
      desc: '',
      args: [],
    );
  }

  /// `Over speed`
  String get report_speed_over {
    return Intl.message(
      'Over speed',
      name: 'report_speed_over',
      desc: '',
      args: [],
    );
  }

  /// `Toll station`
  String get report_toll_station {
    return Intl.message(
      'Toll station',
      name: 'report_toll_station',
      desc: '',
      args: [],
    );
  }

  /// `Summary in and out of the Geofence`
  String get report_geofence_summary_in_out {
    return Intl.message(
      'Summary in and out of the Geofence',
      name: 'report_geofence_summary_in_out',
      desc: '',
      args: [],
    );
  }

  /// `Details in and out of the Geofence`
  String get report_geofence_detail_in_out {
    return Intl.message(
      'Details in and out of the Geofence',
      name: 'report_geofence_detail_in_out',
      desc: '',
      args: [],
    );
  }

  /// `Engine time`
  String get report_engine_time {
    return Intl.message(
      'Engine time',
      name: 'report_engine_time',
      desc: '',
      args: [],
    );
  }

  /// `Invalid`
  String get invalid_str {
    return Intl.message(
      'Invalid',
      name: 'invalid_str',
      desc: '',
      args: [],
    );
  }

  /// `Do not use`
  String get not_user {
    return Intl.message(
      'Do not use',
      name: 'not_user',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get status_open {
    return Intl.message(
      'Open',
      name: 'status_open',
      desc: '',
      args: [],
    );
  }

  /// `Off`
  String get status_off {
    return Intl.message(
      'Off',
      name: 'status_off',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get log_out {
    return Intl.message(
      'Logout',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Imei`
  String get str_imei {
    return Intl.message(
      'Imei',
      name: 'str_imei',
      desc: '',
      args: [],
    );
  }

  /// `Device Type`
  String get str_deviceType {
    return Intl.message(
      'Device Type',
      name: 'str_deviceType',
      desc: '',
      args: [],
    );
  }

  /// `Sim number`
  String get str_simNo {
    return Intl.message(
      'Sim number',
      name: 'str_simNo',
      desc: '',
      args: [],
    );
  }

  /// `Sim Type`
  String get str_simType {
    return Intl.message(
      'Sim Type',
      name: 'str_simType',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get str_username {
    return Intl.message(
      'Username',
      name: 'str_username',
      desc: '',
      args: [],
    );
  }

  /// `User Id`
  String get str_userId {
    return Intl.message(
      'User Id',
      name: 'str_userId',
      desc: '',
      args: [],
    );
  }

  /// `Activation status`
  String get str_active {
    return Intl.message(
      'Activation status',
      name: 'str_active',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get str_status {
    return Intl.message(
      'Status',
      name: 'str_status',
      desc: '',
      args: [],
    );
  }

  /// `Expiration Date`
  String get str_serviceExpire {
    return Intl.message(
      'Expiration Date',
      name: 'str_serviceExpire',
      desc: '',
      args: [],
    );
  }

  /// `License plate`
  String get str_vehiclePlate {
    return Intl.message(
      'License plate',
      name: 'str_vehiclePlate',
      desc: '',
      args: [],
    );
  }

  /// `Vin`
  String get str_vinNumber {
    return Intl.message(
      'Vin',
      name: 'str_vinNumber',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get str_frameNumber {
    return Intl.message(
      '',
      name: 'str_frameNumber',
      desc: '',
      args: [],
    );
  }

  /// `Device name`
  String get str_deviceName {
    return Intl.message(
      'Device name',
      name: 'str_deviceName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get str_description {
    return Intl.message(
      'Description',
      name: 'str_description',
      desc: '',
      args: [],
    );
  }

  /// `Generation time`
  String get str_createdAt {
    return Intl.message(
      'Generation time',
      name: 'str_createdAt',
      desc: '',
      args: [],
    );
  }

  /// `Created by user`
  String get str_createdBy {
    return Intl.message(
      'Created by user',
      name: 'str_createdBy',
      desc: '',
      args: [],
    );
  }

  /// `Warranty activation`
  String get str_warrantyActivation {
    return Intl.message(
      'Warranty activation',
      name: 'str_warrantyActivation',
      desc: '',
      args: [],
    );
  }

  /// `Warranty activation date`
  String get str_warrantyActivationDate {
    return Intl.message(
      'Warranty activation date',
      name: 'str_warrantyActivationDate',
      desc: '',
      args: [],
    );
  }

  /// `Warranty Expiration Date`
  String get str_warrantyExpired {
    return Intl.message(
      'Warranty Expiration Date',
      name: 'str_warrantyExpired',
      desc: '',
      args: [],
    );
  }

  /// `Tolls`
  String get str_usingTollFee {
    return Intl.message(
      'Tolls',
      name: 'str_usingTollFee',
      desc: '',
      args: [],
    );
  }

  /// `Battery`
  String get str_hasBattery {
    return Intl.message(
      'Battery',
      name: 'str_hasBattery',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get str_driverId {
    return Intl.message(
      '',
      name: 'str_driverId',
      desc: '',
      args: [],
    );
  }

  /// `Number of cameras`
  String get str_totalCamera {
    return Intl.message(
      'Number of cameras',
      name: 'str_totalCamera',
      desc: '',
      args: [],
    );
  }

  /// `Device Service`
  String get str_device_service {
    return Intl.message(
      'Device Service',
      name: 'str_device_service',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes_str {
    return Intl.message(
      'Yes',
      name: 'yes_str',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no_str {
    return Intl.message(
      'No',
      name: 'no_str',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle Status`
  String get str_status_car {
    return Intl.message(
      'Vehicle Status',
      name: 'str_status_car',
      desc: '',
      args: [],
    );
  }

  /// `Location and time`
  String get str_location_and_time {
    return Intl.message(
      'Location and time',
      name: 'str_location_and_time',
      desc: '',
      args: [],
    );
  }

  /// `I/O and fuel`
  String get str_io_and_engine {
    return Intl.message(
      'I/O and fuel',
      name: 'str_io_and_engine',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get str_long {
    return Intl.message(
      'Longitude',
      name: 'str_long',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get str_lat {
    return Intl.message(
      'Latitude',
      name: 'str_lat',
      desc: '',
      args: [],
    );
  }

  /// `Explosive machine`
  String get str_engine {
    return Intl.message(
      'Explosive machine',
      name: 'str_engine',
      desc: '',
      args: [],
    );
  }

  /// `Activated`
  String get str_activated {
    return Intl.message(
      'Activated',
      name: 'str_activated',
      desc: '',
      args: [],
    );
  }

  /// `Not activated yet`
  String get str_no_activated {
    return Intl.message(
      'Not activated yet',
      name: 'str_no_activated',
      desc: '',
      args: [],
    );
  }

  /// `No image`
  String get str_no_image {
    return Intl.message(
      'No image',
      name: 'str_no_image',
      desc: '',
      args: [],
    );
  }

  /// `Channel`
  String get str_channel {
    return Intl.message(
      'Channel',
      name: 'str_channel',
      desc: '',
      args: [],
    );
  }

  /// `This account has no device, please choose another account`
  String get str_not_device_in_acocunt {
    return Intl.message(
      'This account has no device, please choose another account',
      name: 'str_not_device_in_acocunt',
      desc: '',
      args: [],
    );
  }

  /// `This device has no sensor, please choose another device`
  String get str_not_sensor_in_device {
    return Intl.message(
      'This device has no sensor, please choose another device',
      name: 'str_not_sensor_in_device',
      desc: '',
      args: [],
    );
  }

  /// `This device has no other sensors`
  String get str_no_sensor_in_device {
    return Intl.message(
      'This device has no other sensors',
      name: 'str_no_sensor_in_device',
      desc: '',
      args: [],
    );
  }

  /// `This device does not have a camera, please choose another device`
  String get str_not_camera_in_device {
    return Intl.message(
      'This device does not have a camera, please choose another device',
      name: 'str_not_camera_in_device',
      desc: '',
      args: [],
    );
  }

  /// `This camera has no photos, please choose another camera`
  String get str_not_photo_in_camera {
    return Intl.message(
      'This camera has no photos, please choose another camera',
      name: 'str_not_photo_in_camera',
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

  /// `Select device`
  String get str_select_device {
    return Intl.message(
      'Select device',
      name: 'str_select_device',
      desc: '',
      args: [],
    );
  }

  /// `Select a device`
  String get str_select_a_device {
    return Intl.message(
      'Select a device',
      name: 'str_select_a_device',
      desc: '',
      args: [],
    );
  }

  /// `Select camera`
  String get str_select_camera {
    return Intl.message(
      'Select camera',
      name: 'str_select_camera',
      desc: '',
      args: [],
    );
  }

  /// `Select a camera`
  String get str_select_a_camera {
    return Intl.message(
      'Select a camera',
      name: 'str_select_a_camera',
      desc: '',
      args: [],
    );
  }

  /// `Select sensor`
  String get str_select_sensor {
    return Intl.message(
      'Select sensor',
      name: 'str_select_sensor',
      desc: '',
      args: [],
    );
  }

  /// `Select a sensor`
  String get str_select_a_sensor {
    return Intl.message(
      'Select a sensor',
      name: 'str_select_a_sensor',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get no_internet {
    return Intl.message(
      'No internet connection',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Temperature chart`
  String get temperature_chart {
    return Intl.message(
      'Temperature chart',
      name: 'temperature_chart',
      desc: '',
      args: [],
    );
  }

  /// `Temperature`
  String get str_temperature {
    return Intl.message(
      'Temperature',
      name: 'str_temperature',
      desc: '',
      args: [],
    );
  }

  /// `Send device command`
  String get str_device_command {
    return Intl.message(
      'Send device command',
      name: 'str_device_command',
      desc: '',
      args: [],
    );
  }

  /// `Log history`
  String get str_device_log {
    return Intl.message(
      'Log history',
      name: 'str_device_log',
      desc: '',
      args: [],
    );
  }

  /// `List of devices`
  String get str_device_list_info {
    return Intl.message(
      'List of devices',
      name: 'str_device_list_info',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get str_device_info {
    return Intl.message(
      'Information',
      name: 'str_device_info',
      desc: '',
      args: [],
    );
  }

  /// `Connected`
  String get str_connected {
    return Intl.message(
      'Connected',
      name: 'str_connected',
      desc: '',
      args: [],
    );
  }

  /// `Disconnected`
  String get str_disconnected {
    return Intl.message(
      'Disconnected',
      name: 'str_disconnected',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get str_clear {
    return Intl.message(
      'Clear',
      name: 'str_clear',
      desc: '',
      args: [],
    );
  }

  /// `Enter ASCII command`
  String get str_enter_ASCII {
    return Intl.message(
      'Enter ASCII command',
      name: 'str_enter_ASCII',
      desc: '',
      args: [],
    );
  }

  /// `Send ASCII`
  String get str_send_ASCII {
    return Intl.message(
      'Send ASCII',
      name: 'str_send_ASCII',
      desc: '',
      args: [],
    );
  }

  /// `Speed chart`
  String get speed_chart {
    return Intl.message(
      'Speed chart',
      name: 'speed_chart',
      desc: '',
      args: [],
    );
  }

  /// `Speed history`
  String get speed_history {
    return Intl.message(
      'Speed history',
      name: 'speed_history',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get str_speed {
    return Intl.message(
      'Speed',
      name: 'str_speed',
      desc: '',
      args: [],
    );
  }

  /// `Speeds`
  String get str_speeds {
    return Intl.message(
      'Speeds',
      name: 'str_speeds',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get str_time {
    return Intl.message(
      'Time',
      name: 'str_time',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get str_address {
    return Intl.message(
      'Address',
      name: 'str_address',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get str_note {
    return Intl.message(
      'Note',
      name: 'str_note',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get stt {
    return Intl.message(
      'No',
      name: 'stt',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get no_search_result {
    return Intl.message(
      'No data available',
      name: 'no_search_result',
      desc: '',
      args: [],
    );
  }

  /// `Verify your fingerprint for login`
  String get header_popup_fingerprint {
    return Intl.message(
      'Verify your fingerprint for login',
      name: 'header_popup_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Verify your biometrics for login`
  String get header_popup_biometric {
    return Intl.message(
      'Verify your biometrics for login',
      name: 'header_popup_biometric',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with fingerprint`
  String get title_popup_fingerprint {
    return Intl.message(
      'Sign in with fingerprint',
      name: 'title_popup_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Biometric login`
  String get title_popup_biometric {
    return Intl.message(
      'Biometric login',
      name: 'title_popup_biometric',
      desc: '',
      args: [],
    );
  }

  /// `Active FaceID`
  String get title_popup_faceid {
    return Intl.message(
      'Active FaceID',
      name: 'title_popup_faceid',
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

  /// `You have not set up face login. Please log in to your account with your password and face authentication settings`
  String get notify_setup_faceid {
    return Intl.message(
      'You have not set up face login. Please log in to your account with your password and face authentication settings',
      name: 'notify_setup_faceid',
      desc: '',
      args: [],
    );
  }

  /// `You have not set up fingerprint login. Please log in to your account with password and fingerprint authentication settings`
  String get notify_setup_fingerprint {
    return Intl.message(
      'You have not set up fingerprint login. Please log in to your account with password and fingerprint authentication settings',
      name: 'notify_setup_fingerprint',
      desc: '',
      args: [],
    );
  }

  /// `You have not set up biometric login. Please log in to your account with password and biometric authentication settings`
  String get notify_setup_biometric {
    return Intl.message(
      'You have not set up biometric login. Please log in to your account with password and biometric authentication settings',
      name: 'notify_setup_biometric',
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

  /// `Distance (km)`
  String get distance_km {
    return Intl.message(
      'Distance (km)',
      name: 'distance_km',
      desc: '',
      args: [],
    );
  }

  /// ` Engine startup time`
  String get duration_start_engine_start {
    return Intl.message(
      ' Engine startup time',
      name: 'duration_start_engine_start',
      desc: '',
      args: [],
    );
  }

  /// ` Engine stop time`
  String get duration_start_engine_idling {
    return Intl.message(
      ' Engine stop time',
      name: 'duration_start_engine_idling',
      desc: '',
      args: [],
    );
  }

  /// ` Engine parking time`
  String get duration_parking_engine_time {
    return Intl.message(
      ' Engine parking time',
      name: 'duration_parking_engine_time',
      desc: '',
      args: [],
    );
  }

  /// ` Total engine time`
  String get duration_engine_time {
    return Intl.message(
      ' Total engine time',
      name: 'duration_engine_time',
      desc: '',
      args: [],
    );
  }

  /// `Maximum speed`
  String get max_speed {
    return Intl.message(
      'Maximum speed',
      name: 'max_speed',
      desc: '',
      args: [],
    );
  }

  /// `Average speed`
  String get average_speed {
    return Intl.message(
      'Average speed',
      name: 'average_speed',
      desc: '',
      args: [],
    );
  }

  /// `Fuel Consume`
  String get fuel_consume {
    return Intl.message(
      'Fuel Consume',
      name: 'fuel_consume',
      desc: '',
      args: [],
    );
  }

  /// `Fuel add`
  String get fuel_add {
    return Intl.message(
      'Fuel add',
      name: 'fuel_add',
      desc: '',
      args: [],
    );
  }

  /// `Fuel remove`
  String get fuel_remove {
    return Intl.message(
      'Fuel remove',
      name: 'fuel_remove',
      desc: '',
      args: [],
    );
  }

  /// `Hello `
  String get welcome {
    return Intl.message(
      'Hello ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `User Info`
  String get user_info {
    return Intl.message(
      'User Info',
      name: 'user_info',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit_str {
    return Intl.message(
      'Edit',
      name: 'edit_str',
      desc: '',
      args: [],
    );
  }

  /// `Specifications`
  String get tech_info {
    return Intl.message(
      'Specifications',
      name: 'tech_info',
      desc: '',
      args: [],
    );
  }

  /// `Time zone`
  String get time_zone {
    return Intl.message(
      'Time zone',
      name: 'time_zone',
      desc: '',
      args: [],
    );
  }

  /// `Unit of distance`
  String get unit_distance {
    return Intl.message(
      'Unit of distance',
      name: 'unit_distance',
      desc: '',
      args: [],
    );
  }

  /// `Volume unit`
  String get unit_volume {
    return Intl.message(
      'Volume unit',
      name: 'unit_volume',
      desc: '',
      args: [],
    );
  }

  /// `Unit of weight`
  String get unit_weight {
    return Intl.message(
      'Unit of weight',
      name: 'unit_weight',
      desc: '',
      args: [],
    );
  }

  /// `Temperature unit`
  String get unit_temp {
    return Intl.message(
      'Temperature unit',
      name: 'unit_temp',
      desc: '',
      args: [],
    );
  }

  /// `Date format`
  String get unit_time {
    return Intl.message(
      'Date format',
      name: 'unit_time',
      desc: '',
      args: [],
    );
  }

  /// `Explosive history`
  String get engine_hours_history {
    return Intl.message(
      'Explosive history',
      name: 'engine_hours_history',
      desc: '',
      args: [],
    );
  }

  /// `From time`
  String get from_time {
    return Intl.message(
      'From time',
      name: 'from_time',
      desc: '',
      args: [],
    );
  }

  /// `To the time`
  String get to_time {
    return Intl.message(
      'To the time',
      name: 'to_time',
      desc: '',
      args: [],
    );
  }

  /// `Start point coordinates`
  String get location_start {
    return Intl.message(
      'Start point coordinates',
      name: 'location_start',
      desc: '',
      args: [],
    );
  }

  /// `End point coordinates`
  String get location_end {
    return Intl.message(
      'End point coordinates',
      name: 'location_end',
      desc: '',
      args: [],
    );
  }

  /// `Status hold time`
  String get time_keep_status {
    return Intl.message(
      'Status hold time',
      name: 'time_keep_status',
      desc: '',
      args: [],
    );
  }

  /// `Time to move`
  String get time_move {
    return Intl.message(
      'Time to move',
      name: 'time_move',
      desc: '',
      args: [],
    );
  }

  /// `Starting address`
  String get address_start {
    return Intl.message(
      'Starting address',
      name: 'address_start',
      desc: '',
      args: [],
    );
  }

  /// `End address`
  String get address_end {
    return Intl.message(
      'End address',
      name: 'address_end',
      desc: '',
      args: [],
    );
  }

  /// `Live environment`
  String get enviroment_live {
    return Intl.message(
      'Live environment',
      name: 'enviroment_live',
      desc: '',
      args: [],
    );
  }

  /// `Development environment`
  String get enviroment_develop {
    return Intl.message(
      'Development environment',
      name: 'enviroment_develop',
      desc: '',
      args: [],
    );
  }

  /// `Uat environment`
  String get enviroment_uat {
    return Intl.message(
      'Uat environment',
      name: 'enviroment_uat',
      desc: '',
      args: [],
    );
  }

  /// `environment permission`
  String get enviroment_permission {
    return Intl.message(
      'environment permission',
      name: 'enviroment_permission',
      desc: '',
      args: [],
    );
  }

  /// `Enter old password`
  String get type_old_password {
    return Intl.message(
      'Enter old password',
      name: 'type_old_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new password`
  String get type_new_password {
    return Intl.message(
      'Enter a new password',
      name: 'type_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter new password`
  String get type_new_password_again {
    return Intl.message(
      'Re-enter new password',
      name: 'type_new_password_again',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get old_password {
    return Intl.message(
      'Old password',
      name: 'old_password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get new_password {
    return Intl.message(
      'New password',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get new_password_confirm {
    return Intl.message(
      'Confirm new password',
      name: 'new_password_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Old password cannot be blank`
  String get old_password_not_empty {
    return Intl.message(
      'Old password cannot be blank',
      name: 'old_password_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `New password cannot be empty`
  String get new_password_not_empty {
    return Intl.message(
      'New password cannot be empty',
      name: 'new_password_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password cannot be empty`
  String get new_password_confirm_not_empty {
    return Intl.message(
      'Confirm new password cannot be empty',
      name: 'new_password_confirm_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `New password and confirm new password do not match`
  String get new_password_and_confirm_not_simple {
    return Intl.message(
      'New password and confirm new password do not match',
      name: 'new_password_and_confirm_not_simple',
      desc: '',
      args: [],
    );
  }

  /// `Old pin code cannot be empty`
  String get old_pin_code_not_empty {
    return Intl.message(
      'Old pin code cannot be empty',
      name: 'old_pin_code_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `New pin code cannot be empty`
  String get new_pin_code_not_empty {
    return Intl.message(
      'New pin code cannot be empty',
      name: 'new_pin_code_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new pin code cannot be empty`
  String get new_pin_code_confirm_not_empty {
    return Intl.message(
      'Confirm new pin code cannot be empty',
      name: 'new_pin_code_confirm_not_empty',
      desc: '',
      args: [],
    );
  }

  /// `New pin code and confirm new pin code do not match`
  String get new_pin_code_and_confirm_not_simple {
    return Intl.message(
      'New pin code and confirm new pin code do not match',
      name: 'new_pin_code_and_confirm_not_simple',
      desc: '',
      args: [],
    );
  }

  /// `Geofence manager`
  String get geofence_list {
    return Intl.message(
      'Geofence manager',
      name: 'geofence_list',
      desc: '',
      args: [],
    );
  }

  /// `Create geofence`
  String get geofence_create {
    return Intl.message(
      'Create geofence',
      name: 'geofence_create',
      desc: '',
      args: [],
    );
  }

  /// `Edit geofence`
  String get geofence_edit {
    return Intl.message(
      'Edit geofence',
      name: 'geofence_edit',
      desc: '',
      args: [],
    );
  }

  /// `Delete geofence`
  String get geofence_delete {
    return Intl.message(
      'Delete geofence',
      name: 'geofence_delete',
      desc: '',
      args: [],
    );
  }

  /// `Geofence manager`
  String get geofence_manager {
    return Intl.message(
      'Geofence manager',
      name: 'geofence_manager',
      desc: '',
      args: [],
    );
  }

  /// `Create geofence`
  String get geofence_create1 {
    return Intl.message(
      'Create geofence',
      name: 'geofence_create1',
      desc: '',
      args: [],
    );
  }

  /// `Geofence name`
  String get geofence_name {
    return Intl.message(
      'Geofence name',
      name: 'geofence_name',
      desc: '',
      args: [],
    );
  }

  /// `Geofence type`
  String get geofence_type {
    return Intl.message(
      'Geofence type',
      name: 'geofence_type',
      desc: '',
      args: [],
    );
  }

  /// `Bg color`
  String get color_fill {
    return Intl.message(
      'Bg color',
      name: 'color_fill',
      desc: '',
      args: [],
    );
  }

  /// `Border color`
  String get color_border {
    return Intl.message(
      'Border color',
      name: 'color_border',
      desc: '',
      args: [],
    );
  }

  /// `Opacity`
  String get opacity_value {
    return Intl.message(
      'Opacity',
      name: 'opacity_value',
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

  /// `End border color`
  String get color_border_final {
    return Intl.message(
      'End border color',
      name: 'color_border_final',
      desc: '',
      args: [],
    );
  }

  /// `Last Bg color`
  String get color_fill_final {
    return Intl.message(
      'Last Bg color',
      name: 'color_fill_final',
      desc: '',
      args: [],
    );
  }

  /// `Recreate`
  String get re_create {
    return Intl.message(
      'Recreate',
      name: 're_create',
      desc: '',
      args: [],
    );
  }

  /// `Please click on the point you want to create on the map to create an area`
  String get create_polygon_note {
    return Intl.message(
      'Please click on the point you want to create on the map to create an area',
      name: 'create_polygon_note',
      desc: '',
      args: [],
    );
  }

  /// `Select area style`
  String get select_geo_type {
    return Intl.message(
      'Select area style',
      name: 'select_geo_type',
      desc: '',
      args: [],
    );
  }

  /// `Radius`
  String get radius_str {
    return Intl.message(
      'Radius',
      name: 'radius_str',
      desc: '',
      args: [],
    );
  }

  /// `Function is under development. Please try again later!`
  String get develop_page {
    return Intl.message(
      'Function is under development. Please try again later!',
      name: 'develop_page',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to delete the region`
  String get geofence_delete_confirm {
    return Intl.message(
      'Are you sure to delete the region',
      name: 'geofence_delete_confirm',
      desc: '',
      args: [],
    );
  }

  /// `All devices`
  String get map_all_device {
    return Intl.message(
      'All devices',
      name: 'map_all_device',
      desc: '',
      args: [],
    );
  }

  /// `Directorate of Roads`
  String get ministry_of_transport {
    return Intl.message(
      'Directorate of Roads',
      name: 'ministry_of_transport',
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

  /// `Service support`
  String get support_pay {
    return Intl.message(
      'Service support',
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

  /// `Number of times entering the area`
  String get str_enter_number {
    return Intl.message(
      'Number of times entering the area',
      name: 'str_enter_number',
      desc: '',
      args: [],
    );
  }

  /// `Number of exits`
  String get str_exit_number {
    return Intl.message(
      'Number of exits',
      name: 'str_exit_number',
      desc: '',
      args: [],
    );
  }

  /// `Time in area`
  String get str_time_in_geo {
    return Intl.message(
      'Time in area',
      name: 'str_time_in_geo',
      desc: '',
      args: [],
    );
  }

  /// `The device has expired service, please renew the service to use these functions!`
  String get str_device_expire_service {
    return Intl.message(
      'The device has expired service, please renew the service to use these functions!',
      name: 'str_device_expire_service',
      desc: '',
      args: [],
    );
  }

  /// `Route`
  String get state_type_route {
    return Intl.message(
      'Route',
      name: 'state_type_route',
      desc: '',
      args: [],
    );
  }

  /// `Engine`
  String get state_type_engine {
    return Intl.message(
      'Engine',
      name: 'state_type_engine',
      desc: '',
      args: [],
    );
  }

  /// `Air conditioner`
  String get state_type_air {
    return Intl.message(
      'Air conditioner',
      name: 'state_type_air',
      desc: '',
      args: [],
    );
  }

  /// `State type`
  String get state_type {
    return Intl.message(
      'State type',
      name: 'state_type',
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

  /// `Recover pin code`
  String get str_reset_password {
    return Intl.message(
      'Recover pin code',
      name: 'str_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the phone you registered with!`
  String get str_reset_password_note {
    return Intl.message(
      'Please enter the phone you registered with!',
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

  /// `Password refresh information has been sent to your mailbox, please check and follow the instructions!`
  String get str_reset_password_notify {
    return Intl.message(
      'Password refresh information has been sent to your mailbox, please check and follow the instructions!',
      name: 'str_reset_password_notify',
      desc: '',
      args: [],
    );
  }

  /// `The app needs to access location data to view the map, please allow it!`
  String get location_permission {
    return Intl.message(
      'The app needs to access location data to view the map, please allow it!',
      name: 'location_permission',
      desc: '',
      args: [],
    );
  }

  /// `Capacity`
  String get str_capacity {
    return Intl.message(
      'Capacity',
      name: 'str_capacity',
      desc: '',
      args: [],
    );
  }

  /// `Previous capacity`
  String get str_capacity_start {
    return Intl.message(
      'Previous capacity',
      name: 'str_capacity_start',
      desc: '',
      args: [],
    );
  }

  /// `Capacity after`
  String get str_capacity_end {
    return Intl.message(
      'Capacity after',
      name: 'str_capacity_end',
      desc: '',
      args: [],
    );
  }

  /// `Capacity change`
  String get str_capacity_change {
    return Intl.message(
      'Capacity change',
      name: 'str_capacity_change',
      desc: '',
      args: [],
    );
  }

  /// `List of control command`
  String get str_command_control {
    return Intl.message(
      'List of control command',
      name: 'str_command_control',
      desc: '',
      args: [],
    );
  }

  /// `Page not found`
  String get page_not_found {
    return Intl.message(
      'Page not found',
      name: 'page_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Book Slot`
  String get book_a_slot {
    return Intl.message(
      'Book Slot',
      name: 'book_a_slot',
      desc: '',
      args: [],
    );
  }

  /// `Select your Vehicle Type`
  String get select_vehicle_type {
    return Intl.message(
      'Select your Vehicle Type',
      name: 'select_vehicle_type',
      desc: '',
      args: [],
    );
  }

  /// `Select your Vehicle Model`
  String get select_vehicle_model {
    return Intl.message(
      'Select your Vehicle Model',
      name: 'select_vehicle_model',
      desc: '',
      args: [],
    );
  }

  /// `Select your Vehicle Charge Type`
  String get select_vehicle_fuel {
    return Intl.message(
      'Select your Vehicle Charge Type',
      name: 'select_vehicle_fuel',
      desc: '',
      args: [],
    );
  }

  /// `Select Connection Type`
  String get select_connection_type {
    return Intl.message(
      'Select Connection Type',
      name: 'select_connection_type',
      desc: '',
      args: [],
    );
  }

  /// `Select Date For Your Slot`
  String get select_date_for_your_slot {
    return Intl.message(
      'Select Date For Your Slot',
      name: 'select_date_for_your_slot',
      desc: '',
      args: [],
    );
  }

  /// `Select Date`
  String get select_date {
    return Intl.message(
      'Select Date',
      name: 'select_date',
      desc: '',
      args: [],
    );
  }

  /// `Please Fill That All Detail For Me To Start Your Booking Slot `
  String get please_fill_all_detail_info {
    return Intl.message(
      'Please Fill That All Detail For Me To Start Your Booking Slot ',
      name: 'please_fill_all_detail_info',
      desc: '',
      args: [],
    );
  }

  /// `Honda e`
  String get vehicle_type_honda_e {
    return Intl.message(
      'Honda e',
      name: 'vehicle_type_honda_e',
      desc: '',
      args: [],
    );
  }

  /// `Slot Date`
  String get slot_date {
    return Intl.message(
      'Slot Date',
      name: 'slot_date',
      desc: '',
      args: [],
    );
  }

  /// `Slot time`
  String get slot_time {
    return Intl.message(
      'Slot time',
      name: 'slot_time',
      desc: '',
      args: [],
    );
  }

  /// `Connection Type`
  String get connection_type {
    return Intl.message(
      'Connection Type',
      name: 'connection_type',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price_str {
    return Intl.message(
      'Price',
      name: 'price_str',
      desc: '',
      args: [],
    );
  }

  /// `Set fix amount of charging`
  String get set_fix_amount_of_charging {
    return Intl.message(
      'Set fix amount of charging',
      name: 'set_fix_amount_of_charging',
      desc: '',
      args: [],
    );
  }

  /// `Booking No: `
  String get book_no {
    return Intl.message(
      'Booking No: ',
      name: 'book_no',
      desc: '',
      args: [],
    );
  }

  /// `Fuel Type`
  String get fuel_type {
    return Intl.message(
      'Fuel Type',
      name: 'fuel_type',
      desc: '',
      args: [],
    );
  }

  /// `Charge point id`
  String get charge_point_id {
    return Intl.message(
      'Charge point id',
      name: 'charge_point_id',
      desc: '',
      args: [],
    );
  }

  /// `Total Payment`
  String get total_payment {
    return Intl.message(
      'Total Payment',
      name: 'total_payment',
      desc: '',
      args: [],
    );
  }

  /// `Payment Receipt`
  String get payment_receipt {
    return Intl.message(
      'Payment Receipt',
      name: 'payment_receipt',
      desc: '',
      args: [],
    );
  }

  /// `Boooking detail `
  String get booking_detail {
    return Intl.message(
      'Boooking detail ',
      name: 'booking_detail',
      desc: '',
      args: [],
    );
  }

  /// `Scan this code to link accounts or payment !`
  String get scan_this_code_for_more_detail {
    return Intl.message(
      'Scan this code to link accounts or payment !',
      name: 'scan_this_code_for_more_detail',
      desc: '',
      args: [],
    );
  }

  /// `Your reservation`
  String get your_reservation {
    return Intl.message(
      'Your reservation',
      name: 'your_reservation',
      desc: '',
      args: [],
    );
  }

  /// `Booking number`
  String get booking_number {
    return Intl.message(
      'Booking number',
      name: 'booking_number',
      desc: '',
      args: [],
    );
  }

  /// `Start Time`
  String get start_time {
    return Intl.message(
      'Start Time',
      name: 'start_time',
      desc: '',
      args: [],
    );
  }

  /// `Total pay`
  String get total_pay {
    return Intl.message(
      'Total pay',
      name: 'total_pay',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get card_number {
    return Intl.message(
      'Card Number',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `CardHolder Name`
  String get card_holder_name {
    return Intl.message(
      'CardHolder Name',
      name: 'card_holder_name',
      desc: '',
      args: [],
    );
  }

  /// `Expire Date`
  String get expire_date {
    return Intl.message(
      'Expire Date',
      name: 'expire_date',
      desc: '',
      args: [],
    );
  }

  /// `CVV Number`
  String get CVV_number {
    return Intl.message(
      'CVV Number',
      name: 'CVV_number',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get CVV_str {
    return Intl.message(
      'CVV',
      name: 'CVV_str',
      desc: '',
      args: [],
    );
  }

  /// `The last three number on the back of your card`
  String get the_last_three_number_on_the_back_of_your_card {
    return Intl.message(
      'The last three number on the back of your card',
      name: 'the_last_three_number_on_the_back_of_your_card',
      desc: '',
      args: [],
    );
  }

  /// `Save This informattion for future payment`
  String get save_this_informattion_for_future_payment {
    return Intl.message(
      'Save This informattion for future payment',
      name: 'save_this_informattion_for_future_payment',
      desc: '',
      args: [],
    );
  }

  /// `Saved Slots`
  String get saved_slots {
    return Intl.message(
      'Saved Slots',
      name: 'saved_slots',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete all saved slots?`
  String get do_you_want_to_delete_all_saved_slots {
    return Intl.message(
      'Do you want to delete all saved slots?',
      name: 'do_you_want_to_delete_all_saved_slots',
      desc: '',
      args: [],
    );
  }

  /// `Delete All`
  String get delete_all {
    return Intl.message(
      'Delete All',
      name: 'delete_all',
      desc: '',
      args: [],
    );
  }

  /// `View Detail`
  String get view_detail {
    return Intl.message(
      'View Detail',
      name: 'view_detail',
      desc: '',
      args: [],
    );
  }

  /// `View Slot Detail`
  String get view_slot {
    return Intl.message(
      'View Slot Detail',
      name: 'view_slot',
      desc: '',
      args: [],
    );
  }

  /// `Start Charging`
  String get start_charging {
    return Intl.message(
      'Start Charging',
      name: 'start_charging',
      desc: '',
      args: [],
    );
  }

  /// `Delete Slot`
  String get delete_slot {
    return Intl.message(
      'Delete Slot',
      name: 'delete_slot',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed_str {
    return Intl.message(
      'Completed',
      name: 'completed_str',
      desc: '',
      args: [],
    );
  }

  /// `Charging`
  String get charging_str {
    return Intl.message(
      'Charging',
      name: 'charging_str',
      desc: '',
      args: [],
    );
  }

  /// `Duration`
  String get duration_str {
    return Intl.message(
      'Duration',
      name: 'duration_str',
      desc: '',
      args: [],
    );
  }

  /// `Time To Charge`
  String get time_to_charge {
    return Intl.message(
      'Time To Charge',
      name: 'time_to_charge',
      desc: '',
      args: [],
    );
  }

  /// `Stop Charging`
  String get stop_charging {
    return Intl.message(
      'Stop Charging',
      name: 'stop_charging',
      desc: '',
      args: [],
    );
  }

  /// `Pause Charging`
  String get pause_charging {
    return Intl.message(
      'Pause Charging',
      name: 'pause_charging',
      desc: '',
      args: [],
    );
  }

  /// `Rebook Slot`
  String get rebook_slot {
    return Intl.message(
      'Rebook Slot',
      name: 'rebook_slot',
      desc: '',
      args: [],
    );
  }

  /// `Add Address`
  String get add_address {
    return Intl.message(
      'Add Address',
      name: 'add_address',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get your_location {
    return Intl.message(
      'Your Location',
      name: 'your_location',
      desc: '',
      args: [],
    );
  }

  /// `Tag This Location`
  String get tag_this_location {
    return Intl.message(
      'Tag This Location',
      name: 'tag_this_location',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get save_address {
    return Intl.message(
      'Save Address',
      name: 'save_address',
      desc: '',
      args: [],
    );
  }

  /// `Sucessfully !`
  String get sucessfully_str {
    return Intl.message(
      'Sucessfully !',
      name: 'sucessfully_str',
      desc: '',
      args: [],
    );
  }

  /// `Your vehicle added sucessfully in your list`
  String get your_vehicle_added_sucessfully_in_your_list {
    return Intl.message(
      'Your vehicle added sucessfully in your list',
      name: 'your_vehicle_added_sucessfully_in_your_list',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been changed sucessfully !`
  String get password_changed_sucessfully {
    return Intl.message(
      'Your password has been changed sucessfully !',
      name: 'password_changed_sucessfully',
      desc: '',
      args: [],
    );
  }

  /// `You have been sucessfully completed for Sign in`
  String get sucessfully_completed_for_sign_in {
    return Intl.message(
      'You have been sucessfully completed for Sign in',
      name: 'sucessfully_completed_for_sign_in',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok_str {
    return Intl.message(
      'Ok',
      name: 'ok_str',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get select_location {
    return Intl.message(
      'Select Location',
      name: 'select_location',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get add_new_address {
    return Intl.message(
      'Add New Address',
      name: 'add_new_address',
      desc: '',
      args: [],
    );
  }

  /// `My Booking`
  String get my_booking {
    return Intl.message(
      'My Booking',
      name: 'my_booking',
      desc: '',
      args: [],
    );
  }

  /// `Remove All`
  String get remove_all {
    return Intl.message(
      'Remove All',
      name: 'remove_all',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get created_str {
    return Intl.message(
      'Created',
      name: 'created_str',
      desc: '',
      args: [],
    );
  }

  /// `Charging`
  String get ongoing_str {
    return Intl.message(
      'Charging',
      name: 'ongoing_str',
      desc: '',
      args: [],
    );
  }

  /// `Booked`
  String get booked_str {
    return Intl.message(
      'Booked',
      name: 'booked_str',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get history_str {
    return Intl.message(
      'Completed',
      name: 'history_str',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get expired_str {
    return Intl.message(
      'Expired',
      name: 'expired_str',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get cancel_str {
    return Intl.message(
      'Canceled',
      name: 'cancel_str',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled_str {
    return Intl.message(
      'Canceled',
      name: 'canceled_str',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message(
      'See All',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Near by me`
  String get near_by_me {
    return Intl.message(
      'Near by me',
      name: 'near_by_me',
      desc: '',
      args: [],
    );
  }

  /// `change Location`
  String get change_location {
    return Intl.message(
      'change Location',
      name: 'change_location',
      desc: '',
      args: [],
    );
  }

  /// `Choose EV Charger Near by you`
  String get choose_EV_charger_near_by_you {
    return Intl.message(
      'Choose EV Charger Near by you',
      name: 'choose_EV_charger_near_by_you',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile_str {
    return Intl.message(
      'Profile',
      name: 'profile_str',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get my_profile {
    return Intl.message(
      'My Profile',
      name: 'my_profile',
      desc: '',
      args: [],
    );
  }

  /// `My Car`
  String get my_car {
    return Intl.message(
      'My Car',
      name: 'my_car',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting_str {
    return Intl.message(
      'Setting',
      name: 'setting_str',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip_str {
    return Intl.message(
      'Skip',
      name: 'skip_str',
      desc: '',
      args: [],
    );
  }

  /// `Select my current location`
  String get select_my_current_location {
    return Intl.message(
      'Select my current location',
      name: 'select_my_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Select Address`
  String get select_address {
    return Intl.message(
      'Select Address',
      name: 'select_address',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open_str {
    return Intl.message(
      'Open',
      name: 'open_str',
      desc: '',
      args: [],
    );
  }

  /// `Connection`
  String get connection_str {
    return Intl.message(
      'Connection',
      name: 'connection_str',
      desc: '',
      args: [],
    );
  }

  /// `Distances`
  String get distances_str {
    return Intl.message(
      'Distances',
      name: 'distances_str',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Your new password must  be different from previous used passwords.`
  String get new_password_different_previous_passwords {
    return Intl.message(
      'Your new password must  be different from previous used passwords.',
      name: 'new_password_different_previous_passwords',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Password`
  String get repeat_password {
    return Intl.message(
      'Repeat Password',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message(
      'Remember me',
      name: 'remember_me',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit_str {
    return Intl.message(
      'Submit',
      name: 'submit_str',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email Address For Forgot Password`
  String get enter_your_email_address_for_forgot_password {
    return Intl.message(
      'Enter Your Email Address For Forgot Password',
      name: 'enter_your_email_address_for_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continue_str {
    return Intl.message(
      'Continue',
      name: 'continue_str',
      desc: '',
      args: [],
    );
  }

  /// `Add Vehicle`
  String get add_vehicle {
    return Intl.message(
      'Add Vehicle',
      name: 'add_vehicle',
      desc: '',
      args: [],
    );
  }

  /// `If you want to add new vechile please fill that all detail carefully ..`
  String get add_new_vechile_all_detail {
    return Intl.message(
      'If you want to add new vechile please fill that all detail carefully ..',
      name: 'add_new_vechile_all_detail',
      desc: '',
      args: [],
    );
  }

  /// `Select your vehicle charge type`
  String get select_your_vehicle_charge_type {
    return Intl.message(
      'Select your vehicle charge type',
      name: 'select_your_vehicle_charge_type',
      desc: '',
      args: [],
    );
  }

  /// `Input avrage Of vechile`
  String get input_avrage_of_vechile {
    return Intl.message(
      'Input avrage Of vechile',
      name: 'input_avrage_of_vechile',
      desc: '',
      args: [],
    );
  }

  /// `Input time Of full charging`
  String get input_time_of_full_charging {
    return Intl.message(
      'Input time Of full charging',
      name: 'input_time_of_full_charging',
      desc: '',
      args: [],
    );
  }

  /// `Input number of vehicle`
  String get input_number_of_vehicle {
    return Intl.message(
      'Input number of vehicle',
      name: 'input_number_of_vehicle',
      desc: '',
      args: [],
    );
  }

  /// `Charge Time`
  String get charge_time {
    return Intl.message(
      'Charge Time',
      name: 'charge_time',
      desc: '',
      args: [],
    );
  }

  /// `Previous Charged`
  String get previous_charged {
    return Intl.message(
      'Previous Charged',
      name: 'previous_charged',
      desc: '',
      args: [],
    );
  }

  /// `Previous Slot Station`
  String get previous_slot_station {
    return Intl.message(
      'Previous Slot Station',
      name: 'previous_slot_station',
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

  /// `PICK AVAIABLE SLOT `
  String get pick_avaiable_slot {
    return Intl.message(
      'PICK AVAIABLE SLOT ',
      name: 'pick_avaiable_slot',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get full_view {
    return Intl.message(
      'Information',
      name: 'full_view',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews_str {
    return Intl.message(
      'Reviews',
      name: 'reviews_str',
      desc: '',
      args: [],
    );
  }

  /// `Photos`
  String get photos_str {
    return Intl.message(
      'Photos',
      name: 'photos_str',
      desc: '',
      args: [],
    );
  }

  /// `Rating & Review`
  String get rating_review {
    return Intl.message(
      'Rating & Review',
      name: 'rating_review',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get view_all {
    return Intl.message(
      'View All',
      name: 'view_all',
      desc: '',
      args: [],
    );
  }

  /// `Write A Review`
  String get write_a_review {
    return Intl.message(
      'Write A Review',
      name: 'write_a_review',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `1. Types of Data we collect`
  String get types_of_data_we_collect {
    return Intl.message(
      '1. Types of Data we collect',
      name: 'types_of_data_we_collect',
      desc: '',
      args: [],
    );
  }

  /// `2. Use of your personal Data`
  String get use_of_your_personal_data {
    return Intl.message(
      '2. Use of your personal Data',
      name: 'use_of_your_personal_data',
      desc: '',
      args: [],
    );
  }

  /// `3.Disclosure of your personal Data`
  String get disclosure_of_your_personal_data {
    return Intl.message(
      '3.Disclosure of your personal Data',
      name: 'disclosure_of_your_personal_data',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `You don’t have any ongoing charging Right Now !`
  String get you_do_not_have_any_ongoing_charging {
    return Intl.message(
      'You don’t have any ongoing charging Right Now !',
      name: 'you_do_not_have_any_ongoing_charging',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this slot?`
  String get do_you_want_to_delete_this_slot {
    return Intl.message(
      'Do you want to delete this slot?',
      name: 'do_you_want_to_delete_this_slot',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to use your current location?`
  String get would_you_like_to_use_your_current_location {
    return Intl.message(
      'Would you like to use your current location?',
      name: 'would_you_like_to_use_your_current_location',
      desc: '',
      args: [],
    );
  }

  /// `ChargePoint Charging Station`
  String get charge_point_charging_station {
    return Intl.message(
      'ChargePoint Charging Station',
      name: 'charge_point_charging_station',
      desc: '',
      args: [],
    );
  }

  /// `Enter detail to sign up your account`
  String get enter_detail_to_sign_up_your_account {
    return Intl.message(
      'Enter detail to sign up your account',
      name: 'enter_detail_to_sign_up_your_account',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Number`
  String get mobile_number {
    return Intl.message(
      'Mobile Number',
      name: 'mobile_number',
      desc: '',
      args: [],
    );
  }

  /// `I Agree with `
  String get i_agree_with {
    return Intl.message(
      'I Agree with ',
      name: 'i_agree_with',
      desc: '',
      args: [],
    );
  }

  /// `Terms And Privacy`
  String get terms_and_privacy {
    return Intl.message(
      'Terms And Privacy',
      name: 'terms_and_privacy',
      desc: '',
      args: [],
    );
  }

  /// `Already have an Account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an Account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Enter Code Sent to Your Phone`
  String get enter_code_sent_to_your_phone {
    return Intl.message(
      'Enter Code Sent to Your Phone',
      name: 'enter_code_sent_to_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `We sent It to the number`
  String get we_sent_it_to_the_number {
    return Intl.message(
      'We sent It to the number',
      name: 'we_sent_it_to_the_number',
      desc: '',
      args: [],
    );
  }

  /// `Didn’t receive Code? `
  String get did_not_receive_code {
    return Intl.message(
      'Didn’t receive Code? ',
      name: 'did_not_receive_code',
      desc: '',
      args: [],
    );
  }

  /// `Send through Call`
  String get send_through_call {
    return Intl.message(
      'Send through Call',
      name: 'send_through_call',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next_str {
    return Intl.message(
      'Next',
      name: 'next_str',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Slot`
  String get confirm_slot {
    return Intl.message(
      'Confirm Slot',
      name: 'confirm_slot',
      desc: '',
      args: [],
    );
  }

  /// `Download `
  String get download_str {
    return Intl.message(
      'Download ',
      name: 'download_str',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share_str {
    return Intl.message(
      'Share',
      name: 'share_str',
      desc: '',
      args: [],
    );
  }

  /// `Confirm and Pay`
  String get confirm_and_pay {
    return Intl.message(
      'Confirm and Pay',
      name: 'confirm_and_pay',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view_str {
    return Intl.message(
      'View',
      name: 'view_str',
      desc: '',
      args: [],
    );
  }

  /// `Not Now`
  String get not_now {
    return Intl.message(
      'Not Now',
      name: 'not_now',
      desc: '',
      args: [],
    );
  }

  /// `Add New Vehicle`
  String get add_new_vehicle {
    return Intl.message(
      'Add New Vehicle',
      name: 'add_new_vehicle',
      desc: '',
      args: [],
    );
  }

  /// `Save Slot`
  String get save_slot {
    return Intl.message(
      'Save Slot',
      name: 'save_slot',
      desc: '',
      args: [],
    );
  }

  /// `Save Profile`
  String get save_profile {
    return Intl.message(
      'Save Profile',
      name: 'save_profile',
      desc: '',
      args: [],
    );
  }

  /// `verify`
  String get verify_str {
    return Intl.message(
      'verify',
      name: 'verify_str',
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

  /// `User detail`
  String get user_detail {
    return Intl.message(
      'User detail',
      name: 'user_detail',
      desc: '',
      args: [],
    );
  }

  /// `Parent account`
  String get parent_account {
    return Intl.message(
      'Parent account',
      name: 'parent_account',
      desc: '',
      args: [],
    );
  }

  /// `Create user success`
  String get create_user_success {
    return Intl.message(
      'Create user success',
      name: 'create_user_success',
      desc: '',
      args: [],
    );
  }

  /// `Pin code`
  String get pin_code {
    return Intl.message(
      'Pin code',
      name: 'pin_code',
      desc: '',
      args: [],
    );
  }

  /// `OTP code`
  String get otp_code {
    return Intl.message(
      'OTP code',
      name: 'otp_code',
      desc: '',
      args: [],
    );
  }

  /// `Pin`
  String get pin_str {
    return Intl.message(
      'Pin',
      name: 'pin_str',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otp_str {
    return Intl.message(
      'OTP',
      name: 'otp_str',
      desc: '',
      args: [],
    );
  }

  /// `Login with pin code`
  String get login_by_pin_code {
    return Intl.message(
      'Login with pin code',
      name: 'login_by_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Login with otp code`
  String get login_by_otp_code {
    return Intl.message(
      'Login with otp code',
      name: 'login_by_otp_code',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify_otp {
    return Intl.message(
      'Verify',
      name: 'verify_otp',
      desc: '',
      args: [],
    );
  }

  /// `User your phone number to signup`
  String get use_phone_to_signup {
    return Intl.message(
      'User your phone number to signup',
      name: 'use_phone_to_signup',
      desc: '',
      args: [],
    );
  }

  /// `Type verify code`
  String get type_verify_code {
    return Intl.message(
      'Type verify code',
      name: 'type_verify_code',
      desc: '',
      args: [],
    );
  }

  /// `Change pin code`
  String get change_pin {
    return Intl.message(
      'Change pin code',
      name: 'change_pin',
      desc: '',
      args: [],
    );
  }

  /// `Current pin code`
  String get old_pin {
    return Intl.message(
      'Current pin code',
      name: 'old_pin',
      desc: '',
      args: [],
    );
  }

  /// `New pin code`
  String get new_pin {
    return Intl.message(
      'New pin code',
      name: 'new_pin',
      desc: '',
      args: [],
    );
  }

  /// `Type new pin code again`
  String get new_pin_again {
    return Intl.message(
      'Type new pin code again',
      name: 'new_pin_again',
      desc: '',
      args: [],
    );
  }

  /// `No account needed, click for scan QR code`
  String get not_need_account {
    return Intl.message(
      'No account needed, click for scan QR code',
      name: 'not_need_account',
      desc: '',
      args: [],
    );
  }

  /// `Scan code`
  String get scan_qr_code {
    return Intl.message(
      'Scan code',
      name: 'scan_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `OPEN  24 Hours `
  String get open_24_in_7 {
    return Intl.message(
      'OPEN  24 Hours ',
      name: 'open_24_in_7',
      desc: '',
      args: [],
    );
  }

  /// `Charging capacity`
  String get charging_capacity_str {
    return Intl.message(
      'Charging capacity',
      name: 'charging_capacity_str',
      desc: '',
      args: [],
    );
  }

  /// `Connector number`
  String get charging_connector_number {
    return Intl.message(
      'Connector number',
      name: 'charging_connector_number',
      desc: '',
      args: [],
    );
  }

  /// `Select connector`
  String get select_charge_connector {
    return Intl.message(
      'Select connector',
      name: 'select_charge_connector',
      desc: '',
      args: [],
    );
  }

  /// `Charge now`
  String get charge_now {
    return Intl.message(
      'Charge now',
      name: 'charge_now',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get intro1_title1 {
    return Intl.message(
      '',
      name: 'intro1_title1',
      desc: '',
      args: [],
    );
  }

  /// `Find Nearest Changing Station`
  String get intro1_title2 {
    return Intl.message(
      'Find Nearest Changing Station',
      name: 'intro1_title2',
      desc: '',
      args: [],
    );
  }

  /// `Now you can find many of places to charge your ev with EV Charger.`
  String get intro1_des {
    return Intl.message(
      'Now you can find many of places to charge your ev with EV Charger.',
      name: 'intro1_des',
      desc: '',
      args: [],
    );
  }

  /// `Book A has sale free `
  String get intro2_title1 {
    return Intl.message(
      'Book A has sale free ',
      name: 'intro2_title1',
      desc: '',
      args: [],
    );
  }

  /// `Charging slot`
  String get intro2_title2 {
    return Intl.message(
      'Charging slot',
      name: 'intro2_title2',
      desc: '',
      args: [],
    );
  }

  /// `Check for Open  charging  Slot In  Real  Time.Book Your  Slot  Easily  As Per Your Preferance.`
  String get intro2_des {
    return Intl.message(
      'Check for Open  charging  Slot In  Real  Time.Book Your  Slot  Easily  As Per Your Preferance.',
      name: 'intro2_des',
      desc: '',
      args: [],
    );
  }

  /// `We got you covered with our `
  String get intro3_title1 {
    return Intl.message(
      'We got you covered with our ',
      name: 'intro3_title1',
      desc: '',
      args: [],
    );
  }

  /// `Fastest services`
  String get intro3_title2 {
    return Intl.message(
      'Fastest services',
      name: 'intro3_title2',
      desc: '',
      args: [],
    );
  }

  /// `Get our services and amazing offers & emergency services and support for 24*7.`
  String get intro3_des {
    return Intl.message(
      'Get our services and amazing offers & emergency services and support for 24*7.',
      name: 'intro3_des',
      desc: '',
      args: [],
    );
  }

  /// `There are no charging stations near you`
  String get not_nearest_ev_charge {
    return Intl.message(
      'There are no charging stations near you',
      name: 'not_nearest_ev_charge',
      desc: '',
      args: [],
    );
  }

  /// `Enter an address to find a charging station`
  String get please_type_key_word {
    return Intl.message(
      'Enter an address to find a charging station',
      name: 'please_type_key_word',
      desc: '',
      args: [],
    );
  }

  /// `Province, city`
  String get provinces_str {
    return Intl.message(
      'Province, city',
      name: 'provinces_str',
      desc: '',
      args: [],
    );
  }

  /// `Districts`
  String get districts_str {
    return Intl.message(
      'Districts',
      name: 'districts_str',
      desc: '',
      args: [],
    );
  }

  /// `Connector type`
  String get connector_type {
    return Intl.message(
      'Connector type',
      name: 'connector_type',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply_str {
    return Intl.message(
      'Apply',
      name: 'apply_str',
      desc: '',
      args: [],
    );
  }

  /// `Charge infomation`
  String get charge_info {
    return Intl.message(
      'Charge infomation',
      name: 'charge_info',
      desc: '',
      args: [],
    );
  }

  /// `Charge type`
  String get charge_type {
    return Intl.message(
      'Charge type',
      name: 'charge_type',
      desc: '',
      args: [],
    );
  }

  /// `Charge full`
  String get charge_full {
    return Intl.message(
      'Charge full',
      name: 'charge_full',
      desc: '',
      args: [],
    );
  }

  /// `Charge by time`
  String get charge_by_time {
    return Intl.message(
      'Charge by time',
      name: 'charge_by_time',
      desc: '',
      args: [],
    );
  }

  /// `Change pin code success`
  String get change_pin_success {
    return Intl.message(
      'Change pin code success',
      name: 'change_pin_success',
      desc: '',
      args: [],
    );
  }

  /// `OTP code must have 6 digits`
  String get today_str {
    return Intl.message(
      'OTP code must have 6 digits',
      name: 'today_str',
      desc: '',
      args: [],
    );
  }

  /// `Electrical price (VND/kWh)`
  String get electricityPrice {
    return Intl.message(
      'Electrical price (VND/kWh)',
      name: 'electricityPrice',
      desc: '',
      args: [],
    );
  }

  /// `Parking price (VND/h)`
  String get parkingPrice {
    return Intl.message(
      'Parking price (VND/h)',
      name: 'parkingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Occupied Charge (VND/h)`
  String get occupiedChargePrice {
    return Intl.message(
      'Occupied Charge (VND/h)',
      name: 'occupiedChargePrice',
      desc: '',
      args: [],
    );
  }

  /// `Vehicle type that supports charging`
  String get vehicleType {
    return Intl.message(
      'Vehicle type that supports charging',
      name: 'vehicleType',
      desc: '',
      args: [],
    );
  }

  /// `Electric charging type`
  String get electricType {
    return Intl.message(
      'Electric charging type',
      name: 'electricType',
      desc: '',
      args: [],
    );
  }

  /// `Voltage (V)`
  String get descriptionOperatingVoltage {
    return Intl.message(
      'Voltage (V)',
      name: 'descriptionOperatingVoltage',
      desc: '',
      args: [],
    );
  }

  /// `Wattage (kWh)`
  String get descriptionConnectorWattage {
    return Intl.message(
      'Wattage (kWh)',
      name: 'descriptionConnectorWattage',
      desc: '',
      args: [],
    );
  }

  /// `Choose connector type`
  String get choose_connector_type {
    return Intl.message(
      'Choose connector type',
      name: 'choose_connector_type',
      desc: '',
      args: [],
    );
  }

  /// `Delete fitter`
  String get delete_fitter {
    return Intl.message(
      'Delete fitter',
      name: 'delete_fitter',
      desc: '',
      args: [],
    );
  }

  /// `Temporary price (VND)`
  String get temporary_price {
    return Intl.message(
      'Temporary price (VND)',
      name: 'temporary_price',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to set a charging schedule?`
  String get confirm_book_slot_str {
    return Intl.message(
      'Are you sure you want to set a charging schedule?',
      name: 'confirm_book_slot_str',
      desc: '',
      args: [],
    );
  }

  /// `Please choose charging port`
  String get please_choose_connector_type {
    return Intl.message(
      'Please choose charging port',
      name: 'please_choose_connector_type',
      desc: '',
      args: [],
    );
  }

  /// `Please choose a charging date`
  String get please_choose_date {
    return Intl.message(
      'Please choose a charging date',
      name: 'please_choose_date',
      desc: '',
      args: [],
    );
  }

  /// `Please choose charging time`
  String get please_choose_time {
    return Intl.message(
      'Please choose charging time',
      name: 'please_choose_time',
      desc: '',
      args: [],
    );
  }

  /// `Save success`
  String get save_success {
    return Intl.message(
      'Save success',
      name: 'save_success',
      desc: '',
      args: [],
    );
  }

  /// `Save fail`
  String get save_fail {
    return Intl.message(
      'Save fail',
      name: 'save_fail',
      desc: '',
      args: [],
    );
  }

  /// `Type pin code`
  String get type_pin_code {
    return Intl.message(
      'Type pin code',
      name: 'type_pin_code',
      desc: '',
      args: [],
    );
  }

  /// `Type verify code send to your phone`
  String get type_pin_code_send_to_your_phone {
    return Intl.message(
      'Type verify code send to your phone',
      name: 'type_pin_code_send_to_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `Saved devices`
  String get saved_device {
    return Intl.message(
      'Saved devices',
      name: 'saved_device',
      desc: '',
      args: [],
    );
  }

  /// `Time frame`
  String get select_time_frame {
    return Intl.message(
      'Time frame',
      name: 'select_time_frame',
      desc: '',
      args: [],
    );
  }

  /// `Slot is not available`
  String get slot_time_empty {
    return Intl.message(
      'Slot is not available',
      name: 'slot_time_empty',
      desc: '',
      args: [],
    );
  }

  /// `Please enter all 6 numbers`
  String get pin_code_length_must_is_6 {
    return Intl.message(
      'Please enter all 6 numbers',
      name: 'pin_code_length_must_is_6',
      desc: '',
      args: [],
    );
  }

  /// `Scanner connector QR`
  String get scanner_connector {
    return Intl.message(
      'Scanner connector QR',
      name: 'scanner_connector',
      desc: '',
      args: [],
    );
  }

  /// `Cancel booking success`
  String get cancel_booking_success {
    return Intl.message(
      'Cancel booking success',
      name: 'cancel_booking_success',
      desc: '',
      args: [],
    );
  }

  /// `Charged`
  String get charged_str {
    return Intl.message(
      'Charged',
      name: 'charged_str',
      desc: '',
      args: [],
    );
  }

  /// `Spent`
  String get spent_str {
    return Intl.message(
      'Spent',
      name: 'spent_str',
      desc: '',
      args: [],
    );
  }

  /// `Connector name`
  String get charging_connector_name {
    return Intl.message(
      'Connector name',
      name: 'charging_connector_name',
      desc: '',
      args: [],
    );
  }

  /// `Connector info`
  String get connector_info {
    return Intl.message(
      'Connector info',
      name: 'connector_info',
      desc: '',
      args: [],
    );
  }

  /// `Connector type infomation`
  String get connector_info_type {
    return Intl.message(
      'Connector type infomation',
      name: 'connector_info_type',
      desc: '',
      args: [],
    );
  }

  /// `Please type phone number`
  String get please_type_phone_number {
    return Intl.message(
      'Please type phone number',
      name: 'please_type_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Wallet balance is not enough`
  String get money_in_wallet_is_enough {
    return Intl.message(
      'Wallet balance is not enough',
      name: 'money_in_wallet_is_enough',
      desc: '',
      args: [],
    );
  }

  /// `Charging port is not available`
  String get available_connector_is_empty {
    return Intl.message(
      'Charging port is not available',
      name: 'available_connector_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `Time is not available`
  String get slot_time_is_empty {
    return Intl.message(
      'Time is not available',
      name: 'slot_time_is_empty',
      desc: '',
      args: [],
    );
  }

  /// `unsave`
  String get un_save {
    return Intl.message(
      'unsave',
      name: 'un_save',
      desc: '',
      args: [],
    );
  }

  /// `Unsave success`
  String get un_save_success {
    return Intl.message(
      'Unsave success',
      name: 'un_save_success',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Financial Admin`
  String get welcome_to_PaymentManager {
    return Intl.message(
      'Welcome to Financial Admin',
      name: 'welcome_to_PaymentManager',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the pin code registered with the phone number`
  String get please_type_pin_code_of_phone {
    return Intl.message(
      'Please enter the pin code registered with the phone number',
      name: 'please_type_pin_code_of_phone',
      desc: '',
      args: [],
    );
  }

  /// `Wallet balance`
  String get money_in_wallet {
    return Intl.message(
      'Wallet balance',
      name: 'money_in_wallet',
      desc: '',
      args: [],
    );
  }

  /// `Guideline and Q&A`
  String get guideline_and_q_and_a {
    return Intl.message(
      'Guideline and Q&A',
      name: 'guideline_and_q_and_a',
      desc: '',
      args: [],
    );
  }

  /// `Guest login`
  String get use_as_guest {
    return Intl.message(
      'Guest login',
      name: 'use_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or_str {
    return Intl.message(
      'or',
      name: 'or_str',
      desc: '',
      args: [],
    );
  }

  /// `Have not review`
  String get have_not_review {
    return Intl.message(
      'Have not review',
      name: 'have_not_review',
      desc: '',
      args: [],
    );
  }

  /// `Begin charging`
  String get begin_charging_str {
    return Intl.message(
      'Begin charging',
      name: 'begin_charging_str',
      desc: '',
      args: [],
    );
  }

  /// `Scan code of station, charging head or booking schedule`
  String get scan_qr_code_of_booking_device_or_connector {
    return Intl.message(
      'Scan code of station, charging head or booking schedule',
      name: 'scan_qr_code_of_booking_device_or_connector',
      desc: '',
      args: [],
    );
  }

  /// `Scan the station or charger code`
  String get scan_qr_code_of_device_or_connector {
    return Intl.message(
      'Scan the station or charger code',
      name: 'scan_qr_code_of_device_or_connector',
      desc: '',
      args: [],
    );
  }

  /// `Connector number`
  String get connector_number {
    return Intl.message(
      'Connector number',
      name: 'connector_number',
      desc: '',
      args: [],
    );
  }

  /// `View qrcode`
  String get view_qr_code {
    return Intl.message(
      'View qrcode',
      name: 'view_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Prepare`
  String get charging_prepare {
    return Intl.message(
      'Prepare',
      name: 'charging_prepare',
      desc: '',
      args: [],
    );
  }

  /// `Charged time`
  String get charged_time {
    return Intl.message(
      'Charged time',
      name: 'charged_time',
      desc: '',
      args: [],
    );
  }

  /// `Charged power`
  String get charged_power {
    return Intl.message(
      'Charged power',
      name: 'charged_power',
      desc: '',
      args: [],
    );
  }

  /// `Top up`
  String get top_up {
    return Intl.message(
      'Top up',
      name: 'top_up',
      desc: '',
      args: [],
    );
  }

  /// `Top up to account`
  String get top_up_to_account {
    return Intl.message(
      'Top up to account',
      name: 'top_up_to_account',
      desc: '',
      args: [],
    );
  }

  /// `Create QR code`
  String get create_qr_code {
    return Intl.message(
      'Create QR code',
      name: 'create_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Quick choose`
  String get quick_choose {
    return Intl.message(
      'Quick choose',
      name: 'quick_choose',
      desc: '',
      args: [],
    );
  }

  /// `Input Amount`
  String get type_money {
    return Intl.message(
      'Input Amount',
      name: 'type_money',
      desc: '',
      args: [],
    );
  }

  /// `Top up amount`
  String get money_value {
    return Intl.message(
      'Top up amount',
      name: 'money_value',
      desc: '',
      args: [],
    );
  }

  /// `Top up amount infomation`
  String get top_up_to_account_info {
    return Intl.message(
      'Top up amount infomation',
      name: 'top_up_to_account_info',
      desc: '',
      args: [],
    );
  }

  /// `Please scans money according to this QR code`
  String get use_bank_app_for_scan_this_qr_code {
    return Intl.message(
      'Please scans money according to this QR code',
      name: 'use_bank_app_for_scan_this_qr_code',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get charging_accepted_str {
    return Intl.message(
      'Successful',
      name: 'charging_accepted_str',
      desc: '',
      args: [],
    );
  }

  /// `Rejected, handling sending to faulty station`
  String get charging_rejected_str {
    return Intl.message(
      'Rejected, handling sending to faulty station',
      name: 'charging_rejected_str',
      desc: '',
      args: [],
    );
  }

  /// `Not enough money`
  String get charging_nomoney_str {
    return Intl.message(
      'Not enough money',
      name: 'charging_nomoney_str',
      desc: '',
      args: [],
    );
  }

  /// `Account is locked`
  String get charging_blocked_str {
    return Intl.message(
      'Account is locked',
      name: 'charging_blocked_str',
      desc: '',
      args: [],
    );
  }

  /// `Account expired`
  String get charging_expired_str {
    return Intl.message(
      'Account expired',
      name: 'charging_expired_str',
      desc: '',
      args: [],
    );
  }

  /// `User does not exist`
  String get charging_userInvalid_str {
    return Intl.message(
      'User does not exist',
      name: 'charging_userInvalid_str',
      desc: '',
      args: [],
    );
  }

  /// `Charging station is disconnected`
  String get charging_offline_str {
    return Intl.message(
      'Charging station is disconnected',
      name: 'charging_offline_str',
      desc: '',
      args: [],
    );
  }

  /// `The transaction was stopped because of the authorization status`
  String get charging_deauthorized_str {
    return Intl.message(
      'The transaction was stopped because of the authorization status',
      name: 'charging_deauthorized_str',
      desc: '',
      args: [],
    );
  }

  /// `Emergency stop button was used.`
  String get charging_emergencystop_str {
    return Intl.message(
      'Emergency stop button was used.',
      name: 'charging_emergencystop_str',
      desc: '',
      args: [],
    );
  }

  /// `Disconnecting of cable, vehicle moved away from inductive charge unit.`
  String get charging_evdisconnected_str {
    return Intl.message(
      'Disconnecting of cable, vehicle moved away from inductive charge unit.',
      name: 'charging_evdisconnected_str',
      desc: '',
      args: [],
    );
  }

  /// `A hard reset command was received.`
  String get charging_hardreset_str {
    return Intl.message(
      'A hard reset command was received.',
      name: 'charging_hardreset_str',
      desc: '',
      args: [],
    );
  }

  /// `Stopped locally on request of the user at the charge point`
  String get charging_local_str {
    return Intl.message(
      'Stopped locally on request of the user at the charge point',
      name: 'charging_local_str',
      desc: '',
      args: [],
    );
  }

  /// `Any other reason.`
  String get charging_other_str {
    return Intl.message(
      'Any other reason.',
      name: 'charging_other_str',
      desc: '',
      args: [],
    );
  }

  /// `Complete loss of power.`
  String get charging_powerloss_str {
    return Intl.message(
      'Complete loss of power.',
      name: 'charging_powerloss_str',
      desc: '',
      args: [],
    );
  }

  /// `A locally initiated reset/reboot occurred.`
  String get charging_reboot_str {
    return Intl.message(
      'A locally initiated reset/reboot occurred.',
      name: 'charging_reboot_str',
      desc: '',
      args: [],
    );
  }

  /// `Stopped remotely on request of the user`
  String get charging_remote_str {
    return Intl.message(
      'Stopped remotely on request of the user',
      name: 'charging_remote_str',
      desc: '',
      args: [],
    );
  }

  /// `A soft reset command was received.`
  String get charging_softreset_str {
    return Intl.message(
      'A soft reset command was received.',
      name: 'charging_softreset_str',
      desc: '',
      args: [],
    );
  }

  /// `Central System sent an unlock connector command.`
  String get charging_unlockcommand_str {
    return Intl.message(
      'Central System sent an unlock connector command.',
      name: 'charging_unlockcommand_str',
      desc: '',
      args: [],
    );
  }

  /// `Click at here`
  String get click_at_here {
    return Intl.message(
      'Click at here',
      name: 'click_at_here',
      desc: '',
      args: [],
    );
  }

  /// `Please enter an amount greater than VND 2000`
  String get please_type_money {
    return Intl.message(
      'Please enter an amount greater than VND 2000',
      name: 'please_type_money',
      desc: '',
      args: [],
    );
  }

  /// `Search booking`
  String get search_booking {
    return Intl.message(
      'Search booking',
      name: 'search_booking',
      desc: '',
      args: [],
    );
  }

  /// `Maximum power`
  String get maximum_power {
    return Intl.message(
      'Maximum power',
      name: 'maximum_power',
      desc: '',
      args: [],
    );
  }

  /// `Price needs to be paid (VND)`
  String get price_need_paid {
    return Intl.message(
      'Price needs to be paid (VND)',
      name: 'price_need_paid',
      desc: '',
      args: [],
    );
  }

  /// `Parking cost (VND)`
  String get price_parking_total {
    return Intl.message(
      'Parking cost (VND)',
      name: 'price_parking_total',
      desc: '',
      args: [],
    );
  }

  /// `Dark mode`
  String get dark_mode {
    return Intl.message(
      'Dark mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get money_str {
    return Intl.message(
      'Amount',
      name: 'money_str',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get system_str {
    return Intl.message(
      'System',
      name: 'system_str',
      desc: '',
      args: [],
    );
  }

  /// `Bank account`
  String get bank_account_str {
    return Intl.message(
      'Bank account',
      name: 'bank_account_str',
      desc: '',
      args: [],
    );
  }

  /// `Account name`
  String get bank_account_name_str {
    return Intl.message(
      'Account name',
      name: 'bank_account_name_str',
      desc: '',
      args: [],
    );
  }

  /// `Bank code`
  String get bank_code {
    return Intl.message(
      'Bank code',
      name: 'bank_code',
      desc: '',
      args: [],
    );
  }

  /// `Bank`
  String get bank_name {
    return Intl.message(
      'Bank',
      name: 'bank_name',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content_str {
    return Intl.message(
      'Content',
      name: 'content_str',
      desc: '',
      args: [],
    );
  }

  /// `Time taken`
  String get time_paid {
    return Intl.message(
      'Time taken',
      name: 'time_paid',
      desc: '',
      args: [],
    );
  }

  /// `Payment type`
  String get type_paid {
    return Intl.message(
      'Payment type',
      name: 'type_paid',
      desc: '',
      args: [],
    );
  }

  /// `Payment code`
  String get payment_code {
    return Intl.message(
      'Payment code',
      name: 'payment_code',
      desc: '',
      args: [],
    );
  }

  /// `To account`
  String get sent_to_account {
    return Intl.message(
      'To account',
      name: 'sent_to_account',
      desc: '',
      args: [],
    );
  }

  /// `Referent code`
  String get referent_code {
    return Intl.message(
      'Referent code',
      name: 'referent_code',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get activating_str {
    return Intl.message(
      'Active',
      name: 'activating_str',
      desc: '',
      args: [],
    );
  }

  /// `Inactive`
  String get inactivating_str {
    return Intl.message(
      'Inactive',
      name: 'inactivating_str',
      desc: '',
      args: [],
    );
  }

  /// `Find by device name`
  String get find_by_device_name {
    return Intl.message(
      'Find by device name',
      name: 'find_by_device_name',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome_str {
    return Intl.message(
      'Welcome',
      name: 'welcome_str',
      desc: '',
      args: [],
    );
  }

  /// `Revenue by unit`
  String get revenue_by_org {
    return Intl.message(
      'Revenue by unit',
      name: 'revenue_by_org',
      desc: '',
      args: [],
    );
  }

  /// `Revenue by payment type`
  String get revenue_by_payment_type {
    return Intl.message(
      'Revenue by payment type',
      name: 'revenue_by_payment_type',
      desc: '',
      args: [],
    );
  }

  /// `Revenue by month`
  String get revenue_by_month {
    return Intl.message(
      'Revenue by month',
      name: 'revenue_by_month',
      desc: '',
      args: [],
    );
  }

  /// `Unit with the top revenue`
  String get revenue_by_top_terminal {
    return Intl.message(
      'Unit with the top revenue',
      name: 'revenue_by_top_terminal',
      desc: '',
      args: [],
    );
  }

  /// `Device with the top revenue`
  String get revenue_by_top_device {
    return Intl.message(
      'Device with the top revenue',
      name: 'revenue_by_top_device',
      desc: '',
      args: [],
    );
  }

  /// `Revenue by day`
  String get revenue_by_day {
    return Intl.message(
      'Revenue by day',
      name: 'revenue_by_day',
      desc: '',
      args: [],
    );
  }

  /// `List of organizations`
  String get org_list {
    return Intl.message(
      'List of organizations',
      name: 'org_list',
      desc: '',
      args: [],
    );
  }

  /// `Find by organizations name`
  String get find_by_org_name {
    return Intl.message(
      'Find by organizations name',
      name: 'find_by_org_name',
      desc: '',
      args: [],
    );
  }

  /// `Activity`
  String get device_online {
    return Intl.message(
      'Activity',
      name: 'device_online',
      desc: '',
      args: [],
    );
  }

  /// `Connection lost`
  String get device_offline {
    return Intl.message(
      'Connection lost',
      name: 'device_offline',
      desc: '',
      args: [],
    );
  }

  /// `Not working yet`
  String get device_not_setup {
    return Intl.message(
      'Not working yet',
      name: 'device_not_setup',
      desc: '',
      args: [],
    );
  }

  /// `Expired`
  String get device_expired {
    return Intl.message(
      'Expired',
      name: 'device_expired',
      desc: '',
      args: [],
    );
  }

  /// `Organization`
  String get org_str {
    return Intl.message(
      'Organization',
      name: 'org_str',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data_str {
    return Intl.message(
      'No data',
      name: 'no_data_str',
      desc: '',
      args: [],
    );
  }

  /// `Total device`
  String get total_device {
    return Intl.message(
      'Total device',
      name: 'total_device',
      desc: '',
      args: [],
    );
  }

  /// `Payment history`
  String get payment_history {
    return Intl.message(
      'Payment history',
      name: 'payment_history',
      desc: '',
      args: [],
    );
  }

  /// `Number of payment`
  String get number_of_payment {
    return Intl.message(
      'Number of payment',
      name: 'number_of_payment',
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

  /// `Unable to connect to the server`
  String get not_connect_to_server {
    return Intl.message(
      'Unable to connect to the server',
      name: 'not_connect_to_server',
      desc: '',
      args: [],
    );
  }

  /// `VND`
  String get vnd_unit {
    return Intl.message(
      'VND',
      name: 'vnd_unit',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get delete_account {
    return Intl.message(
      'Delete account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `You will no longer be able to access this account. Are you sure you want to delete this account?`
  String get you_are_sure_delete_account_title {
    return Intl.message(
      'You will no longer be able to access this account. Are you sure you want to delete this account?',
      name: 'you_are_sure_delete_account_title',
      desc: '',
      args: [],
    );
  }

  /// `Choose unit`
  String get choose_org {
    return Intl.message(
      'Choose unit',
      name: 'choose_org',
      desc: '',
      args: [],
    );
  }

  /// `Payment details`
  String get payment_detail {
    return Intl.message(
      'Payment details',
      name: 'payment_detail',
      desc: '',
      args: [],
    );
  }

  /// `Notification details`
  String get notify_detail {
    return Intl.message(
      'Notification details',
      name: 'notify_detail',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title_str {
    return Intl.message(
      'Title',
      name: 'title_str',
      desc: '',
      args: [],
    );
  }

  /// `Id`
  String get id_str {
    return Intl.message(
      'Id',
      name: 'id_str',
      desc: '',
      args: [],
    );
  }

  /// `Transaction code`
  String get transaction_id_str {
    return Intl.message(
      'Transaction code',
      name: 'transaction_id_str',
      desc: '',
      args: [],
    );
  }

  /// `Notification type`
  String get notify_type {
    return Intl.message(
      'Notification type',
      name: 'notify_type',
      desc: '',
      args: [],
    );
  }

  /// `Scan user's code to make payment`
  String get scan_qrcode_of_user_for_payment {
    return Intl.message(
      'Scan user\'s code to make payment',
      name: 'scan_qrcode_of_user_for_payment',
      desc: '',
      args: [],
    );
  }

  /// `My QR`
  String get my_qr {
    return Intl.message(
      'My QR',
      name: 'my_qr',
      desc: '',
      args: [],
    );
  }

  /// `Coupon list`
  String get voucher_list {
    return Intl.message(
      'Coupon list',
      name: 'voucher_list',
      desc: '',
      args: [],
    );
  }

  /// `Store link`
  String get link_partner {
    return Intl.message(
      'Store link',
      name: 'link_partner',
      desc: '',
      args: [],
    );
  }

  /// `Link user`
  String get link_user {
    return Intl.message(
      'Link user',
      name: 'link_user',
      desc: '',
      args: [],
    );
  }

  /// `Scan user's code to link`
  String get scan_qrcode_of_user_for_link {
    return Intl.message(
      'Scan user\'s code to link',
      name: 'scan_qrcode_of_user_for_link',
      desc: '',
      args: [],
    );
  }

  /// `Scan store's code to link`
  String get scan_qrcode_of_store_for_link {
    return Intl.message(
      'Scan store\'s code to link',
      name: 'scan_qrcode_of_store_for_link',
      desc: '',
      args: [],
    );
  }

  /// `Choose store`
  String get choose_store {
    return Intl.message(
      'Choose store',
      name: 'choose_store',
      desc: '',
      args: [],
    );
  }

  /// `Information store`
  String get store_info {
    return Intl.message(
      'Information store',
      name: 'store_info',
      desc: '',
      args: [],
    );
  }

  /// `Partner code's store`
  String get store_code {
    return Intl.message(
      'Partner code\'s store',
      name: 'store_code',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to link to this store?`
  String get confirm_link_store {
    return Intl.message(
      'Are you sure to link to this store?',
      name: 'confirm_link_store',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to unlink this store?`
  String get confirm_unlink_store {
    return Intl.message(
      'Are you sure to unlink this store?',
      name: 'confirm_unlink_store',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission to link accounts!`
  String get you_have_not_link_account {
    return Intl.message(
      'You do not have permission to link accounts!',
      name: 'you_have_not_link_account',
      desc: '',
      args: [],
    );
  }

  /// `QR code is invalid !`
  String get qr_code_invalid {
    return Intl.message(
      'QR code is invalid !',
      name: 'qr_code_invalid',
      desc: '',
      args: [],
    );
  }

  /// `You do not have permission to log in to this application!`
  String get you_have_not_to_login {
    return Intl.message(
      'You do not have permission to log in to this application!',
      name: 'you_have_not_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Please show this code to the store owner for payment!`
  String get please_show_this_qr_for_partner {
    return Intl.message(
      'Please show this code to the store owner for payment!',
      name: 'please_show_this_qr_for_partner',
      desc: '',
      args: [],
    );
  }

  /// `Self-pay`
  String get self_pay {
    return Intl.message(
      'Self-pay',
      name: 'self_pay',
      desc: '',
      args: [],
    );
  }

  /// `Transaction details`
  String get transaction_detail_str {
    return Intl.message(
      'Transaction details',
      name: 'transaction_detail_str',
      desc: '',
      args: [],
    );
  }

  /// `Top up wallet`
  String get top_up_str {
    return Intl.message(
      'Top up wallet',
      name: 'top_up_str',
      desc: '',
      args: [],
    );
  }

  /// `Extend device`
  String get extend_str {
    return Intl.message(
      'Extend device',
      name: 'extend_str',
      desc: '',
      args: [],
    );
  }

  /// `Pay by voucher`
  String get pay_by_voucher_str {
    return Intl.message(
      'Pay by voucher',
      name: 'pay_by_voucher_str',
      desc: '',
      args: [],
    );
  }

  /// `Create voucher`
  String get provide_voucher_str {
    return Intl.message(
      'Create voucher',
      name: 'provide_voucher_str',
      desc: '',
      args: [],
    );
  }

  /// `Receive voucher`
  String get receive_voucher_str {
    return Intl.message(
      'Receive voucher',
      name: 'receive_voucher_str',
      desc: '',
      args: [],
    );
  }

  /// `Refund voucher`
  String get refund_voucher_str {
    return Intl.message(
      'Refund voucher',
      name: 'refund_voucher_str',
      desc: '',
      args: [],
    );
  }

  /// `Top up voucher`
  String get top_up_voucher_str {
    return Intl.message(
      'Top up voucher',
      name: 'top_up_voucher_str',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all_str {
    return Intl.message(
      'All',
      name: 'all_str',
      desc: '',
      args: [],
    );
  }

  /// `Payment type`
  String get payment_type {
    return Intl.message(
      'Payment type',
      name: 'payment_type',
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
