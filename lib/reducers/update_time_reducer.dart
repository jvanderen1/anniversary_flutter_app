/// Updates DateTime with DateTime provided
DateTime updateTimeReducer(DateTime state, dynamic action) {
  if (action is DateTime)
    return updateTime(action);
  else
    return state;
}

DateTime updateTime(DateTime anniversaryTime) {
  DateTime currentDateTime = new DateTime.now();
  Duration deltaDuration = currentDateTime.difference(anniversaryTime);
  DateTime deltaDateTime = new DateTime(0, 0).add(deltaDuration);
  return deltaDateTime;
}