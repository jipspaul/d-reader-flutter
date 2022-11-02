import 'package:d_reader_flutter/config/config.dart';
import 'package:d_reader_flutter/core/providers/scaffold_provider.dart';
import 'package:d_reader_flutter/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DReaderScaffold extends ConsumerWidget {
  final Widget body;
  const DReaderScaffold({
    Key? key,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: PreferredSize(
        preferredSize: const Size(0, 96),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: AppBar(
            leading: Container(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                Config.logoTextPath,
              ),
            ),
            leadingWidth: 164,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.9),
            actions: const [
              Icon(
                Icons.notifications_none,
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.person_outline,
              ),
            ],
          ),
        ),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          ref.read(scaffoldProvider.notifier).setNavigationIndex(value);
        },
        currentIndex: ref.watch(scaffoldProvider).navigationIndex,
        selectedItemColor: dReaderYellow,
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.9),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            label: 'Comics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            label: 'Creators',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline),
            label: 'Marketplace',
          ),
        ],
      ),
    );
  }
}
