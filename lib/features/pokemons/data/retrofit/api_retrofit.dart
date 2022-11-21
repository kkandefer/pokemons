import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:pokemons/features/pokemons/data/retrofit/api.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class ApiRetrofit {
  Api get api;
}

class ApiRetrofitImpl implements ApiRetrofit {

  final log = Logger('ApiRetrofit');
  late PrettyDioLogger _dioLogger;

  @override
  Api get api {
    Dio dio = Dio();
    dio.interceptors.add(_dioLogger);
    return Api(dio, baseUrl: 'https://pokeapi.co/api/v2/');
  }

  ApiRetrofitImpl() {
    _dioLogger = PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      logPrint: log.finest
    );
  }
}
