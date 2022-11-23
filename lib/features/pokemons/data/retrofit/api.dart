import 'package:dio/dio.dart';
import 'package:pokemons/features/pokemons/data/dto/response/pokemons_form_dto.dart';
import 'package:pokemons/features/pokemons/data/dto/response/pokemons_list_dto.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET('pokemon')
  Future<PokemonsListDto> getPokemonsList(@Query("offset") int offset, @Query("limit") int limit );

  @GET('pokemon-form/{id}/')
  Future<PokemonsFormDto> getForm(@Path("id") int id );
}
