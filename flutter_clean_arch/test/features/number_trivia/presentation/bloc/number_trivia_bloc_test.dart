import 'package:flutter_clean_arch/core/util/input_converter.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockGetConcreteNumberTrivia extends Mock
    implements GetConcreteNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  late NumberTriviaBloc bloc;
  late MockGetConcreteNumberTrivia mockGetConcreteNumberTrivia;
  late MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  late MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcreteNumberTrivia = MockGetConcreteNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();
    bloc = NumberTriviaBloc(
      concrete: mockGetConcreteNumberTrivia,
      inputConverter: mockInputConverter,
      random: mockGetRandomNumberTrivia,
    );
  });

  test('initial state should be empty', () {
    expect(bloc.state, Empty());
  });

  group('GetTriviaForConcreteNumber', () {
    const tNumberString = '1';
    const tNumberParsed = 1;
    const tNumberTrivia = NumberTrivia(text: 'test trivia', number: 1);

    test(
        'should call the input converter to validate and convert the string to an unsigned integer',
        () async {
      when(() => mockInputConverter.stringToUnsigendInteger(any()))
          .thenReturn(const Right(tNumberParsed));
      when(() =>
              mockGetConcreteNumberTrivia(const Params(number: tNumberParsed)))
          .thenAnswer((invocation) async => const Right(tNumberTrivia));

      bloc.add(GetTriviaForConcreteNumber(numberString: tNumberString));
      await untilCalled(
          () => mockInputConverter.stringToUnsigendInteger(any()));

      verify(() => mockInputConverter.stringToUnsigendInteger(tNumberString));
    });
  });
}
