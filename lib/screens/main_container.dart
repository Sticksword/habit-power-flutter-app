import 'package:flutter/material.dart';

import 'bottom_navigation.dart';
import 'tab_navigator.dart';

import 'home_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';
import 'likes_screen.dart';
import 'login_screen.dart';

import 'package:habit_power/data/database_helper.dart';
import 'package:habit_power/auth.dart';

class MainContainer extends StatefulWidget {
 @override
 State<StatefulWidget> createState() {
    return _MainContainerState();
  }
}

// https://stackoverflow.com/questions/45235570/how-to-use-bottomnavigationbar-with-navigator
class _MainContainerState extends State<MainContainer> implements AuthStateListener {

  TabItem currentTab = TabItem.home;
  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.search: GlobalKey<NavigatorState>(),
    TabItem.likes: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>()
  };

  @override
  void initState() {
    super.initState();
    print('initializing main screen state');
    
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);

  }

  void _logout() async {
    var db = new DatabaseHelper();
    await db.deleteUsers();
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_OUT);
    print('_logout');
  }

  @override
  onAuthStateChanged(AuthState state) {
    if(state == AuthState.LOGGED_OUT)
      Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
          builder: (BuildContext context) => new LoginScreen()));
  }

  void _selectTab(TabItem tabItem) {
    setState(() {
      currentTab = tabItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[currentTab].currentState.maybePop(),
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildScreens(TabItem.home),
          _buildScreens(TabItem.search),
          _buildScreens(TabItem.likes),
          _buildScreens(TabItem.profile)
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildScreens(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.home:
        return Offstage(
          offstage: currentTab != tabItem,
          child: HomeScreen()
        );
      case TabItem.search:
        return Offstage(
          offstage: currentTab != tabItem,
          child: SearchScreen()
        );
      case TabItem.likes:
        return Offstage(
          offstage: currentTab != tabItem,
          child: LikesScreen()
        );
        // return _buildOffstageNavigator(tabItem);
      case TabItem.profile:
        return Offstage(
          offstage: currentTab != tabItem,
          child: ProfileScreen(logout: () => _logout())
        );
    }
    return null;
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

  @override
  void dispose() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.dispose(this);
    super.dispose();
  }
}