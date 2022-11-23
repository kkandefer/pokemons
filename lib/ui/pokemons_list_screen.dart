import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemons/common/route_arguments/pokemon_details_arg.dart';
import 'package:pokemons/features/pokemons/app/cubit/pokemons_list/pokemons_list_cubit.dart';
import 'package:pokemons/ui/pokemon_details_screen.dart';
import 'package:pokemons/ui/widgets/pk_error_widget.dart';
import 'package:pokemons/ui/widgets/search_form.dart';
import 'package:transparent_image/transparent_image.dart';

class PokemonsListScreen extends StatefulWidget {

  static const routeName = '/pokemonsList';

  PokemonsListScreen._();
  static withCubit() {
    return BlocProvider<PokemonsListCubit>.value(
      value: GetIt.instance<PokemonsListCubit>(),
      child: PokemonsListScreen._(),
    );
  }

  @override
  _PokemonsListScreenState createState() {
    return _PokemonsListScreenState();
  }
}

class _PokemonsListScreenState extends State<PokemonsListScreen> {

  late PokemonsListCubit _pokemonsListCubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    GetIt.instance<PokemonsListCubit>()..initList();
    _scrollController = ScrollController()..addListener(_handleScroll);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _pokemonsListCubit = BlocProvider.of<PokemonsListCubit>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onPanDown: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.bottomAppBarColor,
          title: SearchForm(),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // SliverToBoxAdapter(
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            //     child: Text('Lista pokemonów'),
            //   ),
            // ),
            BlocBuilder<PokemonsListCubit, PokemonsListState>(
              //buildWhen celowo odpuszcam, tu i tak wszystko dzieje się w jednym miejscu
              builder: (context, pokemonsListState){
                switch(pokemonsListState.searchStatus){
                  case PokemonsListStatus.searching :
                    return SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
                  case PokemonsListStatus.failure :
                    return SliverToBoxAdapter(child: PkErrorWidget(message: "Wystapił błąd"));
                  case PokemonsListStatus.normal :
                    return SliverList(delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if(pokemonsListState.appending && index == pokemonsListState.results.length){
                          return Center(child: CircularProgressIndicator());
                        }
                        else{
                          return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300, width: 0.5)
                              )
                            ),
                            child: ListTile(
                              title: Text(pokemonsListState.results[index].name),
                              leading: FadeInImage.memoryNetwork(
                                image: pokemonsListState.results[index].imageUrl.toString(),
                                placeholder: kTransparentImage,
                                imageErrorBuilder: (context, error, stackTrace) => Icon(Icons.image),
                              ),
                              // leading: (pokemonsListState.results[index].imageUrl == null)
                              //     ? null
                              //     : Image.network(pokemonsListState.results[index].imageUrl!),
                              onTap: () => Navigator.of(context).pushNamed(PokemonDetailsScreen.routeName, arguments: PokemonDetailsArg(id: pokemonsListState.results[index].id)),
                            ),
                          );
                        }
                      },
                      childCount: pokemonsListState.appending? pokemonsListState.results.length + 1 : pokemonsListState.results.length,
                    ));
                }
              },
            )
          ],
        ),
      ),
    );
  }

  _handleScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if(maxScroll - currentScroll <= 600 && !_pokemonsListCubit.state.appending && !_pokemonsListCubit.state.hasRatherMax) {
      _pokemonsListCubit.append();
    }
  }
}