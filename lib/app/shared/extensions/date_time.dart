extension BrazilianTimeZone on DateTime {
  DateTime toBrazilianTimeZone() {
    final currentTimeZone = timeZoneOffset.inHours;
    const brazilianTimeZone = 3;
    final adaptedTimeZone = currentTimeZone + brazilianTimeZone;
    final adaptedToBrazilianTimeZone = subtract(
      Duration(hours: adaptedTimeZone),
    );
    return adaptedToBrazilianTimeZone;
  }
}
