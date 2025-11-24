import 'dart:async';

/// A timer utility similar to QML Timer
/// Usage:
/// ```dart
/// final timer = TimerUtil(
///   interval: Duration(milliseconds: 500),
///   onTriggered: () {
///     print('Timer triggered');
///   },
/// );
/// timer.start();
/// timer.stop();
/// ```
class TimerUtil {
  final Duration interval;
  final VoidCallback onTriggered;
  final bool repeat;

  Timer? _timer;
  bool _isRunning = false;

  TimerUtil({
    required this.interval,
    required this.onTriggered,
    this.repeat = true,
  });

  /// Start the timer
  void start() {
    if (_isRunning) return;

    _isRunning = true;
    if (repeat) {
      _timer = Timer.periodic(interval, (timer) {
        onTriggered();
      });
    } else {
      _timer = Timer(interval, () {
        onTriggered();
        _isRunning = false;
      });
    }
  }

  /// Stop the timer
  void stop() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
  }

  /// Restart the timer
  void restart() {
    stop();
    start();
  }

  /// Check if timer is running
  bool get isRunning => _isRunning;

  /// Dispose the timer
  void dispose() {
    stop();
  }
}

typedef VoidCallback = void Function();
