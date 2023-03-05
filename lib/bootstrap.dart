import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_demo/src/constants.dart';
import 'package:movies_demo/src/data/network/movie_repository.dart';
import 'package:movies_demo/src/data/repository/movie_repository.dart';
import 'package:provider/provider.dart';

void bootstrap(FutureOr<Widget> Function() builder) {
  return runZoned(() async {
    WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    final Dio dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      queryParameters: {"api_key": AppConstants.apiKey},
    ));
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      responseHeader: true,
      request: true,
      error: true,
      requestBody: true,
      responseBody: true,
    ));

    runApp(MultiProvider(
      providers: [
        Provider<MovieRepository>(create: (context) => NetworkMovieRepository(dio: dio)),
      ],
      child: await builder(),
    ));
  });
}
