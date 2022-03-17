import 'dart:convert';

import 'package:flutter_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';


void main() {
  const tNumberTrivialModel = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a NumberTrivia entity',
    () async {
      expect(tNumberTrivialModel, isA<NumberTrivia>());
    },
  );

  group(
    'fromJson',
    () {
      test(
        'should return a valid model when the JSON number is an integer',
        () async {
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);

          expect(result, tNumberTrivialModel);
        },
      );

      test(
        'should return a valid model when the JSON number is regarded as a double',
        () async {
          final Map<String, dynamic> jsonMap =
              json.decode(fixture('trivia_double.json'));

          final result = NumberTriviaModel.fromJson(jsonMap);

          expect(result, tNumberTrivialModel);
        },
      );
    },
  );

  group(
    'toJson',
    () {
      test(
        'should return a JSON map containing the proper data',
        () async {
          final result = tNumberTrivialModel.toJson();

          expect(result, isA<Map<String, dynamic>>());
        },
      );
    },
  );
}
