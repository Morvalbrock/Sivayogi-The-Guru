import 'package:Sivayogi_The_Guru/classes/language_constants.dart';
import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:Sivayogi_The_Guru/data/api_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Sivayogi_The_Guru/model/user_model.dart';

final apiProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final userDataProvider = FutureProvider<UserModel>((ref) async {
  return ref.read(apiProvider).fetchUserInfo();
});

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  String authToken = '';
  UserModel? user;
  bool isLoading = false;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _takePicture() async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      // await uploadImageToApi(pickedImage.path);
      await ref.read(apiProvider).uploadImageToApi(pickedImage.path);
    }
  }

  void bottomsheet(controller, hintName, void Function() onSave) {
    showModalBottomSheet(
      context: context,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hintName,
                style: const TextStyle(color: Colors.black, fontSize: 20.0)),
            const SizedBox(height: 20.0),
            TextField(
              maxLength: 25,
              controller: controller,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(color: HexColor('025CAF')),
                  ),
                ),
                TextButton(
                  onPressed: onSave,
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: TextStyle(color: HexColor('025CAF')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void bottomsheetName(controller1, controller2, hintName1, hintName2) {
    showModalBottomSheet(
      context: context,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(hintName1,
                style: const TextStyle(color: Colors.black, fontSize: 20.0)),
            const SizedBox(height: 20.0),
            TextField(
              maxLength: 25,
              controller: controller1,
            ),
            const SizedBox(height: 20.0),
            Text(hintName2,
                style: const TextStyle(color: Colors.black, fontSize: 20.0)),
            const SizedBox(height: 20.0),
            TextField(
              maxLength: 25,
              controller: controller2,
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(color: HexColor('025CAF')),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // updateUserData({
                    //   'first_name': _firstnameController.text,
                    //   'last_name': _lastnameController.text,
                    // });

                    await ref.read(apiProvider).updateUserData({
                      'first_name': _firstnameController.text,
                      'last_name': _lastnameController.text,
                    });
                    // ignore: unused_result
                    ref.refresh(userDataProvider);
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.save,
                    style: TextStyle(color: HexColor('025CAF')),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: userData.when(
        data: (user) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor('368FF8'),
                      HexColor('025CAF'),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
              title: Text(
                translation(context).profilepage,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            drawer: CustomDrawer(context, user.first_name, user.profile_pic),
            bottomNavigationBar: BottomNavBar(context, 3),
            body: Stack(
              children: [
                Positioned(
                  child: Image.asset(
                    "assets/images/profile_background.png",
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 140,
                  top: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: CircleAvatar(
                      radius: 58,
                      backgroundImage: user.profile_pic.isNotEmpty
                          ? NetworkImage(user.profile_pic)
                          : const AssetImage('assets/images/placeholder.jpg')
                              as ImageProvider,
                    ),
                  ),
                ),
                Positioned(
                  width: MediaQuery.of(context).size.width * 1.15,
                  height: MediaQuery.of(context).size.height * 0.32,
                  child: IconButton(
                    onPressed: _takePicture,
                    icon: Material(
                      borderRadius: BorderRadius.circular(30),
                      child: const Icon(
                        Icons.add_circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      buildInfoContainer(
                        context,
                        icon: Icons.person_outlined,
                        text: '${user.first_name} ${user.last_name}',
                        onTap: () {
                          _firstnameController.text = user.first_name;
                          _lastnameController.text = user.last_name;
                          bottomsheetName(
                            _firstnameController,
                            _lastnameController,
                            AppLocalizations.of(context)!.firstnamehint,
                            AppLocalizations.of(context)!.lastnamehint,
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      buildInfoContainer(
                        context,
                        icon: Icons.email,
                        text: user.email,
                        onTap: () {
                          _emailController.text = user.email;
                          bottomsheet(
                            _emailController,
                            translation(context).emailhint,
                            () async {
                              await ref.read(apiProvider).updateUserData({
                                'email': _emailController.text,
                              });
                              Navigator.pop(context);
                              // ignore: unused_result
                              ref.refresh(userDataProvider);
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      buildLanguageSelector(context),
                      const SizedBox(height: 30),
                      buildSettingsContainer(context),
                      const SizedBox(height: 20.0),
                      buildLogoutButton(context),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(
              HexColor('368FF8'),
            ),
          ),
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
