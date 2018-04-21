/// Filename: update_time_reducer.dart
///
/// Description:
/// Provides functions to be used with a [Store] of type [DateTime].
///
/// Updated: 04.16.2018

/// Calls [updateTime] if correct [action] is provided.
DateTime updateTimeReducer(DateTime state, dynamic action) {
  if (action is DateTime)
    return updateTime(action);
  else
    return state;
}

/// Calculates the [DateTime] difference between now and [anniversaryTime]
/// Not fully accurate, as starting [DateTime] is from year = 0 and month = 0.
DateTime updateTime(DateTime anniversaryTime) {
  DateTime currentDateTime = new DateTime.now();

  /// Only go into here when [anniversaryTime] is before the current time.
  if (currentDateTime.isBefore(anniversaryTime)) {
    return null;
  }
  else {
    Duration deltaDuration = currentDateTime.difference(anniversaryTime);
    DateTime deltaDateTime = new DateTime(0, 0).add(deltaDuration);
    return deltaDateTime;
  }
}