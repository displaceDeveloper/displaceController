// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainState implements DiagnosticableTreeMixin {

 bool get showStatusBar; bool get showAppBar; bool get isFirstLaunch; bool get showSearch; bool get showKeyboard; String get keyboardInputPlaceholder; String? get lastString; bool get isTurningOn; bool get isTurningOff; String? get activeDeviceName; bool get showRename; String? get renameTvId;// Connection info
 String? get tvCode; String? get pairingCode;
/// Create a copy of MainState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainStateCopyWith<MainState> get copyWith => _$MainStateCopyWithImpl<MainState>(this as MainState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MainState'))
    ..add(DiagnosticsProperty('showStatusBar', showStatusBar))..add(DiagnosticsProperty('showAppBar', showAppBar))..add(DiagnosticsProperty('isFirstLaunch', isFirstLaunch))..add(DiagnosticsProperty('showSearch', showSearch))..add(DiagnosticsProperty('showKeyboard', showKeyboard))..add(DiagnosticsProperty('keyboardInputPlaceholder', keyboardInputPlaceholder))..add(DiagnosticsProperty('lastString', lastString))..add(DiagnosticsProperty('isTurningOn', isTurningOn))..add(DiagnosticsProperty('isTurningOff', isTurningOff))..add(DiagnosticsProperty('activeDeviceName', activeDeviceName))..add(DiagnosticsProperty('showRename', showRename))..add(DiagnosticsProperty('renameTvId', renameTvId))..add(DiagnosticsProperty('tvCode', tvCode))..add(DiagnosticsProperty('pairingCode', pairingCode));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainState&&(identical(other.showStatusBar, showStatusBar) || other.showStatusBar == showStatusBar)&&(identical(other.showAppBar, showAppBar) || other.showAppBar == showAppBar)&&(identical(other.isFirstLaunch, isFirstLaunch) || other.isFirstLaunch == isFirstLaunch)&&(identical(other.showSearch, showSearch) || other.showSearch == showSearch)&&(identical(other.showKeyboard, showKeyboard) || other.showKeyboard == showKeyboard)&&(identical(other.keyboardInputPlaceholder, keyboardInputPlaceholder) || other.keyboardInputPlaceholder == keyboardInputPlaceholder)&&(identical(other.lastString, lastString) || other.lastString == lastString)&&(identical(other.isTurningOn, isTurningOn) || other.isTurningOn == isTurningOn)&&(identical(other.isTurningOff, isTurningOff) || other.isTurningOff == isTurningOff)&&(identical(other.activeDeviceName, activeDeviceName) || other.activeDeviceName == activeDeviceName)&&(identical(other.showRename, showRename) || other.showRename == showRename)&&(identical(other.renameTvId, renameTvId) || other.renameTvId == renameTvId)&&(identical(other.tvCode, tvCode) || other.tvCode == tvCode)&&(identical(other.pairingCode, pairingCode) || other.pairingCode == pairingCode));
}


@override
int get hashCode => Object.hash(runtimeType,showStatusBar,showAppBar,isFirstLaunch,showSearch,showKeyboard,keyboardInputPlaceholder,lastString,isTurningOn,isTurningOff,activeDeviceName,showRename,renameTvId,tvCode,pairingCode);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MainState(showStatusBar: $showStatusBar, showAppBar: $showAppBar, isFirstLaunch: $isFirstLaunch, showSearch: $showSearch, showKeyboard: $showKeyboard, keyboardInputPlaceholder: $keyboardInputPlaceholder, lastString: $lastString, isTurningOn: $isTurningOn, isTurningOff: $isTurningOff, activeDeviceName: $activeDeviceName, showRename: $showRename, renameTvId: $renameTvId, tvCode: $tvCode, pairingCode: $pairingCode)';
}


}

/// @nodoc
abstract mixin class $MainStateCopyWith<$Res>  {
  factory $MainStateCopyWith(MainState value, $Res Function(MainState) _then) = _$MainStateCopyWithImpl;
@useResult
$Res call({
 bool showStatusBar, bool showAppBar, bool isFirstLaunch, bool showSearch, bool showKeyboard, String keyboardInputPlaceholder, String? lastString, bool isTurningOn, bool isTurningOff, String? activeDeviceName, bool showRename, String? renameTvId, String? tvCode, String? pairingCode
});




}
/// @nodoc
class _$MainStateCopyWithImpl<$Res>
    implements $MainStateCopyWith<$Res> {
  _$MainStateCopyWithImpl(this._self, this._then);

  final MainState _self;
  final $Res Function(MainState) _then;

/// Create a copy of MainState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showStatusBar = null,Object? showAppBar = null,Object? isFirstLaunch = null,Object? showSearch = null,Object? showKeyboard = null,Object? keyboardInputPlaceholder = null,Object? lastString = freezed,Object? isTurningOn = null,Object? isTurningOff = null,Object? activeDeviceName = freezed,Object? showRename = null,Object? renameTvId = freezed,Object? tvCode = freezed,Object? pairingCode = freezed,}) {
  return _then(_self.copyWith(
showStatusBar: null == showStatusBar ? _self.showStatusBar : showStatusBar // ignore: cast_nullable_to_non_nullable
as bool,showAppBar: null == showAppBar ? _self.showAppBar : showAppBar // ignore: cast_nullable_to_non_nullable
as bool,isFirstLaunch: null == isFirstLaunch ? _self.isFirstLaunch : isFirstLaunch // ignore: cast_nullable_to_non_nullable
as bool,showSearch: null == showSearch ? _self.showSearch : showSearch // ignore: cast_nullable_to_non_nullable
as bool,showKeyboard: null == showKeyboard ? _self.showKeyboard : showKeyboard // ignore: cast_nullable_to_non_nullable
as bool,keyboardInputPlaceholder: null == keyboardInputPlaceholder ? _self.keyboardInputPlaceholder : keyboardInputPlaceholder // ignore: cast_nullable_to_non_nullable
as String,lastString: freezed == lastString ? _self.lastString : lastString // ignore: cast_nullable_to_non_nullable
as String?,isTurningOn: null == isTurningOn ? _self.isTurningOn : isTurningOn // ignore: cast_nullable_to_non_nullable
as bool,isTurningOff: null == isTurningOff ? _self.isTurningOff : isTurningOff // ignore: cast_nullable_to_non_nullable
as bool,activeDeviceName: freezed == activeDeviceName ? _self.activeDeviceName : activeDeviceName // ignore: cast_nullable_to_non_nullable
as String?,showRename: null == showRename ? _self.showRename : showRename // ignore: cast_nullable_to_non_nullable
as bool,renameTvId: freezed == renameTvId ? _self.renameTvId : renameTvId // ignore: cast_nullable_to_non_nullable
as String?,tvCode: freezed == tvCode ? _self.tvCode : tvCode // ignore: cast_nullable_to_non_nullable
as String?,pairingCode: freezed == pairingCode ? _self.pairingCode : pairingCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MainState].
extension MainStatePatterns on MainState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MainIdle value)?  idle,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MainIdle() when idle != null:
return idle(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MainIdle value)  idle,}){
final _that = this;
switch (_that) {
case MainIdle():
return idle(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MainIdle value)?  idle,}){
final _that = this;
switch (_that) {
case MainIdle() when idle != null:
return idle(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool showStatusBar,  bool showAppBar,  bool isFirstLaunch,  bool showSearch,  bool showKeyboard,  String keyboardInputPlaceholder,  String? lastString,  bool isTurningOn,  bool isTurningOff,  String? activeDeviceName,  bool showRename,  String? renameTvId,  String? tvCode,  String? pairingCode)?  idle,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MainIdle() when idle != null:
return idle(_that.showStatusBar,_that.showAppBar,_that.isFirstLaunch,_that.showSearch,_that.showKeyboard,_that.keyboardInputPlaceholder,_that.lastString,_that.isTurningOn,_that.isTurningOff,_that.activeDeviceName,_that.showRename,_that.renameTvId,_that.tvCode,_that.pairingCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool showStatusBar,  bool showAppBar,  bool isFirstLaunch,  bool showSearch,  bool showKeyboard,  String keyboardInputPlaceholder,  String? lastString,  bool isTurningOn,  bool isTurningOff,  String? activeDeviceName,  bool showRename,  String? renameTvId,  String? tvCode,  String? pairingCode)  idle,}) {final _that = this;
switch (_that) {
case MainIdle():
return idle(_that.showStatusBar,_that.showAppBar,_that.isFirstLaunch,_that.showSearch,_that.showKeyboard,_that.keyboardInputPlaceholder,_that.lastString,_that.isTurningOn,_that.isTurningOff,_that.activeDeviceName,_that.showRename,_that.renameTvId,_that.tvCode,_that.pairingCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool showStatusBar,  bool showAppBar,  bool isFirstLaunch,  bool showSearch,  bool showKeyboard,  String keyboardInputPlaceholder,  String? lastString,  bool isTurningOn,  bool isTurningOff,  String? activeDeviceName,  bool showRename,  String? renameTvId,  String? tvCode,  String? pairingCode)?  idle,}) {final _that = this;
switch (_that) {
case MainIdle() when idle != null:
return idle(_that.showStatusBar,_that.showAppBar,_that.isFirstLaunch,_that.showSearch,_that.showKeyboard,_that.keyboardInputPlaceholder,_that.lastString,_that.isTurningOn,_that.isTurningOff,_that.activeDeviceName,_that.showRename,_that.renameTvId,_that.tvCode,_that.pairingCode);case _:
  return null;

}
}

}

/// @nodoc


class MainIdle with DiagnosticableTreeMixin implements MainState {
  const MainIdle({required this.showStatusBar, required this.showAppBar, required this.isFirstLaunch, required this.showSearch, required this.showKeyboard, required this.keyboardInputPlaceholder, this.lastString, required this.isTurningOn, required this.isTurningOff, this.activeDeviceName, required this.showRename, this.renameTvId, this.tvCode, this.pairingCode});
  

@override final  bool showStatusBar;
@override final  bool showAppBar;
@override final  bool isFirstLaunch;
@override final  bool showSearch;
@override final  bool showKeyboard;
@override final  String keyboardInputPlaceholder;
@override final  String? lastString;
@override final  bool isTurningOn;
@override final  bool isTurningOff;
@override final  String? activeDeviceName;
@override final  bool showRename;
@override final  String? renameTvId;
// Connection info
@override final  String? tvCode;
@override final  String? pairingCode;

/// Create a copy of MainState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainIdleCopyWith<MainIdle> get copyWith => _$MainIdleCopyWithImpl<MainIdle>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'MainState.idle'))
    ..add(DiagnosticsProperty('showStatusBar', showStatusBar))..add(DiagnosticsProperty('showAppBar', showAppBar))..add(DiagnosticsProperty('isFirstLaunch', isFirstLaunch))..add(DiagnosticsProperty('showSearch', showSearch))..add(DiagnosticsProperty('showKeyboard', showKeyboard))..add(DiagnosticsProperty('keyboardInputPlaceholder', keyboardInputPlaceholder))..add(DiagnosticsProperty('lastString', lastString))..add(DiagnosticsProperty('isTurningOn', isTurningOn))..add(DiagnosticsProperty('isTurningOff', isTurningOff))..add(DiagnosticsProperty('activeDeviceName', activeDeviceName))..add(DiagnosticsProperty('showRename', showRename))..add(DiagnosticsProperty('renameTvId', renameTvId))..add(DiagnosticsProperty('tvCode', tvCode))..add(DiagnosticsProperty('pairingCode', pairingCode));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainIdle&&(identical(other.showStatusBar, showStatusBar) || other.showStatusBar == showStatusBar)&&(identical(other.showAppBar, showAppBar) || other.showAppBar == showAppBar)&&(identical(other.isFirstLaunch, isFirstLaunch) || other.isFirstLaunch == isFirstLaunch)&&(identical(other.showSearch, showSearch) || other.showSearch == showSearch)&&(identical(other.showKeyboard, showKeyboard) || other.showKeyboard == showKeyboard)&&(identical(other.keyboardInputPlaceholder, keyboardInputPlaceholder) || other.keyboardInputPlaceholder == keyboardInputPlaceholder)&&(identical(other.lastString, lastString) || other.lastString == lastString)&&(identical(other.isTurningOn, isTurningOn) || other.isTurningOn == isTurningOn)&&(identical(other.isTurningOff, isTurningOff) || other.isTurningOff == isTurningOff)&&(identical(other.activeDeviceName, activeDeviceName) || other.activeDeviceName == activeDeviceName)&&(identical(other.showRename, showRename) || other.showRename == showRename)&&(identical(other.renameTvId, renameTvId) || other.renameTvId == renameTvId)&&(identical(other.tvCode, tvCode) || other.tvCode == tvCode)&&(identical(other.pairingCode, pairingCode) || other.pairingCode == pairingCode));
}


@override
int get hashCode => Object.hash(runtimeType,showStatusBar,showAppBar,isFirstLaunch,showSearch,showKeyboard,keyboardInputPlaceholder,lastString,isTurningOn,isTurningOff,activeDeviceName,showRename,renameTvId,tvCode,pairingCode);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'MainState.idle(showStatusBar: $showStatusBar, showAppBar: $showAppBar, isFirstLaunch: $isFirstLaunch, showSearch: $showSearch, showKeyboard: $showKeyboard, keyboardInputPlaceholder: $keyboardInputPlaceholder, lastString: $lastString, isTurningOn: $isTurningOn, isTurningOff: $isTurningOff, activeDeviceName: $activeDeviceName, showRename: $showRename, renameTvId: $renameTvId, tvCode: $tvCode, pairingCode: $pairingCode)';
}


}

/// @nodoc
abstract mixin class $MainIdleCopyWith<$Res> implements $MainStateCopyWith<$Res> {
  factory $MainIdleCopyWith(MainIdle value, $Res Function(MainIdle) _then) = _$MainIdleCopyWithImpl;
@override @useResult
$Res call({
 bool showStatusBar, bool showAppBar, bool isFirstLaunch, bool showSearch, bool showKeyboard, String keyboardInputPlaceholder, String? lastString, bool isTurningOn, bool isTurningOff, String? activeDeviceName, bool showRename, String? renameTvId, String? tvCode, String? pairingCode
});




}
/// @nodoc
class _$MainIdleCopyWithImpl<$Res>
    implements $MainIdleCopyWith<$Res> {
  _$MainIdleCopyWithImpl(this._self, this._then);

  final MainIdle _self;
  final $Res Function(MainIdle) _then;

/// Create a copy of MainState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showStatusBar = null,Object? showAppBar = null,Object? isFirstLaunch = null,Object? showSearch = null,Object? showKeyboard = null,Object? keyboardInputPlaceholder = null,Object? lastString = freezed,Object? isTurningOn = null,Object? isTurningOff = null,Object? activeDeviceName = freezed,Object? showRename = null,Object? renameTvId = freezed,Object? tvCode = freezed,Object? pairingCode = freezed,}) {
  return _then(MainIdle(
showStatusBar: null == showStatusBar ? _self.showStatusBar : showStatusBar // ignore: cast_nullable_to_non_nullable
as bool,showAppBar: null == showAppBar ? _self.showAppBar : showAppBar // ignore: cast_nullable_to_non_nullable
as bool,isFirstLaunch: null == isFirstLaunch ? _self.isFirstLaunch : isFirstLaunch // ignore: cast_nullable_to_non_nullable
as bool,showSearch: null == showSearch ? _self.showSearch : showSearch // ignore: cast_nullable_to_non_nullable
as bool,showKeyboard: null == showKeyboard ? _self.showKeyboard : showKeyboard // ignore: cast_nullable_to_non_nullable
as bool,keyboardInputPlaceholder: null == keyboardInputPlaceholder ? _self.keyboardInputPlaceholder : keyboardInputPlaceholder // ignore: cast_nullable_to_non_nullable
as String,lastString: freezed == lastString ? _self.lastString : lastString // ignore: cast_nullable_to_non_nullable
as String?,isTurningOn: null == isTurningOn ? _self.isTurningOn : isTurningOn // ignore: cast_nullable_to_non_nullable
as bool,isTurningOff: null == isTurningOff ? _self.isTurningOff : isTurningOff // ignore: cast_nullable_to_non_nullable
as bool,activeDeviceName: freezed == activeDeviceName ? _self.activeDeviceName : activeDeviceName // ignore: cast_nullable_to_non_nullable
as String?,showRename: null == showRename ? _self.showRename : showRename // ignore: cast_nullable_to_non_nullable
as bool,renameTvId: freezed == renameTvId ? _self.renameTvId : renameTvId // ignore: cast_nullable_to_non_nullable
as String?,tvCode: freezed == tvCode ? _self.tvCode : tvCode // ignore: cast_nullable_to_non_nullable
as String?,pairingCode: freezed == pairingCode ? _self.pairingCode : pairingCode // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
