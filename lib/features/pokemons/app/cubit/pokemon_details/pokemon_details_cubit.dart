import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_details.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';

part 'pokemon_details_state.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetailsState> {

  final log = Logger('PokemonDetailsCubit');
  final PokemonsRepository pokemonsRepository;

  PokemonDetailsCubit({ required this.pokemonsRepository }) : super(PokemonDetailsState.initial());

  void initPokemonById(int id) async {

    emit(PokemonDetailsState.initial());

    try{
      PokemonDetails pokemonDetails = await pokemonsRepository.getRemotePokemonDetails(id: id);

      emit(state.copyWith(
        status: PokemonDetailsStatus.normal,
        details: pokemonDetails,
      ));

    }
    catch(e, s) {
      emit(state.copyWith(
        status: PokemonDetailsStatus.failure,
      ));
      log.severe('Unable to get details from API', e, s);
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
    }
  }
}
