import 'package:Sivayogi_The_Guru/data/api_service.dart';
import 'package:Sivayogi_The_Guru/data/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Sivayogi_The_Guru/model/user_model.dart';
import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:Sivayogi_The_Guru/imagepage.dart';
import 'package:Sivayogi_The_Guru/videospage.dart';

final aboutContentProvider = FutureProvider<List<dynamic>>((ref) async {
  final apiService = ApiService();
  return apiService.fetchaboutInfo();
});

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

class AboutsPage extends ConsumerWidget {
  final Locale? _locale;

  const AboutsPage(this._locale, {super.key});

  // void _takePicture(BuildContext context) async {
  //   final imagePicker = ImagePicker();

  //   final pickedImage = await imagePicker.pickImage(
  //     source: ImageSource.gallery,
  //   );

  //   if (pickedImage == null) {
  //     return;
  //   } else {
  //     await context
  //         .read(userProvider.notifier)
  //         .uploadUserImage(pickedImage.path);
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final aboutContentAsync = ref.watch(aboutContentProvider);
    String _localeValue = _locale.toString();

    return Scaffold(
      drawer: CustomDrawer(
          context, user?.first_name ?? '', user?.profile_pic ?? ''),
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
          AppLocalizations.of(context)!.aboutpage,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      bottomNavigationBar: BottomNavBar(context, 2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            aboutContentAsync.when(
              data: (content) {
                var contentEnglish =
                    content.isNotEmpty ? content[0]['content_english'] : '';
                var contentTamil =
                    content.isNotEmpty ? content[0]['content_tamil'] : '';
                var contentToShow =
                    _localeValue == 'en' ? contentEnglish : contentTamil;

                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      contentToShow,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4D4D4D),
                        fontSize: 14.00,
                        fontFamily: 'Alata',
                        fontWeight: FontWeight.w400,
                        height: 0,
                        letterSpacing: 0.44,
                      ),
                    ),
                  ),
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, _) =>
                  Center(child: Text('Failed to load content')),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.morevideos,
                        style: TextStyle(
                          color: Color(0xFF257FE0),
                          fontSize: 20,
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideosPage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  height: 230,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 6,
                        offset: Offset(0, 0),
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Image.asset('assets/images/videos.png'),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.morephotos,
                        style: TextStyle(
                          color: Color(0xFF257FE0),
                          fontSize: 20,
                          fontFamily: 'Alata',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImagePage(),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue,
                          size: 40,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 320,
                  height: 230,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    shadows: [
                      BoxShadow(
                        color: Color(0x26000000),
                        blurRadius: 6,
                        offset: Offset(0, 0),
                        spreadRadius: 3,
                      )
                    ],
                  ),
                  child: Image.asset('assets/images/photos.png'),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
