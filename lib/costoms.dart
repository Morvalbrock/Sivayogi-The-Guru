import 'package:Sivayogi_The_Guru/classes/language.dart';
import 'package:Sivayogi_The_Guru/classes/language_constants.dart';
import 'package:Sivayogi_The_Guru/main.dart';
import 'package:Sivayogi_The_Guru/profilepage.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//navigation bar
Widget BottomNavBar(context, index) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        tileMode: TileMode.repeated,
        colors: [
          HexColor('368FF8'),
          HexColor('025CAF'),
        ],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
    ),
    height: MediaQuery.of(context).size.height * 0.10,
    child: BottomNavigationBar(
      iconSize: 20,
      currentIndex: index,
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: HexColor('5CC1EC'),
      unselectedItemColor: Colors.white,
      selectedFontSize: 10,
      unselectedFontSize: 12,
      onTap: (value) {},
      items: [
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'home',
                );
              },
              icon: Image.asset(
                'assets/icons/home.png',
                color: Colors.white,
              ),
            ),
            label: AppLocalizations.of(context)!.home),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'Books');
              },
              icon: Image.asset(
                'assets/icons/book.png',
                color: Colors.white,
                width: 13,
                height: 13,
              ),
            ),
            label: AppLocalizations.of(context)!.books),
        BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'about');
              },
              icon: Image.asset(
                'assets/icons/about.png',
                color: Colors.white,
              ),
            ),
            label: AppLocalizations.of(context)!.about),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
            icon: Image.asset(
              'assets/icons/user.png',
              color: Colors.white,
            ),
          ),
          label: AppLocalizations.of(context)!.profile,
        ),
      ],
    ),
  );
}

// Drawer

Widget CustomDrawer(context, String userName, String image_url) {
  return Drawer(
    elevation: 12.0,
    width: 280.0,
    child: ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 60,
                child: CircleAvatar(
                  radius: 58,
                  backgroundImage: image_url.isNotEmpty
                      ? NetworkImage(image_url)
                      : AssetImage('assets/images/placeholder.jpg')
                          as ImageProvider,
                ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                userName,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.01,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/home.png',
              width: 18,
              height: 18,
            ),
            title: Text(
              AppLocalizations.of(context)!.home,
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'home',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/book.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.books,
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'Books',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/branch.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.branches,
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {},
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/online-learning.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.courses,
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, 'cources');
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/helicopter.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.donations,
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'donation',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/about.png',
              width: 18,
              height: 18,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.about,
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'about',
              );
            },
          ),
        ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/user.png',
              width: 20,
              height: 20,
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.profile,
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                'profile',
              );
            },
          ),
        ),
        // SizedBox(
        //   child: ListTile(
        //     leading: const Icon(
        //       Icons.edit,
        //       size: 21.0,
        //     ),
        //     title: const Padding(
        //       padding: EdgeInsets.only(bottom: 4.0),
        //       child: Text(
        //         'Edit Content',
        //         style: TextStyle(
        //           color: Color(0xFF777777),
        //           fontSize: 14,
        //           fontFamily: 'Poppins',
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //     ),
        //     onTap: () {
        //       Navigator.pushNamed(
        //         context,
        //         'editing',
        //       );
        //     },
        //   ),
        // ),
        SizedBox(
          child: ListTile(
            leading: Image.asset(
              'assets/icons/exit.png',
              width: 18,
              height: 18,
              color: const Color.fromARGB(136, 0, 0, 0),
            ),
            title: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLocalizations.of(context)!.log_out,
                style: TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.remove('token');
              await prefs.remove('refresh_token');
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/', (Route<dynamic> route) => false);
            },
          ),
        ),
      ],
    ),
  );
}

Widget TabButton(context, gobalkey) {
  return Builder(
    builder: (context) => FabCircularMenuPlus(
      key: gobalkey,
      alignment: Alignment.bottomRight,
      ringColor: Colors.blue.withAlpha(80),
      ringDiameter: 280.0,
      ringWidth: 50.0,
      fabSize: 40.0,
      fabElevation: 8.0,
      fabIconBorder: CircleBorder(),
      fabColor: Colors.white,
      fabOpenIcon: Icon(Icons.menu, color: Colors.black),
      fabCloseIcon: Icon(Icons.close, color: Colors.black),
      // fabMargin: const EdgeInsets.all(16.0),
      animationDuration: const Duration(milliseconds: 800),
      animationCurve: Curves.easeInOutCirc,

      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            final Uri _urlyoutube =
                Uri.parse('https://www.youtube.com/@sivayogi');

            _launchUrl(_urlyoutube);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'assets/icons/youtube.png',
            width: 25,
            height: 25,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            final Uri _urlfacbook = Uri.parse(
                'https://www.facebook.com/sivayogisivakumar?mibextid=JRoKGi&rdid=hCVF9m2Pz8dDoMCW&share_url=https%3A%2F%2Fwww.facebook.com%2Fshare%2Fff5XhJHpDMWLif2n%2F%3Fmibextid%3DJRoKGi');
            _launchUrl(_urlfacbook);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'assets/icons/facebook.png',
            width: 25,
            height: 25,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            final Uri _url = Uri.parse('http://www.yogakudil.org/');

            _launchUrl(_url);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'assets/icons/world-wide-web.png',
            width: 25,
            height: 25,
          ),
        ),
        RawMaterialButton(
          onPressed: () {
            final Uri _urlinstagram = Uri.parse(
                'https://www.instagram.com/sivayogi_?igsh=OHN1ZXkzb3J1ano=');
            _launchUrl(_urlinstagram);
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: Image.asset(
            'assets/icons/instagram.png',
            width: 25,
            height: 25,
          ),
        )
      ],
    ),
  );
}

Future<void> _launchUrl(Uri url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

Widget buildInfoContainer(
  contex, {
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return Container(
    width: MediaQuery.of(contex).size.width * 0.82,
    height: MediaQuery.of(contex).size.height * 0.05,
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadows: const [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 7,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      children: [
        const SizedBox(width: 20),
        Icon(icon, color: Colors.black),
        const SizedBox(width: 20),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xFF4D4D4D),
            fontSize: 15,
            fontFamily: 'Baloo Chettan 2',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.edit,
            size: 18,
          ),
        ),
      ],
    ),
  );
}

Widget buildLanguageSelector(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.80,
    height: MediaQuery.of(context).size.height * 0.05,
    alignment: Alignment.centerLeft,
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadows: const [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 7,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      children: [
        const SizedBox(width: 20),
        const Icon(Icons.language_outlined, color: Colors.black),
        const SizedBox(width: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<Language>(
            underline: const SizedBox(),
            hint: Text(
              AppLocalizations.of(context)!.languages,
              style: const TextStyle(
                color: Color(0xFF4D4D4D),
                fontSize: 15,
                fontFamily: 'Baloo Chettan 2',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
            onChanged: (Language? language) async {
              if (language != null) {
                Locale _locale = await setLocale(language.languageCode);
                MyApp.setLocale(context, _locale);
              }
            },
            items: Language.languageList()
                .map<DropdownMenuItem<Language>>(
                  (e) => DropdownMenuItem<Language>(
                    value: e,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          e.flag,
                          style: const TextStyle(fontSize: 30),
                        ),
                        Text(e.name)
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget buildSettingsContainer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.80,
    height: MediaQuery.of(context).size.height * 0.05,
    alignment: Alignment.centerLeft,
    decoration: ShapeDecoration(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      shadows: const [
        BoxShadow(
          color: Color(0x3F000000),
          blurRadius: 7,
          offset: Offset(0, 4),
          spreadRadius: 0,
        )
      ],
    ),
    child: Row(
      children: [
        const SizedBox(width: 20),
        const Icon(Icons.settings, color: Colors.black),
        const SizedBox(width: 20),
        Text(
          AppLocalizations.of(context)!.settings,
          style: const TextStyle(
            color: Color(0xFF4D4D4D),
            fontSize: 15,
            fontFamily: 'Baloo Chettan 2',
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ],
    ),
  );
}

Widget buildLogoutButton(BuildContext context) {
  return DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          HexColor('368FF8'),
          HexColor('025CAF'),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: ElevatedButton(
        onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          await prefs.remove('refresh_token');
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ).merge(
          ButtonStyle(
            elevation: WidgetStateProperty.all(0),
          ),
        ),
        child: Text(
          AppLocalizations.of(context)!.logout,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    ),
  );
}
