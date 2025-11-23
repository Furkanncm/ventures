import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventures/common/router/router.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushNamed(RoutePaths.chat.name);
        },
        backgroundColor: ColorName.primary,
        elevation: 4,
        child: const Icon(
          Icons.chat_bubble_outline_rounded,
          color: ColorName.backgroundLight,
          size: 28,
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
