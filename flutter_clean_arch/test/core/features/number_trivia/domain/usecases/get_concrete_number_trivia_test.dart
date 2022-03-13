import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(repository);
  });

  // ignore: prefer_const_declarations
  final number = 1;
  final numberTrivia = NumberTrivia(text: 'Teste', number: number);

  test('should get trivia for the number from the repository', () async {
    //arrange
    when(repository.getConcreteNumberTrivia(number))
        .thenAnswer((_) async => Right(numberTrivia));
    //act
    final result = await usecase(Params(number: number));
    //assert
    expect(result, Right(numberTrivia));
    verify(repository.getConcreteNumberTrivia(number));
    verifyNoMoreInteractions(repository);
  });
}
