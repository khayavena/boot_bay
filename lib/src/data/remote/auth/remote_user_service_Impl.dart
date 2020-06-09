import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/model/User.dart';

class RemoteUserServiceImpl<T> implements RemoteUserService {
  Dio _dio;

  RemoteUserServiceImpl({
    @required Dio dio,
  }) : _dio = dio;

  @override
  Future<User> signUp(User user) async {
    Response response =
        await _dio.post('/api/user/register', data: user.toJson());
    return User.fromJson(response.data);
  }

  @override
  Future<User> update(User user) async {
    Response response =
        await _dio.post('/api/user/update', data: user.toJson());
    return User.fromJson(response.data);
  }

  @override
  Future<List<User>> getAll() async {
    Response response = await _dio.get('/api/user/all');
    return List<User>.from(response.data.map((json) => User.fromJson(json)));
  }

  @override
  Future<User> signIn(AuthRequest authRequest) async {
    Response response =
        await _dio.post('/api/user/signin', data: authRequest.toJson());
    return User.fromJson(response.data);
  }
}
