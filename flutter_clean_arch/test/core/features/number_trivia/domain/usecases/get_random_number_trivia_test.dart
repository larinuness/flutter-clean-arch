import 'package:dartz/dartz.dart';
import 'package:flutter_clean_arch/core/usecases/usecases.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late GetRandomNumberTrivia usecase;
  late MockNumberTriviaRepository repository;

  setUp(() {
    repository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(repository);
  });

  const numberTrivia = NumberTrivia(text: 'Teste', number: 2);

  test('should get trivia from the repository', () async {
    //arrange
    when(() => repository.getRandomNumberTrivia())
        .thenAnswer((_) async => const Right(numberTrivia));
    //act
    final result = await usecase(NoParam());
    //assert
    expect(result, const Right(numberTrivia));
    verify(() => repository.getRandomNumberTrivia());
    verifyNoMoreInteractions(repository);
  });
}
