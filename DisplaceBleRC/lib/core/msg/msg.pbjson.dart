// This is a generated file - do not edit.
//
// Generated from msg.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use mouseButtonDescriptor instead')
const MouseButton$json = {
  '1': 'MouseButton',
  '2': [
    {'1': 'MOUSE_BUTTON_LEFT', '2': 0},
    {'1': 'MOUSE_BUTTON_RIGHT', '2': 1},
  ],
};

/// Descriptor for `MouseButton`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mouseButtonDescriptor = $convert.base64Decode(
    'CgtNb3VzZUJ1dHRvbhIVChFNT1VTRV9CVVRUT05fTEVGVBAAEhYKEk1PVVNFX0JVVFRPTl9SSU'
    'dIVBAB');

@$core.Deprecated('Use keyControlDescriptor instead')
const KeyControl$json = {
  '1': 'KeyControl',
  '2': [
    {'1': 'KEY_BACKSPACE', '2': 0},
    {'1': 'KEY_ENTER', '2': 1},
    {'1': 'KEY_ESCAPE', '2': 2},
  ],
};

/// Descriptor for `KeyControl`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List keyControlDescriptor = $convert.base64Decode(
    'CgpLZXlDb250cm9sEhEKDUtFWV9CQUNLU1BBQ0UQABINCglLRVlfRU5URVIQARIOCgpLRVlfRV'
    'NDQVBFEAI=');

@$core.Deprecated('Use controlTypeDescriptor instead')
const ControlType$json = {
  '1': 'ControlType',
  '2': [
    {'1': 'TYPE_POWER_ON', '2': 0},
    {'1': 'TYPE_POWER_OFF', '2': 1},
    {'1': 'TYPE_SEARCH', '2': 2},
    {'1': 'TYPE_HOME', '2': 3},
    {'1': 'TYPE_BACK', '2': 4},
    {'1': 'TYPE_PLAY_PAUSE', '2': 5},
    {'1': 'TYPE_MUTE_UNMUTE', '2': 6},
  ],
};

/// Descriptor for `ControlType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List controlTypeDescriptor = $convert.base64Decode(
    'CgtDb250cm9sVHlwZRIRCg1UWVBFX1BPV0VSX09OEAASEgoOVFlQRV9QT1dFUl9PRkYQARIPCg'
    'tUWVBFX1NFQVJDSBACEg0KCVRZUEVfSE9NRRADEg0KCVRZUEVfQkFDSxAEEhMKD1RZUEVfUExB'
    'WV9QQVVTRRAFEhQKEFRZUEVfTVVURV9VTk1VVEUQBg==');

@$core.Deprecated('Use mouseMoveEventDescriptor instead')
const MouseMoveEvent$json = {
  '1': 'MouseMoveEvent',
  '2': [
    {'1': 'dx', '3': 1, '4': 1, '5': 5, '10': 'dx'},
    {'1': 'dy', '3': 2, '4': 1, '5': 5, '10': 'dy'},
  ],
};

/// Descriptor for `MouseMoveEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseMoveEventDescriptor = $convert.base64Decode(
    'Cg5Nb3VzZU1vdmVFdmVudBIOCgJkeBgBIAEoBVICZHgSDgoCZHkYAiABKAVSAmR5');

@$core.Deprecated('Use mouseClickEventDescriptor instead')
const MouseClickEvent$json = {
  '1': 'MouseClickEvent',
  '2': [
    {
      '1': 'button',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.msg.MouseButton',
      '10': 'button'
    },
  ],
};

/// Descriptor for `MouseClickEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseClickEventDescriptor = $convert.base64Decode(
    'Cg9Nb3VzZUNsaWNrRXZlbnQSKAoGYnV0dG9uGAEgASgOMhAubXNnLk1vdXNlQnV0dG9uUgZidX'
    'R0b24=');

@$core.Deprecated('Use mouseVScrollEventDescriptor instead')
const MouseVScrollEvent$json = {
  '1': 'MouseVScrollEvent',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `MouseVScrollEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseVScrollEventDescriptor = $convert
    .base64Decode('ChFNb3VzZVZTY3JvbGxFdmVudBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWU=');

@$core.Deprecated('Use mouseHScrollEventDescriptor instead')
const MouseHScrollEvent$json = {
  '1': 'MouseHScrollEvent',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 1, '10': 'value'},
  ],
};

/// Descriptor for `MouseHScrollEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mouseHScrollEventDescriptor = $convert
    .base64Decode('ChFNb3VzZUhTY3JvbGxFdmVudBIUCgV2YWx1ZRgBIAEoAVIFdmFsdWU=');

@$core.Deprecated('Use keyStringEventDescriptor instead')
const KeyStringEvent$json = {
  '1': 'KeyStringEvent',
  '2': [
    {'1': 'str', '3': 1, '4': 1, '5': 9, '10': 'str'},
  ],
};

/// Descriptor for `KeyStringEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyStringEventDescriptor =
    $convert.base64Decode('Cg5LZXlTdHJpbmdFdmVudBIQCgNzdHIYASABKAlSA3N0cg==');

@$core.Deprecated('Use keyControlEventDescriptor instead')
const KeyControlEvent$json = {
  '1': 'KeyControlEvent',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 14, '6': '.msg.KeyControl', '10': 'key'},
  ],
};

/// Descriptor for `KeyControlEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List keyControlEventDescriptor = $convert.base64Decode(
    'Cg9LZXlDb250cm9sRXZlbnQSIQoDa2V5GAEgASgOMg8ubXNnLktleUNvbnRyb2xSA2tleQ==');

@$core.Deprecated('Use controlEventDescriptor instead')
const ControlEvent$json = {
  '1': 'ControlEvent',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.msg.ControlType',
      '10': 'type'
    },
    {'1': 'value', '3': 2, '4': 1, '5': 5, '9': 0, '10': 'value', '17': true},
  ],
  '8': [
    {'1': '_value'},
  ],
};

/// Descriptor for `ControlEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List controlEventDescriptor = $convert.base64Decode(
    'CgxDb250cm9sRXZlbnQSJAoEdHlwZRgBIAEoDjIQLm1zZy5Db250cm9sVHlwZVIEdHlwZRIZCg'
    'V2YWx1ZRgCIAEoBUgAUgV2YWx1ZYgBAUIICgZfdmFsdWU=');

@$core.Deprecated('Use heartBeatReqEventDescriptor instead')
const HeartBeatReqEvent$json = {
  '1': 'HeartBeatReqEvent',
  '2': [
    {
      '1': 'version',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'version',
      '17': true
    },
  ],
  '8': [
    {'1': '_version'},
  ],
};

/// Descriptor for `HeartBeatReqEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heartBeatReqEventDescriptor = $convert.base64Decode(
    'ChFIZWFydEJlYXRSZXFFdmVudBIdCgd2ZXJzaW9uGAEgASgJSABSB3ZlcnNpb26IAQFCCgoIX3'
    'ZlcnNpb24=');

@$core.Deprecated('Use heartBeatRespEventDescriptor instead')
const HeartBeatRespEvent$json = {
  '1': 'HeartBeatRespEvent',
  '2': [
    {'1': 'seq', '3': 1, '4': 1, '5': 5, '10': 'seq'},
  ],
};

/// Descriptor for `HeartBeatRespEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heartBeatRespEventDescriptor = $convert
    .base64Decode('ChJIZWFydEJlYXRSZXNwRXZlbnQSEAoDc2VxGAEgASgFUgNzZXE=');

@$core.Deprecated('Use upgradeRequestEventDescriptor instead')
const UpgradeRequestEvent$json = {
  '1': 'UpgradeRequestEvent',
  '2': [
    {'1': 'new_version', '3': 1, '4': 1, '5': 9, '10': 'newVersion'},
    {'1': 'download_url', '3': 2, '4': 1, '5': 9, '10': 'downloadUrl'},
    {'1': 'min_version', '3': 3, '4': 1, '5': 9, '10': 'minVersion'},
    {'1': 'max_version', '3': 4, '4': 1, '5': 9, '10': 'maxVersion'},
  ],
};

/// Descriptor for `UpgradeRequestEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List upgradeRequestEventDescriptor = $convert.base64Decode(
    'ChNVcGdyYWRlUmVxdWVzdEV2ZW50Eh8KC25ld192ZXJzaW9uGAEgASgJUgpuZXdWZXJzaW9uEi'
    'EKDGRvd25sb2FkX3VybBgCIAEoCVILZG93bmxvYWRVcmwSHwoLbWluX3ZlcnNpb24YAyABKAlS'
    'Cm1pblZlcnNpb24SHwoLbWF4X3ZlcnNpb24YBCABKAlSCm1heFZlcnNpb24=');

@$core.Deprecated('Use muteChangeEventDescriptor instead')
const MuteChangeEvent$json = {
  '1': 'MuteChangeEvent',
  '2': [
    {'1': 'is_muted', '3': 1, '4': 1, '5': 8, '10': 'isMuted'},
  ],
};

/// Descriptor for `MuteChangeEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List muteChangeEventDescriptor = $convert.base64Decode(
    'Cg9NdXRlQ2hhbmdlRXZlbnQSGQoIaXNfbXV0ZWQYASABKAhSB2lzTXV0ZWQ=');

@$core.Deprecated('Use volumeChangeEventDescriptor instead')
const VolumeChangeEvent$json = {
  '1': 'VolumeChangeEvent',
  '2': [
    {'1': 'volume', '3': 1, '4': 1, '5': 1, '10': 'volume'},
  ],
};

/// Descriptor for `VolumeChangeEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List volumeChangeEventDescriptor = $convert.base64Decode(
    'ChFWb2x1bWVDaGFuZ2VFdmVudBIWCgZ2b2x1bWUYASABKAFSBnZvbHVtZQ==');

@$core.Deprecated('Use powerChangeEventDescriptor instead')
const PowerChangeEvent$json = {
  '1': 'PowerChangeEvent',
  '2': [
    {'1': 'is_powered_on', '3': 1, '4': 1, '5': 8, '10': 'isPoweredOn'},
  ],
};

/// Descriptor for `PowerChangeEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List powerChangeEventDescriptor = $convert.base64Decode(
    'ChBQb3dlckNoYW5nZUV2ZW50EiIKDWlzX3Bvd2VyZWRfb24YASABKAhSC2lzUG93ZXJlZE9u');

@$core.Deprecated('Use stateUpdatedEventDescriptor instead')
const StateUpdatedEvent$json = {
  '1': 'StateUpdatedEvent',
  '2': [
    {'1': 'is_powered_on', '3': 1, '4': 1, '5': 8, '10': 'isPoweredOn'},
    {'1': 'is_muted', '3': 2, '4': 1, '5': 8, '10': 'isMuted'},
    {'1': 'volume', '3': 3, '4': 1, '5': 1, '10': 'volume'},
  ],
};

/// Descriptor for `StateUpdatedEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List stateUpdatedEventDescriptor = $convert.base64Decode(
    'ChFTdGF0ZVVwZGF0ZWRFdmVudBIiCg1pc19wb3dlcmVkX29uGAEgASgIUgtpc1Bvd2VyZWRPbh'
    'IZCghpc19tdXRlZBgCIAEoCFIHaXNNdXRlZBIWCgZ2b2x1bWUYAyABKAFSBnZvbHVtZQ==');

@$core.Deprecated('Use inputEventDescriptor instead')
const InputEvent$json = {
  '1': 'InputEvent',
  '2': [
    {
      '1': 'mouse_move',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.msg.MouseMoveEvent',
      '9': 0,
      '10': 'mouseMove'
    },
    {
      '1': 'mouse_click',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.msg.MouseClickEvent',
      '9': 0,
      '10': 'mouseClick'
    },
    {
      '1': 'mouse_vscroll',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.msg.MouseVScrollEvent',
      '9': 0,
      '10': 'mouseVscroll'
    },
    {
      '1': 'mouse_hscroll',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.msg.MouseHScrollEvent',
      '9': 0,
      '10': 'mouseHscroll'
    },
    {
      '1': 'key_string',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.msg.KeyStringEvent',
      '9': 0,
      '10': 'keyString'
    },
    {
      '1': 'key_control',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.msg.KeyControlEvent',
      '9': 0,
      '10': 'keyControl'
    },
    {
      '1': 'control_button',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.msg.ControlEvent',
      '9': 0,
      '10': 'controlButton'
    },
    {
      '1': 'heart_beat',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.msg.HeartBeatReqEvent',
      '9': 0,
      '10': 'heartBeat'
    },
    {
      '1': 'volume_change',
      '3': 9,
      '4': 1,
      '5': 11,
      '6': '.msg.VolumeChangeEvent',
      '9': 0,
      '10': 'volumeChange'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `InputEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputEventDescriptor = $convert.base64Decode(
    'CgpJbnB1dEV2ZW50EjQKCm1vdXNlX21vdmUYASABKAsyEy5tc2cuTW91c2VNb3ZlRXZlbnRIAF'
    'IJbW91c2VNb3ZlEjcKC21vdXNlX2NsaWNrGAIgASgLMhQubXNnLk1vdXNlQ2xpY2tFdmVudEgA'
    'Ugptb3VzZUNsaWNrEj0KDW1vdXNlX3ZzY3JvbGwYAyABKAsyFi5tc2cuTW91c2VWU2Nyb2xsRX'
    'ZlbnRIAFIMbW91c2VWc2Nyb2xsEj0KDW1vdXNlX2hzY3JvbGwYBCABKAsyFi5tc2cuTW91c2VI'
    'U2Nyb2xsRXZlbnRIAFIMbW91c2VIc2Nyb2xsEjQKCmtleV9zdHJpbmcYBSABKAsyEy5tc2cuS2'
    'V5U3RyaW5nRXZlbnRIAFIJa2V5U3RyaW5nEjcKC2tleV9jb250cm9sGAYgASgLMhQubXNnLktl'
    'eUNvbnRyb2xFdmVudEgAUgprZXlDb250cm9sEjoKDmNvbnRyb2xfYnV0dG9uGAcgASgLMhEubX'
    'NnLkNvbnRyb2xFdmVudEgAUg1jb250cm9sQnV0dG9uEjcKCmhlYXJ0X2JlYXQYCCABKAsyFi5t'
    'c2cuSGVhcnRCZWF0UmVxRXZlbnRIAFIJaGVhcnRCZWF0Ej0KDXZvbHVtZV9jaGFuZ2UYCSABKA'
    'syFi5tc2cuVm9sdW1lQ2hhbmdlRXZlbnRIAFIMdm9sdW1lQ2hhbmdlQgkKB3BheWxvYWQ=');

@$core.Deprecated('Use responseDescriptor instead')
const Response$json = {
  '1': 'Response',
  '2': [
    {
      '1': 'heart_beat',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.msg.HeartBeatRespEvent',
      '9': 0,
      '10': 'heartBeat'
    },
    {
      '1': 'upgrade_request',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.msg.UpgradeRequestEvent',
      '9': 0,
      '10': 'upgradeRequest'
    },
    {
      '1': 'mute_change',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.msg.MuteChangeEvent',
      '9': 0,
      '10': 'muteChange'
    },
    {
      '1': 'volume_change',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.msg.VolumeChangeEvent',
      '9': 0,
      '10': 'volumeChange'
    },
    {
      '1': 'power_change',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.msg.PowerChangeEvent',
      '9': 0,
      '10': 'powerChange'
    },
    {
      '1': 'state_updated',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.msg.StateUpdatedEvent',
      '9': 0,
      '10': 'stateUpdated'
    },
  ],
  '8': [
    {'1': 'payload'},
  ],
};

/// Descriptor for `Response`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDescriptor = $convert.base64Decode(
    'CghSZXNwb25zZRI4CgpoZWFydF9iZWF0GAEgASgLMhcubXNnLkhlYXJ0QmVhdFJlc3BFdmVudE'
    'gAUgloZWFydEJlYXQSQwoPdXBncmFkZV9yZXF1ZXN0GAIgASgLMhgubXNnLlVwZ3JhZGVSZXF1'
    'ZXN0RXZlbnRIAFIOdXBncmFkZVJlcXVlc3QSNwoLbXV0ZV9jaGFuZ2UYAyABKAsyFC5tc2cuTX'
    'V0ZUNoYW5nZUV2ZW50SABSCm11dGVDaGFuZ2USPQoNdm9sdW1lX2NoYW5nZRgEIAEoCzIWLm1z'
    'Zy5Wb2x1bWVDaGFuZ2VFdmVudEgAUgx2b2x1bWVDaGFuZ2USOgoMcG93ZXJfY2hhbmdlGAUgAS'
    'gLMhUubXNnLlBvd2VyQ2hhbmdlRXZlbnRIAFILcG93ZXJDaGFuZ2USPQoNc3RhdGVfdXBkYXRl'
    'ZBgGIAEoCzIWLm1zZy5TdGF0ZVVwZGF0ZWRFdmVudEgAUgxzdGF0ZVVwZGF0ZWRCCQoHcGF5bG'
    '9hZA==');
