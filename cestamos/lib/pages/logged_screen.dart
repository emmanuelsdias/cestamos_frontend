import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'lists_page.dart';
import 'friends_page.dart';
import 'recipes_page.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../providers/friendships.dart';

/// LoggedScreen of the application.
///
/// Provides Navigation to various pages in the application and maintains their
/// state.
///
/// Default first page is [TimelinePage].
class LoggedScreen extends StatefulWidget {
  /// Creates a new [LoggedScreen]
  const LoggedScreen({Key? key}) : super(key: key);
  static const pageRouteName = "/logged";

  /// List of pages available from the home screen.
  static const List<Widget> _homePages = <Widget>[
    _KeepAlivePage(child: ListsPage()),
    _KeepAlivePage(child: FriendsPage()),
    _KeepAlivePage(child: RecipesPage()),
  ];

  @override
  // ignore: library_private_types_in_public_api
  _LoggedScreenState createState() => _LoggedScreenState();
}

class _LoggedScreenState extends State<LoggedScreen> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Friendships(),
      child: Scaffold(
        body: PageView(
          controller: pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: LoggedScreen._homePages,
        ),
        bottomNavigationBar: _StreamagramBottomNavBar(
          pageController: pageController,
        ),
      ),
    );
  }
}

class _StreamagramBottomNavBar extends StatefulWidget {
  const _StreamagramBottomNavBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  State<_StreamagramBottomNavBar> createState() =>
      _StreamagramBottomNavBarState();
}

class _StreamagramBottomNavBarState extends State<_StreamagramBottomNavBar> {
  void _onNavigationItemTapped(int index) {
    widget.pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      onTap: _onNavigationItemTapped,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 2,
      behaviour: SnakeBarBehaviour.pinned,
      snakeShape: SnakeShape.indicator,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      snakeViewColor: Theme.of(context).colorScheme.inversePrimary,
      selectedItemColor: Theme.of(context).colorScheme.inversePrimary,
      unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
      currentIndex: widget.pageController.page?.toInt() ?? 0,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'listas'),
        BottomNavigationBarItem(icon: Icon(Icons.face), label: 'amigos'),
        BottomNavigationBarItem(icon: Icon(Icons.liquor), label: 'receitas')
      ],
    );
  }
}

class _KeepAlivePage extends StatefulWidget {
  const _KeepAlivePage({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _KeepAlivePageState createState() => _KeepAlivePageState();
}

class _KeepAlivePageState extends State<_KeepAlivePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
