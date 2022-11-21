import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list_cubit.dart';
import 'package:pokemons/features/pokemons/data/pokemons_repository_impl.dart';
import 'package:pokemons/features/pokemons/data/retrofit/api_retrofit.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

final getIt = GetIt.instance;

abstract class DependencyRegister {
  static Future<void> register () async {
    getIt.registerSingleton(Dio());
    getIt.registerLazySingleton<ApiRetrofit>(() => ApiRetrofitImpl());
    getIt.registerSingleton<PokemonsRepository>(PokemonsRepositoryImpl(getIt()));
    getIt.registerFactory<PokemonsListCubit>(() => PokemonsListCubit(pokemonsRepository: getIt()));
  }
}