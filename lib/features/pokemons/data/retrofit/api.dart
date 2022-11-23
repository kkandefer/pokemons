import 'package:dio/dio.dart';
import 'package:pokemons/features/pokemons/data/dto/response/pokemon_details_dto.dart';
import 'package:pokemons/features/pokemons/data/dto/response/pokemon_forms_dto.dart';
import 'package:pokemons/features/pokemons/data/dto/response/pokemons_list_dto.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET('pokemon')
  Future<PokemonsListDto> getPokemonsList(@Query("offset") int offset, @Query("limit") int limit );

  @GET('pokemon/{id}/')
  Future<PokemonDetailsDto> getPokemonDetails(@Path("id") int id );

  //dopiero gdy robiłem szczegóły zauwazyłem, że ten jest nadmiarowy, ale niech już zostanie
  @GET('pokemon-form/{id}/')
  Future<PokemonFormsDto> getForm(@Path("id") int id );
}
