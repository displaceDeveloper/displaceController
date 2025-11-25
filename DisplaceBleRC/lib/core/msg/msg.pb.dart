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

import 'msg.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'msg.pbenum.dart';

class MouseMoveEvent extends $pb.GeneratedMessage {
  factory MouseMoveEvent({
    $core.int? dx,
    $core.int? dy,
  }) {
    final result = create();
    if (dx != null) result.dx = dx;
    if (dy != null) result.dy = dy;
    return result;
  }

  MouseMoveEvent._();

  factory MouseMoveEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MouseMoveEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MouseMoveEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'dx')
    ..aI(2, _omitFieldNames ? '' : 'dy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseMoveEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseMoveEvent copyWith(void Function(MouseMoveEvent) updates) =>
      super.copyWith((message) => updates(message as MouseMoveEvent))
          as MouseMoveEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MouseMoveEvent create() => MouseMoveEvent._();
  @$core.override
  MouseMoveEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MouseMoveEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MouseMoveEvent>(create);
  static MouseMoveEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get dx => $_getIZ(0);
  @$pb.TagNumber(1)
  set dx($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasDx() => $_has(0);
  @$pb.TagNumber(1)
  void clearDx() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get dy => $_getIZ(1);
  @$pb.TagNumber(2)
  set dy($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDy() => $_has(1);
  @$pb.TagNumber(2)
  void clearDy() => $_clearField(2);
}

class MouseClickEvent extends $pb.GeneratedMessage {
  factory MouseClickEvent({
    MouseButton? button,
  }) {
    final result = create();
    if (button != null) result.button = button;
    return result;
  }

  MouseClickEvent._();

  factory MouseClickEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MouseClickEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MouseClickEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aE<MouseButton>(1, _omitFieldNames ? '' : 'button',
        enumValues: MouseButton.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseClickEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseClickEvent copyWith(void Function(MouseClickEvent) updates) =>
      super.copyWith((message) => updates(message as MouseClickEvent))
          as MouseClickEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MouseClickEvent create() => MouseClickEvent._();
  @$core.override
  MouseClickEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MouseClickEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MouseClickEvent>(create);
  static MouseClickEvent? _defaultInstance;

  @$pb.TagNumber(1)
  MouseButton get button => $_getN(0);
  @$pb.TagNumber(1)
  set button(MouseButton value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasButton() => $_has(0);
  @$pb.TagNumber(1)
  void clearButton() => $_clearField(1);
}

class MouseVScrollEvent extends $pb.GeneratedMessage {
  factory MouseVScrollEvent({
    $core.double? value,
  }) {
    final result = create();
    if (value != null) result.value = value;
    return result;
  }

  MouseVScrollEvent._();

  factory MouseVScrollEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MouseVScrollEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MouseVScrollEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseVScrollEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseVScrollEvent copyWith(void Function(MouseVScrollEvent) updates) =>
      super.copyWith((message) => updates(message as MouseVScrollEvent))
          as MouseVScrollEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MouseVScrollEvent create() => MouseVScrollEvent._();
  @$core.override
  MouseVScrollEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MouseVScrollEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MouseVScrollEvent>(create);
  static MouseVScrollEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
}

class MouseHScrollEvent extends $pb.GeneratedMessage {
  factory MouseHScrollEvent({
    $core.double? value,
  }) {
    final result = create();
    if (value != null) result.value = value;
    return result;
  }

  MouseHScrollEvent._();

  factory MouseHScrollEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MouseHScrollEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MouseHScrollEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseHScrollEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MouseHScrollEvent copyWith(void Function(MouseHScrollEvent) updates) =>
      super.copyWith((message) => updates(message as MouseHScrollEvent))
          as MouseHScrollEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MouseHScrollEvent create() => MouseHScrollEvent._();
  @$core.override
  MouseHScrollEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MouseHScrollEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MouseHScrollEvent>(create);
  static MouseHScrollEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get value => $_getN(0);
  @$pb.TagNumber(1)
  set value($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => $_clearField(1);
}

class KeyStringEvent extends $pb.GeneratedMessage {
  factory KeyStringEvent({
    $core.String? str,
  }) {
    final result = create();
    if (str != null) result.str = str;
    return result;
  }

  KeyStringEvent._();

  factory KeyStringEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KeyStringEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KeyStringEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'str')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KeyStringEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KeyStringEvent copyWith(void Function(KeyStringEvent) updates) =>
      super.copyWith((message) => updates(message as KeyStringEvent))
          as KeyStringEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KeyStringEvent create() => KeyStringEvent._();
  @$core.override
  KeyStringEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static KeyStringEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KeyStringEvent>(create);
  static KeyStringEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get str => $_getSZ(0);
  @$pb.TagNumber(1)
  set str($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasStr() => $_has(0);
  @$pb.TagNumber(1)
  void clearStr() => $_clearField(1);
}

class KeyControlEvent extends $pb.GeneratedMessage {
  factory KeyControlEvent({
    KeyControl? key,
  }) {
    final result = create();
    if (key != null) result.key = key;
    return result;
  }

  KeyControlEvent._();

  factory KeyControlEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory KeyControlEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'KeyControlEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aE<KeyControl>(1, _omitFieldNames ? '' : 'key',
        enumValues: KeyControl.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KeyControlEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  KeyControlEvent copyWith(void Function(KeyControlEvent) updates) =>
      super.copyWith((message) => updates(message as KeyControlEvent))
          as KeyControlEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static KeyControlEvent create() => KeyControlEvent._();
  @$core.override
  KeyControlEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static KeyControlEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<KeyControlEvent>(create);
  static KeyControlEvent? _defaultInstance;

  @$pb.TagNumber(1)
  KeyControl get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(KeyControl value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);
}

class ControlEvent extends $pb.GeneratedMessage {
  factory ControlEvent({
    ControlType? type,
    $core.int? value,
  }) {
    final result = create();
    if (type != null) result.type = type;
    if (value != null) result.value = value;
    return result;
  }

  ControlEvent._();

  factory ControlEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ControlEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ControlEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aE<ControlType>(1, _omitFieldNames ? '' : 'type',
        enumValues: ControlType.values)
    ..aI(2, _omitFieldNames ? '' : 'value')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ControlEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ControlEvent copyWith(void Function(ControlEvent) updates) =>
      super.copyWith((message) => updates(message as ControlEvent))
          as ControlEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ControlEvent create() => ControlEvent._();
  @$core.override
  ControlEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static ControlEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ControlEvent>(create);
  static ControlEvent? _defaultInstance;

  @$pb.TagNumber(1)
  ControlType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(ControlType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get value => $_getIZ(1);
  @$pb.TagNumber(2)
  set value($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasValue() => $_has(1);
  @$pb.TagNumber(2)
  void clearValue() => $_clearField(2);
}

class HeartBeatReqEvent extends $pb.GeneratedMessage {
  factory HeartBeatReqEvent({
    $core.String? version,
  }) {
    final result = create();
    if (version != null) result.version = version;
    return result;
  }

  HeartBeatReqEvent._();

  factory HeartBeatReqEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeartBeatReqEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeartBeatReqEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'version')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeartBeatReqEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeartBeatReqEvent copyWith(void Function(HeartBeatReqEvent) updates) =>
      super.copyWith((message) => updates(message as HeartBeatReqEvent))
          as HeartBeatReqEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeartBeatReqEvent create() => HeartBeatReqEvent._();
  @$core.override
  HeartBeatReqEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeartBeatReqEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeartBeatReqEvent>(create);
  static HeartBeatReqEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get version => $_getSZ(0);
  @$pb.TagNumber(1)
  set version($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearVersion() => $_clearField(1);
}

class HeartBeatRespEvent extends $pb.GeneratedMessage {
  factory HeartBeatRespEvent({
    $core.int? seq,
  }) {
    final result = create();
    if (seq != null) result.seq = seq;
    return result;
  }

  HeartBeatRespEvent._();

  factory HeartBeatRespEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeartBeatRespEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeartBeatRespEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aI(1, _omitFieldNames ? '' : 'seq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeartBeatRespEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeartBeatRespEvent copyWith(void Function(HeartBeatRespEvent) updates) =>
      super.copyWith((message) => updates(message as HeartBeatRespEvent))
          as HeartBeatRespEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeartBeatRespEvent create() => HeartBeatRespEvent._();
  @$core.override
  HeartBeatRespEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static HeartBeatRespEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeartBeatRespEvent>(create);
  static HeartBeatRespEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get seq => $_getIZ(0);
  @$pb.TagNumber(1)
  set seq($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSeq() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeq() => $_clearField(1);
}

class UpgradeRequestEvent extends $pb.GeneratedMessage {
  factory UpgradeRequestEvent({
    $core.String? newVersion,
    $core.String? downloadUrl,
    $core.String? minVersion,
    $core.String? maxVersion,
  }) {
    final result = create();
    if (newVersion != null) result.newVersion = newVersion;
    if (downloadUrl != null) result.downloadUrl = downloadUrl;
    if (minVersion != null) result.minVersion = minVersion;
    if (maxVersion != null) result.maxVersion = maxVersion;
    return result;
  }

  UpgradeRequestEvent._();

  factory UpgradeRequestEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpgradeRequestEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpgradeRequestEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'newVersion')
    ..aOS(2, _omitFieldNames ? '' : 'downloadUrl')
    ..aOS(3, _omitFieldNames ? '' : 'minVersion')
    ..aOS(4, _omitFieldNames ? '' : 'maxVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpgradeRequestEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpgradeRequestEvent copyWith(void Function(UpgradeRequestEvent) updates) =>
      super.copyWith((message) => updates(message as UpgradeRequestEvent))
          as UpgradeRequestEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpgradeRequestEvent create() => UpgradeRequestEvent._();
  @$core.override
  UpgradeRequestEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static UpgradeRequestEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpgradeRequestEvent>(create);
  static UpgradeRequestEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get newVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set newVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNewVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearNewVersion() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get downloadUrl => $_getSZ(1);
  @$pb.TagNumber(2)
  set downloadUrl($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDownloadUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearDownloadUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get minVersion => $_getSZ(2);
  @$pb.TagNumber(3)
  set minVersion($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMinVersion() => $_has(2);
  @$pb.TagNumber(3)
  void clearMinVersion() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get maxVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set maxVersion($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMaxVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearMaxVersion() => $_clearField(4);
}

class MuteChangeEvent extends $pb.GeneratedMessage {
  factory MuteChangeEvent({
    $core.bool? isMuted,
  }) {
    final result = create();
    if (isMuted != null) result.isMuted = isMuted;
    return result;
  }

  MuteChangeEvent._();

  factory MuteChangeEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory MuteChangeEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MuteChangeEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isMuted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MuteChangeEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MuteChangeEvent copyWith(void Function(MuteChangeEvent) updates) =>
      super.copyWith((message) => updates(message as MuteChangeEvent))
          as MuteChangeEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static MuteChangeEvent create() => MuteChangeEvent._();
  @$core.override
  MuteChangeEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static MuteChangeEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MuteChangeEvent>(create);
  static MuteChangeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isMuted => $_getBF(0);
  @$pb.TagNumber(1)
  set isMuted($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsMuted() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsMuted() => $_clearField(1);
}

class VolumeChangeEvent extends $pb.GeneratedMessage {
  factory VolumeChangeEvent({
    $core.double? volume,
  }) {
    final result = create();
    if (volume != null) result.volume = volume;
    return result;
  }

  VolumeChangeEvent._();

  factory VolumeChangeEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory VolumeChangeEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VolumeChangeEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aD(1, _omitFieldNames ? '' : 'volume')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VolumeChangeEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VolumeChangeEvent copyWith(void Function(VolumeChangeEvent) updates) =>
      super.copyWith((message) => updates(message as VolumeChangeEvent))
          as VolumeChangeEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VolumeChangeEvent create() => VolumeChangeEvent._();
  @$core.override
  VolumeChangeEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static VolumeChangeEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<VolumeChangeEvent>(create);
  static VolumeChangeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get volume => $_getN(0);
  @$pb.TagNumber(1)
  set volume($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasVolume() => $_has(0);
  @$pb.TagNumber(1)
  void clearVolume() => $_clearField(1);
}

class PowerChangeEvent extends $pb.GeneratedMessage {
  factory PowerChangeEvent({
    $core.bool? isPoweredOn,
  }) {
    final result = create();
    if (isPoweredOn != null) result.isPoweredOn = isPoweredOn;
    return result;
  }

  PowerChangeEvent._();

  factory PowerChangeEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory PowerChangeEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PowerChangeEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isPoweredOn')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PowerChangeEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PowerChangeEvent copyWith(void Function(PowerChangeEvent) updates) =>
      super.copyWith((message) => updates(message as PowerChangeEvent))
          as PowerChangeEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PowerChangeEvent create() => PowerChangeEvent._();
  @$core.override
  PowerChangeEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static PowerChangeEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PowerChangeEvent>(create);
  static PowerChangeEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isPoweredOn => $_getBF(0);
  @$pb.TagNumber(1)
  set isPoweredOn($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsPoweredOn() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsPoweredOn() => $_clearField(1);
}

class StateUpdatedEvent extends $pb.GeneratedMessage {
  factory StateUpdatedEvent({
    $core.bool? isPoweredOn,
    $core.bool? isMuted,
    $core.double? volume,
  }) {
    final result = create();
    if (isPoweredOn != null) result.isPoweredOn = isPoweredOn;
    if (isMuted != null) result.isMuted = isMuted;
    if (volume != null) result.volume = volume;
    return result;
  }

  StateUpdatedEvent._();

  factory StateUpdatedEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory StateUpdatedEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'StateUpdatedEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'isPoweredOn')
    ..aOB(2, _omitFieldNames ? '' : 'isMuted')
    ..aD(3, _omitFieldNames ? '' : 'volume')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StateUpdatedEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  StateUpdatedEvent copyWith(void Function(StateUpdatedEvent) updates) =>
      super.copyWith((message) => updates(message as StateUpdatedEvent))
          as StateUpdatedEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static StateUpdatedEvent create() => StateUpdatedEvent._();
  @$core.override
  StateUpdatedEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static StateUpdatedEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<StateUpdatedEvent>(create);
  static StateUpdatedEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get isPoweredOn => $_getBF(0);
  @$pb.TagNumber(1)
  set isPoweredOn($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasIsPoweredOn() => $_has(0);
  @$pb.TagNumber(1)
  void clearIsPoweredOn() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get isMuted => $_getBF(1);
  @$pb.TagNumber(2)
  set isMuted($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasIsMuted() => $_has(1);
  @$pb.TagNumber(2)
  void clearIsMuted() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get volume => $_getN(2);
  @$pb.TagNumber(3)
  set volume($core.double value) => $_setDouble(2, value);
  @$pb.TagNumber(3)
  $core.bool hasVolume() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolume() => $_clearField(3);
}

enum InputEvent_Payload {
  mouseMove,
  mouseClick,
  mouseVscroll,
  mouseHscroll,
  keyString,
  keyControl,
  controlButton,
  heartBeat,
  volumeChange,
  notSet
}

class InputEvent extends $pb.GeneratedMessage {
  factory InputEvent({
    MouseMoveEvent? mouseMove,
    MouseClickEvent? mouseClick,
    MouseVScrollEvent? mouseVscroll,
    MouseHScrollEvent? mouseHscroll,
    KeyStringEvent? keyString,
    KeyControlEvent? keyControl,
    ControlEvent? controlButton,
    HeartBeatReqEvent? heartBeat,
    VolumeChangeEvent? volumeChange,
  }) {
    final result = create();
    if (mouseMove != null) result.mouseMove = mouseMove;
    if (mouseClick != null) result.mouseClick = mouseClick;
    if (mouseVscroll != null) result.mouseVscroll = mouseVscroll;
    if (mouseHscroll != null) result.mouseHscroll = mouseHscroll;
    if (keyString != null) result.keyString = keyString;
    if (keyControl != null) result.keyControl = keyControl;
    if (controlButton != null) result.controlButton = controlButton;
    if (heartBeat != null) result.heartBeat = heartBeat;
    if (volumeChange != null) result.volumeChange = volumeChange;
    return result;
  }

  InputEvent._();

  factory InputEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory InputEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InputEvent_Payload>
      _InputEvent_PayloadByTag = {
    1: InputEvent_Payload.mouseMove,
    2: InputEvent_Payload.mouseClick,
    3: InputEvent_Payload.mouseVscroll,
    4: InputEvent_Payload.mouseHscroll,
    5: InputEvent_Payload.keyString,
    6: InputEvent_Payload.keyControl,
    7: InputEvent_Payload.controlButton,
    8: InputEvent_Payload.heartBeat,
    9: InputEvent_Payload.volumeChange,
    0: InputEvent_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InputEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8, 9])
    ..aOM<MouseMoveEvent>(1, _omitFieldNames ? '' : 'mouseMove',
        subBuilder: MouseMoveEvent.create)
    ..aOM<MouseClickEvent>(2, _omitFieldNames ? '' : 'mouseClick',
        subBuilder: MouseClickEvent.create)
    ..aOM<MouseVScrollEvent>(3, _omitFieldNames ? '' : 'mouseVscroll',
        subBuilder: MouseVScrollEvent.create)
    ..aOM<MouseHScrollEvent>(4, _omitFieldNames ? '' : 'mouseHscroll',
        subBuilder: MouseHScrollEvent.create)
    ..aOM<KeyStringEvent>(5, _omitFieldNames ? '' : 'keyString',
        subBuilder: KeyStringEvent.create)
    ..aOM<KeyControlEvent>(6, _omitFieldNames ? '' : 'keyControl',
        subBuilder: KeyControlEvent.create)
    ..aOM<ControlEvent>(7, _omitFieldNames ? '' : 'controlButton',
        subBuilder: ControlEvent.create)
    ..aOM<HeartBeatReqEvent>(8, _omitFieldNames ? '' : 'heartBeat',
        subBuilder: HeartBeatReqEvent.create)
    ..aOM<VolumeChangeEvent>(9, _omitFieldNames ? '' : 'volumeChange',
        subBuilder: VolumeChangeEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputEvent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputEvent copyWith(void Function(InputEvent) updates) =>
      super.copyWith((message) => updates(message as InputEvent)) as InputEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static InputEvent create() => InputEvent._();
  @$core.override
  InputEvent createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static InputEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InputEvent>(create);
  static InputEvent? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  InputEvent_Payload whichPayload() =>
      _InputEvent_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  @$pb.TagNumber(9)
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  MouseMoveEvent get mouseMove => $_getN(0);
  @$pb.TagNumber(1)
  set mouseMove(MouseMoveEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMouseMove() => $_has(0);
  @$pb.TagNumber(1)
  void clearMouseMove() => $_clearField(1);
  @$pb.TagNumber(1)
  MouseMoveEvent ensureMouseMove() => $_ensure(0);

  @$pb.TagNumber(2)
  MouseClickEvent get mouseClick => $_getN(1);
  @$pb.TagNumber(2)
  set mouseClick(MouseClickEvent value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMouseClick() => $_has(1);
  @$pb.TagNumber(2)
  void clearMouseClick() => $_clearField(2);
  @$pb.TagNumber(2)
  MouseClickEvent ensureMouseClick() => $_ensure(1);

  @$pb.TagNumber(3)
  MouseVScrollEvent get mouseVscroll => $_getN(2);
  @$pb.TagNumber(3)
  set mouseVscroll(MouseVScrollEvent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMouseVscroll() => $_has(2);
  @$pb.TagNumber(3)
  void clearMouseVscroll() => $_clearField(3);
  @$pb.TagNumber(3)
  MouseVScrollEvent ensureMouseVscroll() => $_ensure(2);

  @$pb.TagNumber(4)
  MouseHScrollEvent get mouseHscroll => $_getN(3);
  @$pb.TagNumber(4)
  set mouseHscroll(MouseHScrollEvent value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMouseHscroll() => $_has(3);
  @$pb.TagNumber(4)
  void clearMouseHscroll() => $_clearField(4);
  @$pb.TagNumber(4)
  MouseHScrollEvent ensureMouseHscroll() => $_ensure(3);

  @$pb.TagNumber(5)
  KeyStringEvent get keyString => $_getN(4);
  @$pb.TagNumber(5)
  set keyString(KeyStringEvent value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasKeyString() => $_has(4);
  @$pb.TagNumber(5)
  void clearKeyString() => $_clearField(5);
  @$pb.TagNumber(5)
  KeyStringEvent ensureKeyString() => $_ensure(4);

  @$pb.TagNumber(6)
  KeyControlEvent get keyControl => $_getN(5);
  @$pb.TagNumber(6)
  set keyControl(KeyControlEvent value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasKeyControl() => $_has(5);
  @$pb.TagNumber(6)
  void clearKeyControl() => $_clearField(6);
  @$pb.TagNumber(6)
  KeyControlEvent ensureKeyControl() => $_ensure(5);

  @$pb.TagNumber(7)
  ControlEvent get controlButton => $_getN(6);
  @$pb.TagNumber(7)
  set controlButton(ControlEvent value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasControlButton() => $_has(6);
  @$pb.TagNumber(7)
  void clearControlButton() => $_clearField(7);
  @$pb.TagNumber(7)
  ControlEvent ensureControlButton() => $_ensure(6);

  @$pb.TagNumber(8)
  HeartBeatReqEvent get heartBeat => $_getN(7);
  @$pb.TagNumber(8)
  set heartBeat(HeartBeatReqEvent value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasHeartBeat() => $_has(7);
  @$pb.TagNumber(8)
  void clearHeartBeat() => $_clearField(8);
  @$pb.TagNumber(8)
  HeartBeatReqEvent ensureHeartBeat() => $_ensure(7);

  @$pb.TagNumber(9)
  VolumeChangeEvent get volumeChange => $_getN(8);
  @$pb.TagNumber(9)
  set volumeChange(VolumeChangeEvent value) => $_setField(9, value);
  @$pb.TagNumber(9)
  $core.bool hasVolumeChange() => $_has(8);
  @$pb.TagNumber(9)
  void clearVolumeChange() => $_clearField(9);
  @$pb.TagNumber(9)
  VolumeChangeEvent ensureVolumeChange() => $_ensure(8);
}

enum Response_Payload {
  heartBeat,
  upgradeRequest,
  muteChange,
  volumeChange,
  powerChange,
  stateUpdated,
  notSet
}

class Response extends $pb.GeneratedMessage {
  factory Response({
    HeartBeatRespEvent? heartBeat,
    UpgradeRequestEvent? upgradeRequest,
    MuteChangeEvent? muteChange,
    VolumeChangeEvent? volumeChange,
    PowerChangeEvent? powerChange,
    StateUpdatedEvent? stateUpdated,
  }) {
    final result = create();
    if (heartBeat != null) result.heartBeat = heartBeat;
    if (upgradeRequest != null) result.upgradeRequest = upgradeRequest;
    if (muteChange != null) result.muteChange = muteChange;
    if (volumeChange != null) result.volumeChange = volumeChange;
    if (powerChange != null) result.powerChange = powerChange;
    if (stateUpdated != null) result.stateUpdated = stateUpdated;
    return result;
  }

  Response._();

  factory Response.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory Response.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Response_Payload> _Response_PayloadByTag = {
    1: Response_Payload.heartBeat,
    2: Response_Payload.upgradeRequest,
    3: Response_Payload.muteChange,
    4: Response_Payload.volumeChange,
    5: Response_Payload.powerChange,
    6: Response_Payload.stateUpdated,
    0: Response_Payload.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Response',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'msg'),
      createEmptyInstance: create)
    ..oo(0, [1, 2, 3, 4, 5, 6])
    ..aOM<HeartBeatRespEvent>(1, _omitFieldNames ? '' : 'heartBeat',
        subBuilder: HeartBeatRespEvent.create)
    ..aOM<UpgradeRequestEvent>(2, _omitFieldNames ? '' : 'upgradeRequest',
        subBuilder: UpgradeRequestEvent.create)
    ..aOM<MuteChangeEvent>(3, _omitFieldNames ? '' : 'muteChange',
        subBuilder: MuteChangeEvent.create)
    ..aOM<VolumeChangeEvent>(4, _omitFieldNames ? '' : 'volumeChange',
        subBuilder: VolumeChangeEvent.create)
    ..aOM<PowerChangeEvent>(5, _omitFieldNames ? '' : 'powerChange',
        subBuilder: PowerChangeEvent.create)
    ..aOM<StateUpdatedEvent>(6, _omitFieldNames ? '' : 'stateUpdated',
        subBuilder: StateUpdatedEvent.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Response copyWith(void Function(Response) updates) =>
      super.copyWith((message) => updates(message as Response)) as Response;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Response create() => Response._();
  @$core.override
  Response createEmptyInstance() => create();
  @$core.pragma('dart2js:noInline')
  static Response getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Response>(create);
  static Response? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  Response_Payload whichPayload() => _Response_PayloadByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  void clearPayload() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  HeartBeatRespEvent get heartBeat => $_getN(0);
  @$pb.TagNumber(1)
  set heartBeat(HeartBeatRespEvent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasHeartBeat() => $_has(0);
  @$pb.TagNumber(1)
  void clearHeartBeat() => $_clearField(1);
  @$pb.TagNumber(1)
  HeartBeatRespEvent ensureHeartBeat() => $_ensure(0);

  @$pb.TagNumber(2)
  UpgradeRequestEvent get upgradeRequest => $_getN(1);
  @$pb.TagNumber(2)
  set upgradeRequest(UpgradeRequestEvent value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUpgradeRequest() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpgradeRequest() => $_clearField(2);
  @$pb.TagNumber(2)
  UpgradeRequestEvent ensureUpgradeRequest() => $_ensure(1);

  @$pb.TagNumber(3)
  MuteChangeEvent get muteChange => $_getN(2);
  @$pb.TagNumber(3)
  set muteChange(MuteChangeEvent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMuteChange() => $_has(2);
  @$pb.TagNumber(3)
  void clearMuteChange() => $_clearField(3);
  @$pb.TagNumber(3)
  MuteChangeEvent ensureMuteChange() => $_ensure(2);

  @$pb.TagNumber(4)
  VolumeChangeEvent get volumeChange => $_getN(3);
  @$pb.TagNumber(4)
  set volumeChange(VolumeChangeEvent value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasVolumeChange() => $_has(3);
  @$pb.TagNumber(4)
  void clearVolumeChange() => $_clearField(4);
  @$pb.TagNumber(4)
  VolumeChangeEvent ensureVolumeChange() => $_ensure(3);

  @$pb.TagNumber(5)
  PowerChangeEvent get powerChange => $_getN(4);
  @$pb.TagNumber(5)
  set powerChange(PowerChangeEvent value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPowerChange() => $_has(4);
  @$pb.TagNumber(5)
  void clearPowerChange() => $_clearField(5);
  @$pb.TagNumber(5)
  PowerChangeEvent ensurePowerChange() => $_ensure(4);

  @$pb.TagNumber(6)
  StateUpdatedEvent get stateUpdated => $_getN(5);
  @$pb.TagNumber(6)
  set stateUpdated(StateUpdatedEvent value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasStateUpdated() => $_has(5);
  @$pb.TagNumber(6)
  void clearStateUpdated() => $_clearField(6);
  @$pb.TagNumber(6)
  StateUpdatedEvent ensureStateUpdated() => $_ensure(5);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
