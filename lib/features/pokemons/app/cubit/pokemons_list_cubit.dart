import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemons_list_item.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';
import 'package:logging/logging.dart';

part 'pokemons_list_state.dart';

class PokemonsListCubit extends Cubit<PokemonsListState> {

  final int _limit = 100;
  final log = Logger('PokemonsListCubit');
  final PokemonsRepository pokemonsRepository;
  PokemonsListCubit({ required this.pokemonsRepository }) : super(PokemonsListState.initial());

  void initList() async {
    emit(state.copyWith(
      searchStatus: PokemonsListStatus.searching,
    ));

    try{
      List<PokemonsListItem> results = await pokemonsRepository.getRemotePokemons(limit: _limit);
      emit(state.copyWith(
        searchStatus: PokemonsListStatus.normal,
        results: results,
        hasRatherMax: results.isEmpty,
      ));
    }
    catch(e, s) {
      emit(state.copyWith(
        searchStatus: PokemonsListStatus.failure,
      ));
      log.severe('Unable to get remote list from API', e, s);
      print(e);
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
    }
  }

  void append({ int? limit}) async {
    emit(state.copyWith(
      appending: true,
    ));

    try{
      List<PokemonsListItem> results = await pokemonsRepository.getRemotePokemons(offset: state.results.length, limit: limit ?? _limit);
      emit(state.copyWith(
        results: results,
        appending: false,
        hasRatherMax: results.isEmpty,
      ));
    }
    catch(e, s) {
      emit(state.copyWith(
        appending: false,
        errorMessage: 'Wystąpił błąd'
      ));
      log.severe('Unable to append remote list from API', e, s);
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
    }
  }
}
