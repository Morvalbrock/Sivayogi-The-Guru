import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:Sivayogi_The_Guru/data/api_service.dart';
import 'package:Sivayogi_The_Guru/data/user_notifier.dart';
import 'package:Sivayogi_The_Guru/model/user_model.dart';
import 'package:Sivayogi_The_Guru/model/book_model.dart';
import 'package:fab_circular_menu_plus/fab_circular_menu_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

final booksProvider = FutureProvider<List<BookModel>>((ref) async {
  final apiService = ApiService();
  return apiService.fetchBooks();
});

class BooksPage extends ConsumerStatefulWidget {
  const BooksPage(this._locale, {Key? key}) : super(key: key);

  final Locale? _locale;

  @override
  ConsumerState<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends ConsumerState<BooksPage> {
  final GlobalKey<FabCircularMenuPlusState> fabKey = GlobalKey();

  List<BookModel> allBooks = []; // Store the full list of users
  List<BookModel> displayBooks = []; // Displayed and filtered list

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void fetchBooks() async {
    final books = await ref.read(booksProvider.future);
    setState(() {
      allBooks = books;
      displayBooks = List.from(allBooks);
    });
  }

  void updateList(String value) {
    setState(() {
      if (value.isEmpty) {
        displayBooks = List.from(allBooks);
      } else {
        displayBooks = allBooks
            .where((book) =>
                book.name_english.toLowerCase().contains(value.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    String _locale_value = widget._locale.toString();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
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
        ),
        title: Text(
          AppLocalizations.of(context)!.bookpage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(
          context, user?.first_name ?? '', user?.profile_pic ?? ''),
      bottomNavigationBar: BottomNavBar(context, 1),
      body: Padding(
        padding: const EdgeInsets.only(left: 28, right: 28),
        child: Column(
          children: [
            const SizedBox(height: 25),
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Users',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Baloo Chettan 2',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 5,
              child: TextField(
                onChanged: (value) => updateList(value),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10.0),
                  filled: true,
                  fillColor: const Color(0xfffeeeee),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: AppLocalizations.of(context)!.search,
                  suffixIcon: const Icon(Icons.search),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: displayBooks.length,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Card(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              displayBooks[index].image,
                              width: 80,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                _locale_value == 'en'
                                    ? displayBooks[index].name_english
                                    : displayBooks[index].name_tamil,
                                style: GoogleFonts.tiroTamil(
                                  textStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: "Noto Sans Tamil",
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DecoratedBox(
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
                          width: 115,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              final Uri whatsappnumber =
                                  Uri.parse('http://wa.me/7395833567');

                              _launchUrl(whatsappnumber);
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
                              AppLocalizations.of(context)!.enquiry,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: TabButton(context, fabKey),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
