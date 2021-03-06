import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:get/src/state_manager/rx/rx_callbacks.dart';

abstract class RxInterface<T> {
  RxInterface([T initial]);

  /// add listener to stream
  void addListener(Stream<T> rxGetx);

  bool get canUpdate;

  /// close stream
  void close() {
    subject?.close();
  }

  StreamController<T> subject;

  /// Calls [callback] with current value, when the value changes.
  StreamSubscription<T> listen(ValueCallback<T> callback);
}

/// Unlike GetxController, which serves to control events on each of its pages,
/// GetxService is not automatically disposed. It is ideal for situations where,
/// once started, that service will remain in memory, such as Auth control for example.
abstract class GetxService extends DisposableInterface {}

abstract class DisposableInterface {
  /// Called at the exact moment that the widget is allocated in memory.
  /// Do not overwrite this method.
  void onStart() {
    onInit();
    SchedulerBinding.instance?.addPostFrameCallback((_) => onReady());
  }

  /// Called Called immediately after the widget is allocated in memory.
  void onInit() async {}

  /// Called after rendering the screen. It is the perfect place to enter navigation events,
  /// be it snackbar, dialogs, or a new route.
  void onReady() async {}

  /// Called before the onDelete method. onClose is used to close events
  /// before the controller is destroyed, such as closing streams, for example.
  onClose() async {}
}
