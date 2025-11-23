import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/decoration/box_decoration.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/widgets/container/behind_container.dart';

@immutable
final class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({required this.child, super.key});

  final Widget child;

  static final List<String> tabs = [
    RoutePaths.Image.path,
    RoutePaths.Audio.path,
    RoutePaths.Document.path,
    RoutePaths.Profile.path,
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    var currentIndex = tabs.indexWhere(location.startsWith);
    if (currentIndex == -1) currentIndex = 0;

    return Scaffold(
      body: child,
      floatingActionButton: Container(
        height: 64,
        width: 64,
        decoration: CustomBoxDecoration.aiGradient(),
        child: FloatingActionButton(
          onPressed: () async => context.pushNamed(RoutePaths.chat.name),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(
            Icons.auto_awesome_rounded,
            size: 30,
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          router.go(tabs[index]);
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: BehindContainer(
              isCurrentIndex: currentIndex == 0,
              selectedIcon: Icons.image,
              unSelectedIcon: Icons.image_outlined,
            ),
            label: RoutePaths.Image.name,
          ),
          BottomNavigationBarItem(
            icon: BehindContainer(
              isCurrentIndex: currentIndex == 1,
              selectedIcon: Icons.mic_rounded,
              unSelectedIcon: Icons.mic_none_rounded,
            ),
            label: RoutePaths.Audio.name,
          ),
          BottomNavigationBarItem(
            icon: BehindContainer(
              isCurrentIndex: currentIndex == 2,
              selectedIcon: Icons.edit_document,
              unSelectedIcon: Icons.edit_document,
            ),
            label: RoutePaths.Document.name,
          ),
          BottomNavigationBarItem(
            icon: BehindContainer(
              isCurrentIndex: currentIndex == 3,
              selectedIcon: Icons.person_rounded,
              unSelectedIcon: Icons.person_outline_rounded,
            ),
            label: RoutePaths.Profile.name,
          ),
        ],
      ),
    );
  }
}
