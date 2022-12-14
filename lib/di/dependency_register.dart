import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons/common/bloc/app_navigator/app_navigator_cubit.dart';
import 'package:pokemons/features/pokemons/app/cubit/favorite_pokemons/favorite_pokemons_cubit.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemon_details/pokemon_details_cubit.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list/pokemons_list_cubit.dart';
import 'package:pokemons/features/pokemons/data/pokemons_database.dart';
import 'package:pokemons/features/pokemons/data/pokemons_repository_impl.dart';
import 'package:pokemons/features/pokemons/data/retrofit/api_retrofit.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

final getIt = GetIt.instance;

abstract class DependencyRegister {
  static Future<void> register () async {
    getIt.registerSingleton(Dio());

    getIt.registerSingletonAsync<PokemonsDatabase>(() async => await $FloorPokemonsDatabase.databaseBuilder('pokemons_database.db').build());

    getIt.registerLazySingleton<ApiRetrofit>(() => ApiRetrofitImpl());
    getIt.registerSingleton<PokemonsRepository>(PokemonsRepositoryImpl(getIt()));

    getIt.registerSingleton<AppNavigatorCubit>(AppNavigatorCubit());

    getIt.registerLazySingleton<PokemonsListCubit>(() => PokemonsListCubit(pokemonsRepository: getIt(), pokemonListItemDao: getIt<PokemonsDatabase>().pokemonListItemDao));
    getIt.registerLazySingleton<PokemonDetailsCubit>(() => PokemonDetailsCubit(pokemonsRepository: getIt()));
    getIt.registerLazySingleton<FavoritePokemonsCubit>(() => FavoritePokemonsCubit(favoritePokemonDao: getIt<PokemonsDatabase>().favoritePokemonDao));
  }
}