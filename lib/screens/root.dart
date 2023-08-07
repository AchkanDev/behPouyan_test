import 'package:beh_pouyan_test/screens/post/add_post_screen.dart';
import 'package:beh_pouyan_test/screens/home/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const int homeIndex = 0;
const int postIndex = 1;

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];

  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _postKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    postIndex: _postKey,
  };

  Future<bool> _onWillPop() async {
    final NavigatorState currentSelectedTabNavigatorState =
        map[selectedScreenIndex]!.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: IndexedStack(index: selectedScreenIndex, children: [
            _navigator(_homeKey, homeIndex, const HomePageScreen()),
            _navigator(_postKey, postIndex, AddPostScreen()),
          ]),
          bottomNavigationBar: Row(
            children: [
              Expanded(
                child: CupertinoTabBar(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  activeColor: Theme.of(context).colorScheme.onBackground,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.home), label: ""),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.add_circled_solid),
                        label: ""),
                  ],
                  currentIndex: selectedScreenIndex,
                  onTap: (selectedIndex) {
                    setState(() {
                      _history.remove(selectedScreenIndex);
                      _history.add(selectedScreenIndex);
                      selectedScreenIndex = selectedIndex;
                    });
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) => Offstage(
                    offstage: selectedScreenIndex != index, child: child)));
  }
}
