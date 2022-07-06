import 'dart:io';
import 'dart:typed_data';

import 'package:supabase/supabase.dart';
import '../repositories/auth_repo.dart';
import '../utils/app_constanta.dart';

class AuthService extends AuthRepo {
  @override
  Future<GotrueSessionResponse?> signin(String email, String password) async {
    try {
      final response = await db.auth.signIn(email: email, password: password);
      return response;
    } catch (e) {
      print("ERROR : ${e.toString()}");
      return null;
    }
  }

  @override
  Future<GotrueSessionResponse?> signinWithPhone(String phone) async {
    try {
      final response = await db.auth.signIn(phone: phone);
      return response;
    } catch (e) {
      print("ERROR : ${e.toString()}");
      return null;
    }
  }

  @override
  Future<GotrueSessionResponse?> signup(String email, String password) async {
    try {
      return await db.auth.signUp(email, password);
    } catch (e) {
      print("ERROR : ${e.toString()}");
      return null;
    }
  }

  @override
  Future<bool?> signupWithPhone(String phone, String password) async {
    try {
      final response = await db.auth.signUpWithPhone(phone, password);
      print('RESPONSE CODE : ${response.statusCode}');
      print('RESPONSE DATA : ${response.data}');
      print('RESPONSE URL : ${response.url}');
      print('RESPONSE PROVIDER : ${response.provider}');
      print('RESPONSE RAW DATA : ${response.rawData}');
      print('RESPONSE ERROR : ${response.error!.message}');
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("ERROR : ${e.toString()}");
      return null;
    }
  }

  @override
  Future<GotrueSessionResponse?> verifiyOTP(String phone, String otp) async {
    try {
      return await db.auth.verifyOTP(phone, otp);
    } catch (e) {
      print("ERROR : ${e.toString()}");
      return null;
    }
  }

  @override
  Future<StorageResponse?> uploadImage(
      List<Map<String, dynamic>> listParam, Uint8List image, String id) async {
    try {
      Directory directory = Directory.current;
      final file =
          await File('${directory.path}/assets/images/${listParam[0]['image']}')
              .create();
      file.writeAsBytesSync(image);
      // final pat = lookupMimeType(file.path);
      final response = await db.storage.from('storages').upload(
          '/images/$id.png', file,
          fileOptions: FileOptions(cacheControl: '3600', upsert: false));
      if (response.data != null) {
        await File('${directory.path}/assets/images/${listParam[0]['image']}')
            .delete();
      }
    } catch (e) {
      print("ERROR : ${e.toString()}");
      return null;
    }
    return null;
  }
}
