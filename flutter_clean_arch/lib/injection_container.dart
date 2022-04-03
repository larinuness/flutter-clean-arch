import 'package:flutter_clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:flutter_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:get_it/get_it.dart';

import 'core/util/input_converter.dart';
import 'features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

//sl = ServiceLocator
final sl = GetIt.instance;

void init() {
  // ----> Features <----
  /* Classes requiring cleanup (such as Blocs)
  shoudn't be registered as singletons */

  //Bloc
  sl.registerFactory(
    () => NumberTriviaBloc(
      concrete: sl(),
      inputConverter: sl(),
      random: sl(),
    ),
  );

  //Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  //Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // ----> Core <----
  sl.registerLazySingleton(() => InputConverter());
  // ----> External <----
}

void initFeature() {}
