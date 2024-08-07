import 'package:Sivayogi_The_Guru/data/api_service.dart';
import 'package:Sivayogi_The_Guru/model/cources_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:readmore/readmore.dart';
import 'package:hexcolor/hexcolor.dart';

final coursesProvider = FutureProvider<List<Course>>((ref) async {
  final apiService = ApiService();
  return apiService.fetchCourses();
});

class CoursesPage extends ConsumerStatefulWidget {
  final Locale? _locale;

  const CoursesPage(this._locale, {super.key});

  @override
  ConsumerState<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends ConsumerState<CoursesPage> {
  var _selectedVal;
  var _selectedVal1;
  var _selectedVal2;
  var _selectedVal3;
  var _selectedVal4;

  @override
  Widget build(BuildContext context) {
    final coursesAsync = ref.watch(coursesProvider);
    String _localeValue = widget._locale.toString();

    return Scaffold(
      body: coursesAsync.when(
        data: (courses) {
          if (courses.isNotEmpty) {
            _selectedVal = _localeValue == 'en'
                ? courses[0].subCourses.first.titleEnglish
                : courses[0].subCourses.first.titleTamil;
            _selectedVal1 = _localeValue == 'en'
                ? courses[1].subCourses.first.titleEnglish
                : courses[1].subCourses.first.titleTamil;
            _selectedVal2 = _localeValue == 'en'
                ? courses[2].subCourses.first.titleEnglish
                : courses[2].subCourses.first.titleTamil;
            _selectedVal3 = _localeValue == 'en'
                ? courses[3].subCourses.first.titleEnglish
                : courses[3].subCourses.first.titleTamil;
            _selectedVal4 = _localeValue == 'en'
                ? courses[4].subCourses.first.titleEnglish
                : courses[4].subCourses.first.titleTamil;
          }

          return Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    // Cover Picture
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        color: HexColor('257FE0'),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 40,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Profile Picture
                    Positioned(
                      left: MediaQuery.of(context).size.width * 0.20,
                      top: 130,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 68,
                        child: CircleAvatar(
                          radius: 62,
                          backgroundImage:
                              AssetImage('assets/images/readbook.png'),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      top: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                AppLocalizations.of(context)!.courses_titile1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Alata',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Container(
                                width: 350,
                                decoration: ShapeDecoration(
                                  color: HexColor('D9D9D9'),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .courses_titile2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (int i = 0; i < courses.length; i++)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(_localeValue == 'en'
                                            ? courses[i].titleEnglish
                                            : courses[i].titleTamil),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromARGB(
                                                    255, 223, 221, 221),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              elevation: 2,
                                              isExpanded: true,
                                              iconEnabledColor: Colors.blue,
                                              style: TextStyle(
                                                color: Colors.blue,
                                              ),
                                              value: i == 0
                                                  ? _selectedVal
                                                  : i == 1
                                                      ? _selectedVal1
                                                      : i == 2
                                                          ? _selectedVal2
                                                          : i == 3
                                                              ? _selectedVal3
                                                              : _selectedVal4,
                                              onChanged: (newValue) {
                                                setState(() {
                                                  if (i == 0) {
                                                    _selectedVal = newValue!;
                                                  } else if (i == 1) {
                                                    _selectedVal1 = newValue!;
                                                  } else if (i == 2) {
                                                    _selectedVal2 = newValue!;
                                                  } else if (i == 3) {
                                                    _selectedVal3 = newValue!;
                                                  } else {
                                                    _selectedVal4 = newValue!;
                                                  }
                                                });
                                              },
                                              items: courses[i].subCourses.map<
                                                      DropdownMenuItem<String>>(
                                                  (subCourse) {
                                                return DropdownMenuItem<String>(
                                                  value: _localeValue == 'en'
                                                      ? subCourse.titleEnglish
                                                      : subCourse.titleTamil,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      _localeValue == 'en'
                                                          ? subCourse
                                                              .titleEnglish
                                                          : subCourse
                                                              .titleTamil,
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              key: const Key('showMore'),
                              padding: const EdgeInsets.all(16.0),
                              child: ReadMoreText(
                                AppLocalizations.of(context)!.courses_titile3,
                                trimLines: 2,
                                preDataText: "AMANDA",
                                preDataTextStyle:
                                    TextStyle(fontWeight: FontWeight.w500),
                                style: TextStyle(color: Colors.black),
                                colorClickableText: Colors.blue,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: '...Show more',
                                trimExpandedText: ' show less',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Failed to load courses')),
      ),
    );
  }
}
