// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemons_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorPokemonsDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PokemonsDatabaseBuilder databaseBuilder(String name) =>
      _$PokemonsDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$PokemonsDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$PokemonsDatabaseBuilder(null);
}

class _$PokemonsDatabaseBuilder {
  _$PokemonsDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$PokemonsDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$PokemonsDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<PokemonsDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PokemonsDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PokemonsDatabase extends PokemonsDatabase {
  _$PokemonsDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonListItemDao? _pokemonListItemDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PokemonListItem` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `imageUrl` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonListItemDao get pokemonListItemDao {
    return _pokemonListItemDaoInstance ??=
        _$PokemonListItemDao(database, changeListener);
  }
}

class _$PokemonListItemDao extends PokemonListItemDao {
  _$PokemonListItemDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pokemonListItemInsertionAdapter = InsertionAdapter(
            database,
            'PokemonListItem',
            (PokemonListItem item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'imageUrl': item.imageUrl
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PokemonListItem> _pokemonListItemInsertionAdapter;

  @override
  Future<List<PokemonListItem>> getPokemonsPart(
    int offset,
    int limit,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PokemonListItem ORDER BY name ASC LIMIT ?2 OFFSET ?1',
        mapper: (Map<String, Object?> row) => PokemonListItem(
            id: row['id'] as int,
            name: row['name'] as String,
            imageUrl: row['imageUrl'] as String?),
        arguments: [offset, limit]);
  }

  @override
  Future<List<PokemonListItem>> findPokemonsPart(
    String phrase,
    int offset,
    int limit,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PokemonListItem WHERE name LIKE ?1 ORDER BY name ASC LIMIT ?3 OFFSET ?2',
        mapper: (Map<String, Object?> row) => PokemonListItem(id: row['id'] as int, name: row['name'] as String, imageUrl: row['imageUrl'] as String?),
        arguments: [phrase, offset, limit]);
  }

  @override
  Future<PokemonListItem?> findPokemonById(int id) async {
    return _queryAdapter.query('SELECT * FROM PokemonListItem WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PokemonListItem(
            id: row['id'] as int,
            name: row['name'] as String,
            imageUrl: row['imageUrl'] as String?),
        arguments: [id]);
  }

  @override
  Future<PokemonListItem?> findPokemonByName(String name) async {
    return _queryAdapter.query('SELECT * FROM PokemonListItem WHERE name = ?1',
        mapper: (Map<String, Object?> row) => PokemonListItem(
            id: row['id'] as int,
            name: row['name'] as String,
            imageUrl: row['imageUrl'] as String?),
        arguments: [name]);
  }

  @override
  Future<void> deleteAllPokemons() async {
    await _queryAdapter.queryNoReturn('DELETE FROM PokemonListItem');
  }

  @override
  Future<void> insertPokemons(List<PokemonListItem> pokemons) async {
    await _pokemonListItemInsertionAdapter.insertList(
        pokemons, OnConflictStrategy.abort);
  }
}
