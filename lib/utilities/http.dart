import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:dio_http_cache/dio_http_cache.dart' as dioc;
import 'package:flutter/foundation.dart';

class RequestOptions {
  // maximum cache duration
  final Duration maxAge;

  // maximum fallback to cache duration
  final Duration maxStale;

  // forces a fresh call out to update the cache. If fails will return from
  // the cache if avilable.
  final bool forceRefresh;

  RequestOptions({
    this.maxAge = Duration.zero,
    this.maxStale = Duration.zero,
    this.forceRefresh = false,
  });
}

abstract class IHttp {
  Future<Map<String, dynamic>> get(
      {@required String url, RequestOptions options});
}

class Http implements IHttp {
  final _dio;
  bool _shouldLog = true;

  Http({String baseUrl}) : _dio = dio.Dio(dio.BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(dioc.DioCacheManager(dioc.CacheConfig()).interceptor);
    if (_shouldLog)
      _dio.interceptors
          .add(dio.InterceptorsWrapper(onResponse: _logOutgoingCalls));
  }

  Future<Map<String, dynamic>> get(
      {@required String url, RequestOptions options}) async {
    dynamic data;
    try {
      var response = await _dio.get(url, options: _buildCacheOptions(options));
      data = response.data;
    } catch (e) {
      log(e.toString());
    }
    return data;
  }

  dio.Response _logOutgoingCalls(dio.Response response) {
    if (response.extra.length == 0) log(response.request.uri.toString());

    return response;
  }

  dio.Options _buildCacheOptions(RequestOptions options) {
    dio.Options cacheOptions;
    if (options != null) {
      cacheOptions = dioc.buildCacheOptions(options.maxAge,
          maxStale: options.maxAge, forceRefresh: options.forceRefresh);
    }
    return cacheOptions;
  }
}
