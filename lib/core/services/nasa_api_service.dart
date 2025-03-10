import 'package:nasa_daily_app/core/config/environment.dart';
import 'package:nasa_daily_app/core/http/dio/dio_http_service.dart';

class NasaHttpService extends DioHttpService {
  NasaHttpService({required super.baseUrl});

  @override
  Future get({required String path, data, queryParams, Function? onError}) async {
    Map<String, dynamic> params = {};
    params = queryParams ?? {};
    params['api_key'] = Environment().config.nasaApiKey;
    return super.get(path: path, data: data, queryParams: params, onError: onError);
  }
}
