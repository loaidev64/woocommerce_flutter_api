import 'package:faker/faker.dart';

abstract class FakeHelper {
  static final _faker = Faker();

  static int integer() => _faker.randomGenerator.integer(100);

  static String word() => _faker.lorem.word();

  static String sentence() => _faker.lorem.sentence();

  static String url() => _faker.internet.httpsUrl();

  static String image() => _faker.image.image();

  static DateTime datetime() =>
      _faker.date.dateTime(minYear: 2024, maxYear: 2050);

  static bool boolean() => _faker.randomGenerator.boolean();

  static double decimal() => _faker.randomGenerator.decimal();

  static List<T> list<T>(T Function() model) =>
      List.generate(_faker.randomGenerator.integer(10), (index) => model());

  static List<int> listOfIntegers() => _faker.randomGenerator.numbers(100, 20);
}
