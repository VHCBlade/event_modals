import 'package:event_bloc/event_bloc_widgets.dart';
import 'package:flutter/material.dart';

typedef HandleDialogResponse<T> = void Function(
    BlocEventChannel eventChannel, T response);
typedef HandleDialogDispose = void Function(BlocEventChannel eventChannel);

/// Convenience Function for getting a [BlocEventChannel] from the [context] before calling [showDialog].
///
/// The [BlocEventChannel] is exposed in both [onResponse] and [onNullResponse]
///
/// [defaultValue] is what the value is set to if the modal returns null. By default this will just be null.
///
/// [onNullResponse] is only called if [defaultValue] is also null.
///
/// [showModal] if false, will cause no modal to be shown. Instead it will be as if the modal was just immediately dismissed by the user.
/// This means that the value of [defaultValue] will be used.
Future<T?> showEventDialog<T>({
  required BuildContext context,
  required Widget Function(BuildContext) builder,
  bool useRootNavigator = false,
  bool useSafeArea = true,
  required HandleDialogResponse<T> onResponse,
  HandleDialogDispose? onNullResponse,
  bool showModal = true,
  T? defaultValue,
}) async {
  final eventChannel = context.eventChannel;
  final value = !showModal
      ? defaultValue
      : await showDialog<T>(
            context: context,
            builder: builder,
            useRootNavigator: useRootNavigator,
            useSafeArea: useSafeArea,
          ) ??
          defaultValue;

  if (value == null) {
    onNullResponse == null ? null : onNullResponse(eventChannel);
    return null;
  }

  onResponse(eventChannel, value);
  return value;
}
