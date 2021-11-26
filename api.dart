import 'package:apiapp/API/endpoint.dart';
import 'package:apiapp/modal/data.dart';
import 'package:apiapp/modal/usermodal.dart';
import 'package:dio/dio.dart';

class DioClient {
  /// dioApiCall is instance of variable
  final Dio dioApiCall = Dio();

  /// token assign in [options] variable
  final Options options = Options(headers: {
    "Authorization":
        "Bearer bc1e0809f9bb5ce03125ea49290ec9c8acc225870ebd21e484217e79b88800db"
  });

  ///here get the list of user
  Future<User?> getUser({required String UserId}) async {
    User? user;
    try {
      Response userData = await dioApiCall.get(API.getUser + UserId);
      print('User Info: ${userData.data}');
      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
    // Response response = await dioApiCall.get(API.getUser);
    // print(response);
    // return response.data;
  }

  ///here Create the user
  Future createUser({required Data userInfo}) async {
    Data? retrievedUser;
    try {
      Response response = await dioApiCall.post(
        API.createUser,
        options: options,
        data: userInfo.toJson(),
      );
      print('User created: ${response.data}');
    } catch (e) {
      print('Error creating user: $e');
    }
    return retrievedUser;
  }

  ///here Update the user
  Future<Data?> updateUser({
    required Data userInfo,
    required String id,
  }) async {
    Data? updatedUser;

    try {
      Response response = await dioApiCall.put(
        API.getUser + id,
        options: options,
        data: userInfo.toJson(),
      );

      print('User updated: ${response.data}');

      updatedUser = Data.fromJson(response.data);
    } catch (e) {
      print('Error updating user: $e');
    }

    return updatedUser;
  }

  ///here Delete the user
  Future<void> deleteUser({required String id}) async {
    try {
      Response res = await dioApiCall.delete(
        API.getUser + id,
        options: options,
      );
      print("response Code =====> ${res.statusCode}");
      print('User deleted!');
    } catch (e) {
      print('Error deleting user: $e');
    }
  }
}
