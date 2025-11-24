// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BleState implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BleState'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BleState()';
}


}

/// @nodoc
class $BleStateCopyWith<$Res>  {
$BleStateCopyWith(BleState _, $Res Function(BleState) __);
}


/// Adds pattern-matching-related methods to [BleState].
extension BleStatePatterns on BleState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BleInitialized value)?  initialized,TResult Function( BleConnecting value)?  connecting,TResult Function( BleConnected value)?  connected,TResult Function( BlePaired value)?  paired,TResult Function( BleFailedPairing value)?  failedPairing,TResult Function( BleDisconnected value)?  disconnected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BleInitialized() when initialized != null:
return initialized(_that);case BleConnecting() when connecting != null:
return connecting(_that);case BleConnected() when connected != null:
return connected(_that);case BlePaired() when paired != null:
return paired(_that);case BleFailedPairing() when failedPairing != null:
return failedPairing(_that);case BleDisconnected() when disconnected != null:
return disconnected(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BleInitialized value)  initialized,required TResult Function( BleConnecting value)  connecting,required TResult Function( BleConnected value)  connected,required TResult Function( BlePaired value)  paired,required TResult Function( BleFailedPairing value)  failedPairing,required TResult Function( BleDisconnected value)  disconnected,}){
final _that = this;
switch (_that) {
case BleInitialized():
return initialized(_that);case BleConnecting():
return connecting(_that);case BleConnected():
return connected(_that);case BlePaired():
return paired(_that);case BleFailedPairing():
return failedPairing(_that);case BleDisconnected():
return disconnected(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BleInitialized value)?  initialized,TResult? Function( BleConnecting value)?  connecting,TResult? Function( BleConnected value)?  connected,TResult? Function( BlePaired value)?  paired,TResult? Function( BleFailedPairing value)?  failedPairing,TResult? Function( BleDisconnected value)?  disconnected,}){
final _that = this;
switch (_that) {
case BleInitialized() when initialized != null:
return initialized(_that);case BleConnecting() when connecting != null:
return connecting(_that);case BleConnected() when connected != null:
return connected(_that);case BlePaired() when paired != null:
return paired(_that);case BleFailedPairing() when failedPairing != null:
return failedPairing(_that);case BleDisconnected() when disconnected != null:
return disconnected(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initialized,TResult Function( String? remoteId)?  connecting,TResult Function( String remoteId)?  connected,TResult Function( String remoteId,  String tvCode,  String pairingCode,  BluetoothCharacteristic rxCharacteristic,  BluetoothCharacteristic txCharacteristic,  bool isPoweredOn,  bool isMuted,  int volume,  String? reconnectRemoteId,  int? downloadPercent,  String? newVersion,  String? newVersionUrl)?  paired,TResult Function()?  failedPairing,TResult Function()?  disconnected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BleInitialized() when initialized != null:
return initialized();case BleConnecting() when connecting != null:
return connecting(_that.remoteId);case BleConnected() when connected != null:
return connected(_that.remoteId);case BlePaired() when paired != null:
return paired(_that.remoteId,_that.tvCode,_that.pairingCode,_that.rxCharacteristic,_that.txCharacteristic,_that.isPoweredOn,_that.isMuted,_that.volume,_that.reconnectRemoteId,_that.downloadPercent,_that.newVersion,_that.newVersionUrl);case BleFailedPairing() when failedPairing != null:
return failedPairing();case BleDisconnected() when disconnected != null:
return disconnected();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initialized,required TResult Function( String? remoteId)  connecting,required TResult Function( String remoteId)  connected,required TResult Function( String remoteId,  String tvCode,  String pairingCode,  BluetoothCharacteristic rxCharacteristic,  BluetoothCharacteristic txCharacteristic,  bool isPoweredOn,  bool isMuted,  int volume,  String? reconnectRemoteId,  int? downloadPercent,  String? newVersion,  String? newVersionUrl)  paired,required TResult Function()  failedPairing,required TResult Function()  disconnected,}) {final _that = this;
switch (_that) {
case BleInitialized():
return initialized();case BleConnecting():
return connecting(_that.remoteId);case BleConnected():
return connected(_that.remoteId);case BlePaired():
return paired(_that.remoteId,_that.tvCode,_that.pairingCode,_that.rxCharacteristic,_that.txCharacteristic,_that.isPoweredOn,_that.isMuted,_that.volume,_that.reconnectRemoteId,_that.downloadPercent,_that.newVersion,_that.newVersionUrl);case BleFailedPairing():
return failedPairing();case BleDisconnected():
return disconnected();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initialized,TResult? Function( String? remoteId)?  connecting,TResult? Function( String remoteId)?  connected,TResult? Function( String remoteId,  String tvCode,  String pairingCode,  BluetoothCharacteristic rxCharacteristic,  BluetoothCharacteristic txCharacteristic,  bool isPoweredOn,  bool isMuted,  int volume,  String? reconnectRemoteId,  int? downloadPercent,  String? newVersion,  String? newVersionUrl)?  paired,TResult? Function()?  failedPairing,TResult? Function()?  disconnected,}) {final _that = this;
switch (_that) {
case BleInitialized() when initialized != null:
return initialized();case BleConnecting() when connecting != null:
return connecting(_that.remoteId);case BleConnected() when connected != null:
return connected(_that.remoteId);case BlePaired() when paired != null:
return paired(_that.remoteId,_that.tvCode,_that.pairingCode,_that.rxCharacteristic,_that.txCharacteristic,_that.isPoweredOn,_that.isMuted,_that.volume,_that.reconnectRemoteId,_that.downloadPercent,_that.newVersion,_that.newVersionUrl);case BleFailedPairing() when failedPairing != null:
return failedPairing();case BleDisconnected() when disconnected != null:
return disconnected();case _:
  return null;

}
}

}

/// @nodoc


class BleInitialized with DiagnosticableTreeMixin implements BleState {
  const BleInitialized();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BleState.initialized'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleInitialized);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BleState.initialized()';
}


}




/// @nodoc


class BleConnecting with DiagnosticableTreeMixin implements BleState {
  const BleConnecting({this.remoteId});
  

 final  String? remoteId;

/// Create a copy of BleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BleConnectingCopyWith<BleConnecting> get copyWith => _$BleConnectingCopyWithImpl<BleConnecting>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BleState.connecting'))
    ..add(DiagnosticsProperty('remoteId', remoteId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleConnecting&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId));
}


@override
int get hashCode => Object.hash(runtimeType,remoteId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BleState.connecting(remoteId: $remoteId)';
}


}

/// @nodoc
abstract mixin class $BleConnectingCopyWith<$Res> implements $BleStateCopyWith<$Res> {
  factory $BleConnectingCopyWith(BleConnecting value, $Res Function(BleConnecting) _then) = _$BleConnectingCopyWithImpl;
@useResult
$Res call({
 String? remoteId
});




}
/// @nodoc
class _$BleConnectingCopyWithImpl<$Res>
    implements $BleConnectingCopyWith<$Res> {
  _$BleConnectingCopyWithImpl(this._self, this._then);

  final BleConnecting _self;
  final $Res Function(BleConnecting) _then;

/// Create a copy of BleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? remoteId = freezed,}) {
  return _then(BleConnecting(
remoteId: freezed == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BleConnected with DiagnosticableTreeMixin implements BleState {
  const BleConnected({required this.remoteId});
  

 final  String remoteId;

/// Create a copy of BleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BleConnectedCopyWith<BleConnected> get copyWith => _$BleConnectedCopyWithImpl<BleConnected>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BleState.connected'))
    ..add(DiagnosticsProperty('remoteId', remoteId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleConnected&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId));
}


@override
int get hashCode => Object.hash(runtimeType,remoteId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BleState.connected(remoteId: $remoteId)';
}


}

/// @nodoc
abstract mixin class $BleConnectedCopyWith<$Res> implements $BleStateCopyWith<$Res> {
  factory $BleConnectedCopyWith(BleConnected value, $Res Function(BleConnected) _then) = _$BleConnectedCopyWithImpl;
@useResult
$Res call({
 String remoteId
});




}
/// @nodoc
class _$BleConnectedCopyWithImpl<$Res>
    implements $BleConnectedCopyWith<$Res> {
  _$BleConnectedCopyWithImpl(this._self, this._then);

  final BleConnected _self;
  final $Res Function(BleConnected) _then;

/// Create a copy of BleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? remoteId = null,}) {
  return _then(BleConnected(
remoteId: null == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class BlePaired with DiagnosticableTreeMixin implements BleState {
  const BlePaired({required this.remoteId, required this.tvCode, required this.pairingCode, required this.rxCharacteristic, required this.txCharacteristic, required this.isPoweredOn, required this.isMuted, required this.volume, this.reconnectRemoteId, this.downloadPercent, this.newVersion, this.newVersionUrl});
  

 final  String remoteId;
 final  String tvCode;
 final  String pairingCode;
 final  BluetoothCharacteristic rxCharacteristic;
 final  BluetoothCharacteristic txCharacteristic;
// Heartbeat data
 final  bool isPoweredOn;
 final  bool isMuted;
 final  int volume;
// Id of the device we are reconnecting to
 final  String? reconnectRemoteId;
// Upgrade
 final  int? downloadPercent;
 final  String? newVersion;
 final  String? newVersionUrl;

/// Create a copy of BleState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlePairedCopyWith<BlePaired> get copyWith => _$BlePairedCopyWithImpl<BlePaired>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BleState.paired'))
    ..add(DiagnosticsProperty('remoteId', remoteId))..add(DiagnosticsProperty('tvCode', tvCode))..add(DiagnosticsProperty('pairingCode', pairingCode))..add(DiagnosticsProperty('rxCharacteristic', rxCharacteristic))..add(DiagnosticsProperty('txCharacteristic', txCharacteristic))..add(DiagnosticsProperty('isPoweredOn', isPoweredOn))..add(DiagnosticsProperty('isMuted', isMuted))..add(DiagnosticsProperty('volume', volume))..add(DiagnosticsProperty('reconnectRemoteId', reconnectRemoteId))..add(DiagnosticsProperty('downloadPercent', downloadPercent))..add(DiagnosticsProperty('newVersion', newVersion))..add(DiagnosticsProperty('newVersionUrl', newVersionUrl));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlePaired&&(identical(other.remoteId, remoteId) || other.remoteId == remoteId)&&(identical(other.tvCode, tvCode) || other.tvCode == tvCode)&&(identical(other.pairingCode, pairingCode) || other.pairingCode == pairingCode)&&(identical(other.rxCharacteristic, rxCharacteristic) || other.rxCharacteristic == rxCharacteristic)&&(identical(other.txCharacteristic, txCharacteristic) || other.txCharacteristic == txCharacteristic)&&(identical(other.isPoweredOn, isPoweredOn) || other.isPoweredOn == isPoweredOn)&&(identical(other.isMuted, isMuted) || other.isMuted == isMuted)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.reconnectRemoteId, reconnectRemoteId) || other.reconnectRemoteId == reconnectRemoteId)&&(identical(other.downloadPercent, downloadPercent) || other.downloadPercent == downloadPercent)&&(identical(other.newVersion, newVersion) || other.newVersion == newVersion)&&(identical(other.newVersionUrl, newVersionUrl) || other.newVersionUrl == newVersionUrl));
}


@override
int get hashCode => Object.hash(runtimeType,remoteId,tvCode,pairingCode,rxCharacteristic,txCharacteristic,isPoweredOn,isMuted,volume,reconnectRemoteId,downloadPercent,newVersion,newVersionUrl);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BleState.paired(remoteId: $remoteId, tvCode: $tvCode, pairingCode: $pairingCode, rxCharacteristic: $rxCharacteristic, txCharacteristic: $txCharacteristic, isPoweredOn: $isPoweredOn, isMuted: $isMuted, volume: $volume, reconnectRemoteId: $reconnectRemoteId, downloadPercent: $downloadPercent, newVersion: $newVersion, newVersionUrl: $newVersionUrl)';
}


}

/// @nodoc
abstract mixin class $BlePairedCopyWith<$Res> implements $BleStateCopyWith<$Res> {
  factory $BlePairedCopyWith(BlePaired value, $Res Function(BlePaired) _then) = _$BlePairedCopyWithImpl;
@useResult
$Res call({
 String remoteId, String tvCode, String pairingCode, BluetoothCharacteristic rxCharacteristic, BluetoothCharacteristic txCharacteristic, bool isPoweredOn, bool isMuted, int volume, String? reconnectRemoteId, int? downloadPercent, String? newVersion, String? newVersionUrl
});




}
/// @nodoc
class _$BlePairedCopyWithImpl<$Res>
    implements $BlePairedCopyWith<$Res> {
  _$BlePairedCopyWithImpl(this._self, this._then);

  final BlePaired _self;
  final $Res Function(BlePaired) _then;

/// Create a copy of BleState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? remoteId = null,Object? tvCode = null,Object? pairingCode = null,Object? rxCharacteristic = null,Object? txCharacteristic = null,Object? isPoweredOn = null,Object? isMuted = null,Object? volume = null,Object? reconnectRemoteId = freezed,Object? downloadPercent = freezed,Object? newVersion = freezed,Object? newVersionUrl = freezed,}) {
  return _then(BlePaired(
remoteId: null == remoteId ? _self.remoteId : remoteId // ignore: cast_nullable_to_non_nullable
as String,tvCode: null == tvCode ? _self.tvCode : tvCode // ignore: cast_nullable_to_non_nullable
as String,pairingCode: null == pairingCode ? _self.pairingCode : pairingCode // ignore: cast_nullable_to_non_nullable
as String,rxCharacteristic: null == rxCharacteristic ? _self.rxCharacteristic : rxCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic,txCharacteristic: null == txCharacteristic ? _self.txCharacteristic : txCharacteristic // ignore: cast_nullable_to_non_nullable
as BluetoothCharacteristic,isPoweredOn: null == isPoweredOn ? _self.isPoweredOn : isPoweredOn // ignore: cast_nullable_to_non_nullable
as bool,isMuted: null == isMuted ? _self.isMuted : isMuted // ignore: cast_nullable_to_non_nullable
as bool,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as int,reconnectRemoteId: freezed == reconnectRemoteId ? _self.reconnectRemoteId : reconnectRemoteId // ignore: cast_nullable_to_non_nullable
as String?,downloadPercent: freezed == downloadPercent ? _self.downloadPercent : downloadPercent // ignore: cast_nullable_to_non_nullable
as int?,newVersion: freezed == newVersion ? _self.newVersion : newVersion // ignore: cast_nullable_to_non_nullable
as String?,newVersionUrl: freezed == newVersionUrl ? _self.newVersionUrl : newVersionUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BleFailedPairing with DiagnosticableTreeMixin implements BleState {
  const BleFailedPairing();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BleState.failedPairing'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleFailedPairing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BleState.failedPairing()';
}


}




/// @nodoc


class BleDisconnected with DiagnosticableTreeMixin implements BleState {
  const BleDisconnected();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'BleState.disconnected'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BleDisconnected);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'BleState.disconnected()';
}


}




// dart format on
