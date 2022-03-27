import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/util/input_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsigend', () {
    test(
        'should return an integer when the stream represents an unsigend integer',
        () async {
      //arrange
      const str = "123";
      //act
      final result = inputConverter.stringToUnsigendInteger(str);
      //assert
      expect(result, const Right(123));
    });

    test('should return a failure when the string is not an integer', () async {
      //arrange
      const str = "abc";

      //act
      final result = inputConverter.stringToUnsigendInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a failure when the string is a negative integer',
        () async {
      //arrange
      const str = "-123";

      //act
      final result = inputConverter.stringToUnsigendInteger(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
