// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ScreenState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScreenState()';
}


}

/// @nodoc
class $ScreenStateCopyWith<$Res>  {
$ScreenStateCopyWith(ScreenState _, $Res Function(ScreenState) __);
}


/// Adds pattern-matching-related methods to [ScreenState].
extension ScreenStatePatterns on ScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ScreenStatePermissions value)?  permissions,TResult Function( ScreenStateScanQr value)?  scanQr,TResult Function( ScreenStatePairing value)?  pairing,TResult Function( ScreenStatePairError value)?  pairError,TResult Function( ScreenStateSuccessfullyPaired value)?  successfullyPaired,TResult Function( ScreenStateMain value)?  main,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ScreenStatePermissions() when permissions != null:
return permissions(_that);case ScreenStateScanQr() when scanQr != null:
return scanQr(_that);case ScreenStatePairing() when pairing != null:
return pairing(_that);case ScreenStatePairError() when pairError != null:
return pairError(_that);case ScreenStateSuccessfullyPaired() when successfullyPaired != null:
return successfullyPaired(_that);case ScreenStateMain() when main != null:
return main(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ScreenStatePermissions value)  permissions,required TResult Function( ScreenStateScanQr value)  scanQr,required TResult Function( ScreenStatePairing value)  pairing,required TResult Function( ScreenStatePairError value)  pairError,required TResult Function( ScreenStateSuccessfullyPaired value)  successfullyPaired,required TResult Function( ScreenStateMain value)  main,}){
final _that = this;
switch (_that) {
case ScreenStatePermissions():
return permissions(_that);case ScreenStateScanQr():
return scanQr(_that);case ScreenStatePairing():
return pairing(_that);case ScreenStatePairError():
return pairError(_that);case ScreenStateSuccessfullyPaired():
return successfullyPaired(_that);case ScreenStateMain():
return main(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ScreenStatePermissions value)?  permissions,TResult? Function( ScreenStateScanQr value)?  scanQr,TResult? Function( ScreenStatePairing value)?  pairing,TResult? Function( ScreenStatePairError value)?  pairError,TResult? Function( ScreenStateSuccessfullyPaired value)?  successfullyPaired,TResult? Function( ScreenStateMain value)?  main,}){
final _that = this;
switch (_that) {
case ScreenStatePermissions() when permissions != null:
return permissions(_that);case ScreenStateScanQr() when scanQr != null:
return scanQr(_that);case ScreenStatePairing() when pairing != null:
return pairing(_that);case ScreenStatePairError() when pairError != null:
return pairError(_that);case ScreenStateSuccessfullyPaired() when successfullyPaired != null:
return successfullyPaired(_that);case ScreenStateMain() when main != null:
return main(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  permissions,TResult Function( bool cancelable)?  scanQr,TResult Function( bool cancelable)?  pairing,TResult Function( bool cancelable)?  pairError,TResult Function()?  successfullyPaired,TResult Function( String? reconnectDeviceId)?  main,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ScreenStatePermissions() when permissions != null:
return permissions();case ScreenStateScanQr() when scanQr != null:
return scanQr(_that.cancelable);case ScreenStatePairing() when pairing != null:
return pairing(_that.cancelable);case ScreenStatePairError() when pairError != null:
return pairError(_that.cancelable);case ScreenStateSuccessfullyPaired() when successfullyPaired != null:
return successfullyPaired();case ScreenStateMain() when main != null:
return main(_that.reconnectDeviceId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  permissions,required TResult Function( bool cancelable)  scanQr,required TResult Function( bool cancelable)  pairing,required TResult Function( bool cancelable)  pairError,required TResult Function()  successfullyPaired,required TResult Function( String? reconnectDeviceId)  main,}) {final _that = this;
switch (_that) {
case ScreenStatePermissions():
return permissions();case ScreenStateScanQr():
return scanQr(_that.cancelable);case ScreenStatePairing():
return pairing(_that.cancelable);case ScreenStatePairError():
return pairError(_that.cancelable);case ScreenStateSuccessfullyPaired():
return successfullyPaired();case ScreenStateMain():
return main(_that.reconnectDeviceId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  permissions,TResult? Function( bool cancelable)?  scanQr,TResult? Function( bool cancelable)?  pairing,TResult? Function( bool cancelable)?  pairError,TResult? Function()?  successfullyPaired,TResult? Function( String? reconnectDeviceId)?  main,}) {final _that = this;
switch (_that) {
case ScreenStatePermissions() when permissions != null:
return permissions();case ScreenStateScanQr() when scanQr != null:
return scanQr(_that.cancelable);case ScreenStatePairing() when pairing != null:
return pairing(_that.cancelable);case ScreenStatePairError() when pairError != null:
return pairError(_that.cancelable);case ScreenStateSuccessfullyPaired() when successfullyPaired != null:
return successfullyPaired();case ScreenStateMain() when main != null:
return main(_that.reconnectDeviceId);case _:
  return null;

}
}

}

/// @nodoc


class ScreenStatePermissions implements ScreenState {
  const ScreenStatePermissions();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenStatePermissions);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScreenState.permissions()';
}


}




/// @nodoc


class ScreenStateScanQr implements ScreenState {
  const ScreenStateScanQr({required this.cancelable});
  

 final  bool cancelable;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenStateScanQrCopyWith<ScreenStateScanQr> get copyWith => _$ScreenStateScanQrCopyWithImpl<ScreenStateScanQr>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenStateScanQr&&(identical(other.cancelable, cancelable) || other.cancelable == cancelable));
}


@override
int get hashCode => Object.hash(runtimeType,cancelable);

@override
String toString() {
  return 'ScreenState.scanQr(cancelable: $cancelable)';
}


}

/// @nodoc
abstract mixin class $ScreenStateScanQrCopyWith<$Res> implements $ScreenStateCopyWith<$Res> {
  factory $ScreenStateScanQrCopyWith(ScreenStateScanQr value, $Res Function(ScreenStateScanQr) _then) = _$ScreenStateScanQrCopyWithImpl;
@useResult
$Res call({
 bool cancelable
});




}
/// @nodoc
class _$ScreenStateScanQrCopyWithImpl<$Res>
    implements $ScreenStateScanQrCopyWith<$Res> {
  _$ScreenStateScanQrCopyWithImpl(this._self, this._then);

  final ScreenStateScanQr _self;
  final $Res Function(ScreenStateScanQr) _then;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cancelable = null,}) {
  return _then(ScreenStateScanQr(
cancelable: null == cancelable ? _self.cancelable : cancelable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ScreenStatePairing implements ScreenState {
  const ScreenStatePairing({required this.cancelable});
  

 final  bool cancelable;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenStatePairingCopyWith<ScreenStatePairing> get copyWith => _$ScreenStatePairingCopyWithImpl<ScreenStatePairing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenStatePairing&&(identical(other.cancelable, cancelable) || other.cancelable == cancelable));
}


@override
int get hashCode => Object.hash(runtimeType,cancelable);

@override
String toString() {
  return 'ScreenState.pairing(cancelable: $cancelable)';
}


}

/// @nodoc
abstract mixin class $ScreenStatePairingCopyWith<$Res> implements $ScreenStateCopyWith<$Res> {
  factory $ScreenStatePairingCopyWith(ScreenStatePairing value, $Res Function(ScreenStatePairing) _then) = _$ScreenStatePairingCopyWithImpl;
@useResult
$Res call({
 bool cancelable
});




}
/// @nodoc
class _$ScreenStatePairingCopyWithImpl<$Res>
    implements $ScreenStatePairingCopyWith<$Res> {
  _$ScreenStatePairingCopyWithImpl(this._self, this._then);

  final ScreenStatePairing _self;
  final $Res Function(ScreenStatePairing) _then;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cancelable = null,}) {
  return _then(ScreenStatePairing(
cancelable: null == cancelable ? _self.cancelable : cancelable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ScreenStatePairError implements ScreenState {
  const ScreenStatePairError({required this.cancelable});
  

 final  bool cancelable;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenStatePairErrorCopyWith<ScreenStatePairError> get copyWith => _$ScreenStatePairErrorCopyWithImpl<ScreenStatePairError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenStatePairError&&(identical(other.cancelable, cancelable) || other.cancelable == cancelable));
}


@override
int get hashCode => Object.hash(runtimeType,cancelable);

@override
String toString() {
  return 'ScreenState.pairError(cancelable: $cancelable)';
}


}

/// @nodoc
abstract mixin class $ScreenStatePairErrorCopyWith<$Res> implements $ScreenStateCopyWith<$Res> {
  factory $ScreenStatePairErrorCopyWith(ScreenStatePairError value, $Res Function(ScreenStatePairError) _then) = _$ScreenStatePairErrorCopyWithImpl;
@useResult
$Res call({
 bool cancelable
});




}
/// @nodoc
class _$ScreenStatePairErrorCopyWithImpl<$Res>
    implements $ScreenStatePairErrorCopyWith<$Res> {
  _$ScreenStatePairErrorCopyWithImpl(this._self, this._then);

  final ScreenStatePairError _self;
  final $Res Function(ScreenStatePairError) _then;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cancelable = null,}) {
  return _then(ScreenStatePairError(
cancelable: null == cancelable ? _self.cancelable : cancelable // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ScreenStateSuccessfullyPaired implements ScreenState {
  const ScreenStateSuccessfullyPaired();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenStateSuccessfullyPaired);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ScreenState.successfullyPaired()';
}


}




/// @nodoc


class ScreenStateMain implements ScreenState {
  const ScreenStateMain({this.reconnectDeviceId});
  

 final  String? reconnectDeviceId;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScreenStateMainCopyWith<ScreenStateMain> get copyWith => _$ScreenStateMainCopyWithImpl<ScreenStateMain>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ScreenStateMain&&(identical(other.reconnectDeviceId, reconnectDeviceId) || other.reconnectDeviceId == reconnectDeviceId));
}


@override
int get hashCode => Object.hash(runtimeType,reconnectDeviceId);

@override
String toString() {
  return 'ScreenState.main(reconnectDeviceId: $reconnectDeviceId)';
}


}

/// @nodoc
abstract mixin class $ScreenStateMainCopyWith<$Res> implements $ScreenStateCopyWith<$Res> {
  factory $ScreenStateMainCopyWith(ScreenStateMain value, $Res Function(ScreenStateMain) _then) = _$ScreenStateMainCopyWithImpl;
@useResult
$Res call({
 String? reconnectDeviceId
});




}
/// @nodoc
class _$ScreenStateMainCopyWithImpl<$Res>
    implements $ScreenStateMainCopyWith<$Res> {
  _$ScreenStateMainCopyWithImpl(this._self, this._then);

  final ScreenStateMain _self;
  final $Res Function(ScreenStateMain) _then;

/// Create a copy of ScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reconnectDeviceId = freezed,}) {
  return _then(ScreenStateMain(
reconnectDeviceId: freezed == reconnectDeviceId ? _self.reconnectDeviceId : reconnectDeviceId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
