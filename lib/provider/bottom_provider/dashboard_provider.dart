import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../config.dart';

class DashboardProvider with ChangeNotifier {
  int currentIndex = 0;
  TabController? tabController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool? isProfile = false;
  bool isBack = false;

  final List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const OrderHistoryLayout(),
    const WishListScreen(),
    const ProfileScreen()
  ];

  //tab on view and load page
  void initTabController(TickerProviderStateMixin vsync, context) {
    tabController = TabController(length: pages.length, vsync: vsync);
    currentIndex = tabController!.index;
    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    isBack = data ?? false;
  }

  //dispose call
  onDispose() {
    tabController!.dispose();
    notifyListeners();
  }

//change tab
  void changeTab(int index, context) {
    currentIndex = index;
    // if (currentIndex == 2) {
    // currentIndex = 0;
    // tabController!.animateTo(0,
    //     duration: const Duration(milliseconds: 1), curve: Curves.ease);
    // Navigator.pushNamed(
    //   context,
    //   routeName.orderHistory,
    // );
    //   notifyListeners();
    // }
    notifyListeners();
  }

  //move tab
  void moveTab(context, int index, {isBack = false}) async {
    if (isBack) {
      route.pop(context);
    } else {
      currentIndex = index;
      tabController!.animateTo(index,
          duration: const Duration(milliseconds: 1), curve: Curves.ease);
      notifyListeners();
    }
  }

//device back press
  onBackPress(index) async {
    if (index == 0) {
      SystemNavigator.pop();
    }
  }

  // list tap event
  // onTapList(dynamic data, BuildContext context) {
  //   if (data['title'] == appFonts.pageList ||
  //       data['title'] == appFonts.setting ||
  //       data['title'] == appFonts.logout) {
  //     route.pushNamed(context, data['route']);
  //   }
  // }

  onTapList(dynamic data, BuildContext context) async {
    if (data['title'] == appFonts.logout) {
      // ✅ Call logout
      final loginProvider = Provider.of<LoginProvider>(context, listen: false);
      await loginProvider.logout();

      // ✅ Clear navigation stack and go to login screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        routeName.login,
            (Route<dynamic> route) => false,
      );
    } else if (data['title'] == appFonts.pageList ||
        data['title'] == appFonts.setting) {
      route.pushNamed(context, data['route']);
    }
  }

}
