import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /*Gets the cached NumberTriviaModel which was gotten the last time
   the user had an internet connection.
  Throws CacheExecption if no cached data is present.*/

  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
