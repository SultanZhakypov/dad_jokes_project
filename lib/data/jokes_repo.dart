import 'package:dio/dio.dart';

class JokesRepository {
  JokesRepository({required this.dio});
  final Dio dio;

  Future<String> getJoke() async {
    Response result;
    do {
      result = await dio.get('/');
    } while (!result.data['joke'].toString().contains('?'));
    return result.data['joke'];
  }
}
