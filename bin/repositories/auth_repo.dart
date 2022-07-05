import 'dart:typed_data';

import 'package:supabase/supabase.dart';

abstract class AuthRepo {
  AuthRepo();

  Future<GotrueSessionResponse?> signin(String email, String password);

  Future<GotrueSessionResponse?> signinWithPhone(String phone);

  Future<GotrueSessionResponse?> signup(String email, String password);

  Future<bool?> signupWithPhone(String phone, String password);

  Future<GotrueSessionResponse?> verifiyOTP(String phone, String otp);

  Future<StorageResponse?> uploadImage(
      List<Map<String, dynamic>> listParam, Uint8List image, String id);
}
