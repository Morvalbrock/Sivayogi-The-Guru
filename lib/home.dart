import 'package:Sivayogi_The_Guru/data/api_service.dart';
import 'package:Sivayogi_The_Guru/data/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:Sivayogi_The_Guru/costoms.dart';
import 'package:Sivayogi_The_Guru/model/user_model.dart';

final userProvider = StateNotifierProvider<UserNotifier, UserModel?>((ref) {
  return UserNotifier();
});

final imageProvider = FutureProvider<List<String>>((ref) async {
  final apiService = ApiService();
  return apiService.fetchImages();
});

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final imageUrlsAsync = ref.watch(imageProvider);

    return Scaffold(
      backgroundColor: HexColor('FFFFFF'),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor('368FF8'),
                HexColor('025CAF'),
              ], // Adjust colors as desired
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        title: Text(
          AppLocalizations.of(context)!.homepage,
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: CustomDrawer(
          context, user?.first_name ?? '', user?.profile_pic ?? ''),
      bottomNavigationBar: BottomNavBar(context, 0),
      body: imageUrlsAsync.when(
        data: (imageUrls) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
              child: CarouselSlider.builder(
                itemCount: imageUrls.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  );
                },
                options: CarouselOptions(
                  height: 300.0,
                  aspectRatio: 5.0,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20.0,
                  bottom: 10.0,
                ),
                child: SingleChildScrollView(
                  child: Text(
                    AppLocalizations.of(context)!.home_content,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      wordSpacing: 4,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load images')),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
    );
  }
}
