import 'package:alquran_flutter/app/routes/app_pages.dart';
import 'package:alquran_flutter/constants/constant.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/surah.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Al Quran Apps'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: const Icon(Icons.search),
            )
          ],
        ),
        body: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Assalamu\'alikum',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        appPurpleDark2,
                        appPurpleDark1,
                      ],
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => Get.toNamed(Routes.LAST_READ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            bottom: -50,
                            child: Opacity(
                              opacity: 0.5,
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Image.asset(
                                  'assets/images/img_quran.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.menu_book_outlined,
                                      color: appWhite,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Last Read',
                                      style: TextStyle(color: appWhite),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 32),
                                const Text(
                                  'Al Fatihah',
                                  style:
                                      TextStyle(fontSize: 16, color: appWhite),
                                ),
                                const Text(
                                  'Ayat No. 1',
                                  style: TextStyle(color: appWhite),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const TabBar(
                  indicatorColor: appPurpleDark2,
                  labelColor: appPurpleDark2,
                  unselectedLabelColor: appPurpleLight,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      text: 'Surah',
                    ),
                    Tab(
                      text: 'Juz',
                    ),
                    Tab(
                      text: 'Bookmark',
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      FutureBuilder<List<Surah>>(
                        future: controller.getAllSurah(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Data not found'));
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () => Get.toNamed(Routes.DETAIL_SURAH,
                                    arguments: surah),
                                leading: CircleAvatar(
                                  child: Text('${surah.number}'),
                                ),
                                title: Text(
                                    surah.name?.transliteration?.id ?? 'Error'),
                                subtitle: Text(
                                    '${surah.numberOfVerses} Ayat | ${surah.revelation?.id ?? '-'}'),
                                trailing: Text(surah.name?.short ?? '-'),
                              );
                            },
                          );
                        },
                      ),
                      const Center(
                        child: Text('Juz'),
                      ),
                      const Center(
                        child: Text('Bookmark'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
