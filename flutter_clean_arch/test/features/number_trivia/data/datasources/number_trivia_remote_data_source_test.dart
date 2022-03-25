import 'dart:convert';
import 'package:flutter_clean_arch/core/error/exceptions.dart';
import 'package:flutter_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_clean_arch/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockHttp extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  late MockHttp mockHttp;

  setUp(() {
    mockHttp = MockHttp();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttp);
  });

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test(
        'Should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      when(() => mockHttp.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (invocation) async => http.Response(fixture('trivia.json'), 200));
      dataSourceImpl.getConcreteNumberTrivia(tNumber);
      verifyNever(
          () => mockHttp.get(Uri.parse('http://numbersapi.com/$tNumber')));
    });

    test('Should return NumberTrivia when the response code is 200 (sucess)',
        () async {
      when(() => mockHttp.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (invocation) async => http.Response(fixture('trivia.json'), 200));
      final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      when(() => mockHttp.get(Uri.parse('http://numbersapi.com/$tNumber'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer(
              (invocation) async => http.Response(fixture('trivia.json'), 404));
      final call = dataSourceImpl.getConcreteNumberTrivia;
      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test(
        'Should perform a GET request on a URL with number being the endpoint and with application/json header',
        () async {
      when(() => mockHttp.get(
            Uri.parse('http://numbersapi.com/random'),
          )).thenAnswer((invocation) async => http.Response('', 200));
      dataSourceImpl.getRandomNumberTrivia();
      verifyNever(() => mockHttp.get(
          (Uri.parse('http://numbersapi.com/random')),
          headers: {'Content-Type': 'application/json'}));
    });

    test('Should return NumberTrivia when the response code is 200 (sucess)',
        () async {
      when(() => mockHttp.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((invocation) async => http.Response('42', 200));
      final result = await dataSourceImpl.getRandomNumberTrivia();
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'Should throw a ServerException when the response code is 404 or other',
        () async {
      when(() => mockHttp.get(Uri.parse('http://numbersapi.com/random'),
              headers: {'Content-Type': 'application/json'}))
          .thenAnswer((invocation) async => http.Response('', 404));
      final call = dataSourceImpl.getRandomNumberTrivia;
      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
