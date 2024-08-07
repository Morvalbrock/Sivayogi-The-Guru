import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Sivayogi_The_Guru/data/api_service.dart';
import 'package:Sivayogi_The_Guru/model/user_model.dart';

class UserNotifier extends StateNotifier<UserModel?> {
  UserNotifier() : super(null) {
    loadUserInfo();
  }

  final ApiService _apiService = ApiService();

  Future<void> loadUserInfo() async {
    try {
      final user = await _apiService.fetchUserInfo();
      state = user;
    } catch (e) {
      print('Failed to load user info: $e');
    }
  }

  Future<void> uploadUserImage(String imagePath) async {
    try {
      await _apiService.uploadImageToApi(imagePath);
      await loadUserInfo(); // Refresh user info after upload
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }
}
