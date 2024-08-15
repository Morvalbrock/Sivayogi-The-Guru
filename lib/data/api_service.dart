import 'dart:convert';
import 'package:Sivayogi_The_Guru/home.dart';
import 'package:Sivayogi_The_Guru/loginscreen.dart';
import 'package:Sivayogi_The_Guru/model/book_model.dart';
import 'package:Sivayogi_The_Guru/model/cources_model.dart';
import 'package:Sivayogi_The_Guru/model/login_model.dart';
import 'package:Sivayogi_The_Guru/model/register_model.dart';
import 'package:Sivayogi_The_Guru/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  //register data

  // String _authToken = '';
  final String baseUrl = 'https://vgroups-api.pharma-sources.com/api/';
  final String registerEndpoint = 'user/';
  final String loginEndpoint = 'token/';
  final String userEndpoint = 'user/';

  bool isTokenExpired(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return true; // Invalid token format, consider it expired
    }

    final payload = json
        .decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));

    final expiry = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);

    return DateTime.now().isAfter(expiry);
  }

  Future<String> getAuthToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  Future<String> getValidAuthToken() async {
    String authToken = await getAuthToken();

    if (isTokenExpired(authToken)) {
      await fetchAccess();
      authToken = await getAuthToken();
    }

    return authToken;
  }

  Future<void> register(
      RegisterModel registerModel, BuildContext context) async {
    final uri = Uri.parse('$baseUrl$registerEndpoint');
    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(registerModel.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
            msg: 'Registered successfully....',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        print('A network error occurred');
        print(response.statusCode);
        Fluttertoast.showToast(
            msg: 'Enter a valid password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (error) {
      print('Error: $error');
      Fluttertoast.showToast(
          msg: 'An error occurred',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  //login data

  Future<void> login(LoginModel loginModel, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final uri = Uri.parse('$baseUrl$loginEndpoint');

    try {
      http.Response response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(loginModel.toJson()),
      );

      if (response.statusCode == 200) {
        final token = json.decode(response.body);
        prefs.setString('token', token['access']);
        prefs.setString('refresh_token', token['refresh']);

        Fluttertoast.showToast(
          msg: 'Login succssfully....',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Homepage()));
      } else {
        Fluttertoast.showToast(
            msg: 'enter valid username password',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        // Navigator.of(context).pushNamed("/");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchAccess() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = await getAuthToken();
    final uri =
        Uri.parse('https://vgroups-api.pharma-sources.com/api/token/refresh/');

    try {
      http.Response response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(authToken),
      );

      if (response.statusCode == 200) {
        final token = json.decode(response.body);
        prefs.setString('token', token['access']);
        // prefs.setString('refresh_token', token['refresh']);
      } else {
        // Navigator.of(context).pushNamed("/");
        print('error');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //user data

  Future<UserModel> fetchUserInfo() async {
    final authToken = await getValidAuthToken();

    final response = await http.get(
      Uri.parse('$baseUrl$userEndpoint'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return UserModel.fromJson(data);
    } else if (response.statusCode == 403) {
      // Handle unauthorized (possibly invalid token)
      await logoutUser();
      throw Exception('Unauthorized access. Please log in again.');
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<void> uploadImageToApi(String imagePath) async {
    final authToken = await getValidAuthToken();
    try {
      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse('https://vgroups-api.pharma-sources.com/api/user/'),
      );
      request.headers['Authorization'] = 'Bearer $authToken';
      request.files.add(
        await http.MultipartFile.fromPath('profile_pic', imagePath),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        await fetchUserInfo();
      } else if (response.statusCode == 403) {
        // Handle unauthorized (possibly invalid token)
        await logoutUser();
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  Future<void> updateUserData(Map<String, dynamic> updatedData) async {
    final authToken = await getValidAuthToken();
    final uri = Uri.parse('https://vgroups-api.pharma-sources.com/api/user/');
    try {
      final response = await http.patch(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        },
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: 'Update successful',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        await fetchUserInfo();
      } else if (response.statusCode == 403) {
        // Handle unauthorized (possibly invalid token)
        await logoutUser();
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to update',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        print('Failed to update data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating data: $error');
    }
  }

  Future<List<dynamic>> fetchaboutInfo() async {
    final authToken = await getValidAuthToken();

    try {
      final response = await http.get(
        Uri.parse('https://vgroups-api.pharma-sources.com/api/about/'),
        headers: {
          'Authorization': 'Bearer $authToken',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = utf8.decode(response.bodyBytes);
        return json.decode(responseBody) as List<dynamic>;
      } else if (response.statusCode == 403) {
        // Handle unauthorized (possibly invalid token)
        await logoutUser();
        throw Exception('Unauthorized access. Please log in again.');
      } else {
        // Handle errors by throwing an exception
        throw Exception('Failed to load about information');
      }
    } catch (e) {
      // Handle network errors by throwing an exception
      throw Exception('Network error: $e');
    }
  }

  //home page silder

  Future<List<String>> fetchImages() async {
    final authToken = await getValidAuthToken();
    final response = await http.get(
      Uri.parse('https://vgroups-api.pharma-sources.com/api/sliders/'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item['image'] as String).toList();
    } else if (response.statusCode == 403) {
      // Handle unauthorized (possibly invalid token)
      await logoutUser();
      throw Exception('Unauthorized access. Please log in again.');
    } else {
      throw Exception('Failed to load images: ${response.statusCode}');
    }
  }

//course data

  Future<List<Course>> fetchCourses() async {
    final authToken = await getValidAuthToken();
    final response = await http.get(
      Uri.parse('https://vgroups-api.pharma-sources.com/api/courses/'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> data = json.decode(responseBody);
      return data.map((json) => Course.fromJson(json)).toList();
    } else if (response.statusCode == 403) {
      // Handle unauthorized (possibly invalid token)
      await logoutUser();
      throw Exception('Unauthorized access. Please log in again.');
    } else {
      throw Exception('Failed to load courses: ${response.statusCode}');
    }
  }

  //books data

  Future<List<BookModel>> fetchBooks() async {
    final authToken = await getValidAuthToken();
    final response = await http.get(
      Uri.parse('https://vgroups-api.pharma-sources.com/api/books/'),
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      List<dynamic> data = json.decode(responseBody);
      return data.map((json) => BookModel.fromJson(json)).toList();
    } else if (response.statusCode == 403) {
      // Handle unauthorized (possibly invalid token)
      await logoutUser();
      throw Exception('Unauthorized access. Please log in again.');
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }
}

//logout

Future<void> logoutUser() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('refresh_token');

  // Optionally show a logout message
  Fluttertoast.showToast(
    msg: 'Session expired. Please log in again.',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );

  // Navigate to the login screen and remove all other routes
  Navigator.of(context as BuildContext).pushAndRemoveUntil(
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (Route<dynamic> route) => false,
  );
}
