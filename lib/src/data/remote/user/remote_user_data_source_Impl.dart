import 'package:bootbay/src/data/remote/user/remote_user_data_source.dart';
import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:bootbay/src/model/user_profile.dart';
import 'package:dio/dio.dart';

class RemoteUserDataSourceImpl implements RemoteUserDataSource {
  Dio _dio;

  RemoteUserDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<UserProfile> signUp(UserProfile user) async {
    Response response =
        await _dio.post('/api/user/register', data: user.toJson());
    return UserProfile.fromJson(response.data);
  }

  @override
  Future<UserProfile> update(UserProfile user) async {
    Response response =
        await _dio.post('/api/user/update', data: user.toJson());
    return UserProfile.fromJson(response.data);
  }

  @override
  Future<List<UserProfile>> getAll() async {
    Response response = await _dio.get('/api/user/all');
    return List<UserProfile>.from(
        response.data.map((json) => UserProfile.fromJson(json)));
  }

  @override
  Future<UserProfile> signIn(AuthRequest authRequest) async {
    Response response =
        await _dio.post('/api/user/signin', data: authRequest.toJson());
    return UserProfile.fromJson(response.data);
  }
}
