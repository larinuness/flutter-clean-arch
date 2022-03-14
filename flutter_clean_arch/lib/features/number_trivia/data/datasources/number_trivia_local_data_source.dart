import '../models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  
  /* Calls the http://numbersapi.com/{number} endpoint.
  Throws a ServerException for all error codes. */
  Future<NumberTriviaModel> getLastNumberTrivia();

  /* Calss the http://numbersapi.com/random endpoint.
  Throws a ServerException for all error codes. */
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaToCache);
}
