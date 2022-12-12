import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unimeet101/utils/colors.dart';
import 'package:unimeet101/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        //physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              color: _page == 0 ? null : secondaryColor,
              height: 25,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search,
          //       color: _page == 1 ? primaryColor : secondaryColor),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              color: _page == 1 ? activeColor : secondaryColor,
              height: 25,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_circle,
          //       color: _page == 2 ? primaryColor : secondaryColor),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/add_post.svg',
              color: _page == 2 ? null : null,
              height: 60,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.favorite,
          //       color: _page == 3 ? primaryColor : secondaryColor),
          //   label: '',
          //   backgroundColor: primaryColor,
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bar_heart.svg',
              color: _page == 3 ? activeColor : secondaryColor,
              height: 25,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,
                color: _page == 4 ? activeColor : secondaryColor),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
