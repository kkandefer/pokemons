import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemons/common/pk_extensions.dart';
import 'package:pokemons/features/pokemons/data/dao/pokemon_list_item_dao.dart';
import 'package:pokemons/features/pokemons/data/pokemons_database.dart';
import 'package:pokemons/features/pokemons/domain/entities/pokemon_list_item.dart';
import 'package:pokemons/features/pokemons/domain/pokemons_repository.dart';
import 'package:logging/logging.dart';

part 'pokemons_list_state.dart';

class PokemonsListCubit extends Cubit<PokemonsListState> {

  final int _limit = 40;
  final log = Logger('PokemonsListCubit');
  final PokemonsRepository pokemonsRepository;
  final PokemonListItemDao pokemonListItemDao;
  PokemonsListCubit({ required this.pokemonsRepository, required this.pokemonListItemDao }) : super(PokemonsListState.initial());

  void initList() async {
    emit(state.copyWith(
      searchStatus: PokemonsListStatus.searching,
    ));

    try{
      List<PokemonListItem> remoteResults = await pokemonsRepository.getRemotePokemons(limit: 100000);

      late List<PokemonListItem> sortedResults;
      try{
        await pokemonListItemDao.deleteAllPokemons();
        await pokemonListItemDao.insertPokemons(remoteResults);
        sortedResults = await pokemonListItemDao.getPokemonsPart(0, _limit);
        // sortedResults = await _getMixedItems(0, _limit);
      }
      catch(e, s) {
        log.severe('Unable to save list in database', e, s);
        //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
        throw e;
      }

      emit(state.copyWith(
        searchStatus: PokemonsListStatus.normal,
        results: sortedResults,
        hasRatherMax: sortedResults.isEmpty,
      ));

      List<List<PokemonListItem>> miniTabs = sortedResults.chunked(5).toList();
      Future.forEach(miniTabs, (List<PokemonListItem> miniTab) async {
        await _fillImages(miniTab.where((i) => i.imageUrl == null).toList());
      });
    }
    catch(e, s) {
      emit(state.copyWith(
        searchStatus: PokemonsListStatus.failure,
      ));
      log.severe('Unable to get remote list from API', e, s);
      //TODO logowanie do crashlytics, ale w tej wersji nie podłaczam bo nie ma konta
    }
  }

  void append({ int? limit }) async {
    emit(state.copyWith(
      appending: true,
    ));

    try{
      List<PokemonListItem> sortedResults = await pokemonListItemDao.getPokemonsPart(state.results.length, limit ?? _limit);
      // List<PokemonListItem> sortedResults = await _getMixedItems(state.results.length, limit ?? _limit);
      emit(state.copyWith(
        results: (state.results + sortedResults).unique((i) => i.id),
        appending: false,
        hasRatherMax: sortedResults.isEmpty,
      ));

      List<List<PokemonListItem>> miniTabs = sortedResults.chunked(5).toList();
      Future.forEach(miniTabs, (List<PokemonListItem> miniTab) async {
        await _fillImages(miniTab.where((i) => i.imageUrl == null).toList());
      });
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

  // Nie widze w tym API lepszego sposkobu na pobranie zdjęc
  // Ten algorytm starałem się zoptymalizować, ale i tak to dociągnaia zdjęc jest nieefektywne,
  // stasznie spowalnia działanie listy i strasznie spamuje API
  // W normalnych warunkach należałoby się skontaktować z działem/firmą odpowiedzialnym za backend
  // aby wystawili zdjęcie na podstawowej liście,
  // lub jesli to jest nie mozliwe to przynajmniej jakiś endpoint do pobierania zdjeć partiami np podając 40 identyfikatorów na raz
  // a gdyby to też było nie możliwe to należałoby omówić z klientem ewentualną zmiane projektu aby na liście nie było zdjęć
  // ale w tym przypadku nie chce podważać założen zadania, bo być może to celowa komplikacja :-)
  Future<List<PokemonListItem>> _getMixedItems(int offset, int limit) async {
    List<PokemonListItem> sortedResults = await pokemonListItemDao.getPokemonsPart(offset, limit);

    Map<int, String?> mapOfImages = {};
    await Future.forEach(sortedResults, (PokemonListItem item) async {
      if(item.imageUrl == null){
        String? image = await pokemonsRepository.getRemotePokemonImage(id: item.id);
        mapOfImages.addAll({item.id: image});
      }
    });
    return sortedResults.map<PokemonListItem>((e) => PokemonListItem(id: e.id, name: e.name, imageUrl: mapOfImages[e.id])).toList();
  }

  // Zmieniony sposób doczytywania obrazków.
  // Niby jest lepiej, bo nie blokuje wczytywania listy,
  // ale i tak to nie jest efektywny sposób.
  // W realnej aplikacji konieczna byłaby modyfikacja API lub zmiana założeń.
  Future<void> _fillImages(List<PokemonListItem> itemsToFill) async {
    Map<int, String?> mapOfImages = {};
    await Future.forEach(itemsToFill, (PokemonListItem item) async {
      if(item.imageUrl == null){
        String? image = await pokemonsRepository.getRemotePokemonImage(id: item.id);
        mapOfImages.addAll({item.id: image});
      }
    });
    itemsToFill = itemsToFill.map<PokemonListItem>((e) => PokemonListItem(id: e.id, name: e.name, imageUrl: mapOfImages[e.id])).toList();
    pokemonListItemDao.updatePokemons(itemsToFill);
    emit(state.copyWith(
      results: state.results.map((e) => itemsToFill.firstWhere((f) => f.id == e.id, orElse: () => e)).toList()
    ));
  }
}
