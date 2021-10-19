import 'package:bootbay/src/model/AuthRequest.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bootbay/src/data/remote/auth/remote_user_service.dart';
import 'package:bootbay/src/model/sys_user.dart';

class RemoteUserServiceImpl<T> implements RemoteUserService {
  Dio _dio;

  RemoteUserServiceImpl({
    @required Dio dio,
  }) : _dio = dio;

  @override
  Future<SysUser> signUp(SysUser user) async {
    Response response =
        await _dio.post('/api/user/register', data: user.toJson());
    return SysUser.fromJson(response.data);
  }

  @override
  Future<SysUser> update(SysUser user) async {
    Response response =
        await _dio.post('/api/user/update', data: user.toJson());
    return SysUser.fromJson(response.data);
  }

  @override
  Future<List<SysUser>> getAll() async {
    Response response = await _dio.get('/api/user/all');
    return List<SysUser>.from(response.data.map((json) => SysUser.fromJson(json)));
  }

  @override
  Future<SysUser> signIn(AuthRequest authRequest) async {
    Response response =
        await _dio.post('/api/user/signin', data: authRequest.toJson());
    return SysUser.fromJson(response.data);
  }
}
