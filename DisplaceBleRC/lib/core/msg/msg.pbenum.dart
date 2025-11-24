// This is a generated file - do not edit.
//
// Generated from msg.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MouseButton extends $pb.ProtobufEnum {
  static const MouseButton MOUSE_BUTTON_LEFT =
      MouseButton._(0, _omitEnumNames ? '' : 'MOUSE_BUTTON_LEFT');
  static const MouseButton MOUSE_BUTTON_RIGHT =
      MouseButton._(1, _omitEnumNames ? '' : 'MOUSE_BUTTON_RIGHT');

  static const $core.List<MouseButton> values = <MouseButton>[
    MOUSE_BUTTON_LEFT,
    MOUSE_BUTTON_RIGHT,
  ];

  static final $core.List<MouseButton?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 1);
  static MouseButton? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MouseButton._(super.value, super.name);
}

class KeyControl extends $pb.ProtobufEnum {
  static const KeyControl KEY_BACKSPACE =
      KeyControl._(0, _omitEnumNames ? '' : 'KEY_BACKSPACE');
  static const KeyControl KEY_ENTER =
      KeyControl._(1, _omitEnumNames ? '' : 'KEY_ENTER');
  static const KeyControl KEY_ESCAPE =
      KeyControl._(2, _omitEnumNames ? '' : 'KEY_ESCAPE');

  static const $core.List<KeyControl> values = <KeyControl>[
    KEY_BACKSPACE,
    KEY_ENTER,
    KEY_ESCAPE,
  ];

  static final $core.List<KeyControl?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static KeyControl? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const KeyControl._(super.value, super.name);
}

class ControlType extends $pb.ProtobufEnum {
  static const ControlType TYPE_POWER_ON =
      ControlType._(0, _omitEnumNames ? '' : 'TYPE_POWER_ON');
  static const ControlType TYPE_POWER_OFF =
      ControlType._(1, _omitEnumNames ? '' : 'TYPE_POWER_OFF');
  static const ControlType TYPE_SEARCH =
      ControlType._(2, _omitEnumNames ? '' : 'TYPE_SEARCH');
  static const ControlType TYPE_HOME =
      ControlType._(3, _omitEnumNames ? '' : 'TYPE_HOME');
  static const ControlType TYPE_BACK =
      ControlType._(4, _omitEnumNames ? '' : 'TYPE_BACK');
  static const ControlType TYPE_PLAY_PAUSE =
      ControlType._(5, _omitEnumNames ? '' : 'TYPE_PLAY_PAUSE');
  static const ControlType TYPE_MUTE_UNMUTE =
      ControlType._(6, _omitEnumNames ? '' : 'TYPE_MUTE_UNMUTE');

  static const $core.List<ControlType> values = <ControlType>[
    TYPE_POWER_ON,
    TYPE_POWER_OFF,
    TYPE_SEARCH,
    TYPE_HOME,
    TYPE_BACK,
    TYPE_PLAY_PAUSE,
    TYPE_MUTE_UNMUTE,
  ];

  static final $core.List<ControlType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static ControlType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ControlType._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
