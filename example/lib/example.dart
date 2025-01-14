import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:adhan_dart/adhan_dart.dart';

main() {
  tz.initializeTimeZones();
  final location = tz.getLocation('America/New_York');

  // Definitions
  DateTime date = tz.TZDateTime.from(DateTime.now(), location);
  Coordinates coordinates = Coordinates(35.78056, -78.6389);

  // Parameters
  CalculationParameters params = CalculationMethod.MuslimWorldLeague();
  params.madhab = Madhab.Hanafi;
  params.adjustments['maghrib'] = 15;

  PrayerTimes prayerTimes =
      PrayerTimes(coordinates, date, params, precision: true);

  // Prayer times
  DateTime imsaakTime = tz.TZDateTime.from(prayerTimes.imsaak!, location);
  DateTime fajrTime = tz.TZDateTime.from(prayerTimes.fajr!, location);
  DateTime sunriseTime = tz.TZDateTime.from(prayerTimes.sunrise!, location);
  DateTime dhuhrTime = tz.TZDateTime.from(prayerTimes.dhuhr!, location);
  DateTime asrTime = tz.TZDateTime.from(prayerTimes.asr!, location);
  DateTime sunsetTime = tz.TZDateTime.from(prayerTimes.sunset!, location);
  DateTime maghribTime = tz.TZDateTime.from(prayerTimes.maghrib!, location);
  DateTime ishaTime = tz.TZDateTime.from(prayerTimes.isha!, location);

  DateTime ishabeforeTime =
      tz.TZDateTime.from(prayerTimes.ishabefore!, location);
  DateTime fajrafterTime = tz.TZDateTime.from(prayerTimes.fajrafter!, location);

  // Convenience Utilities
  String current =
      prayerTimes.currentPrayer(date: DateTime.now()); // date: date
  DateTime? currentPrayerTime = prayerTimes.timeForPrayer(current);
  String next = prayerTimes.nextPrayer();
  DateTime? nextPrayerTime = prayerTimes.timeForPrayer(next);

  // Sunnah Times
  SunnahTimes sunnahTimes = SunnahTimes(prayerTimes);
  DateTime middleOfTheNight =
      tz.TZDateTime.from(sunnahTimes.middleOfTheNight, location);
  DateTime lastThirdOfTheNight =
      tz.TZDateTime.from(sunnahTimes.lastThirdOfTheNight, location);

  // Qibla Direction
  var qiblaDirection = Qibla.qibla(coordinates);

  print('***** Current Time');
  print('local time:\t$date');

  print('\n***** Prayer Times');
  print('imsaakTime:\t$imsaakTime');
  print('fajrTime:\t$fajrTime');
  print('sunriseTime:\t$sunriseTime');
  print('dhuhrTime:\t$dhuhrTime');
  print('asrTime:\t$asrTime');
  print('sunsetTime:\t$sunsetTime');
  print('maghribTime:\t$maghribTime');
  print('ishaTime:\t$ishaTime');

  print('ishabeforeTime:\t$ishabeforeTime');
  print('fajrafterTime:\t$fajrafterTime');

  print('\n***** Convenience Utilities');
  print('current:\t$current\t$currentPrayerTime');
  print('next:   \t$next\t$nextPrayerTime');

  print('\n***** Sunnah Times');
  print('middleOfTheNight:  \t$middleOfTheNight');
  print('lastThirdOfTheNight:  \t$lastThirdOfTheNight');

  print('\n***** Qibla Direction');
  print('qibla:  \t$qiblaDirection');
}
