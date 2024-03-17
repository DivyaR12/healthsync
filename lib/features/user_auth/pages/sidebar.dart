import 'package:sidebarx/sidebarx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../global/toast.dart';

class SidebarXExampleApp extends StatelessWidget {
  SidebarXExampleApp({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SidebarX Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        body: Row(
          children: [
            SidebarX(
              controller: _controller,
              theme: SidebarXTheme(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: canvasColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(color: Colors.white),
                selectedTextStyle: const TextStyle(color: Colors.white),
                itemTextPadding: const EdgeInsets.only(left: 30),
                selectedItemTextPadding: const EdgeInsets.only(left: 30),
                itemDecoration: BoxDecoration(
                  border: Border.all(color: canvasColor),
                ),
                selectedItemDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: actionColor.withOpacity(0.37),
                  ),
                  gradient: const LinearGradient(
                    colors: [accentCanvasColor, canvasColor],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.28),
                      blurRadius: 30,
                    )
                  ],
                ),
                iconTheme: const IconThemeData(
                  color: Colors.white,
                  size: 20,
                ),
              ),
              extendedTheme: const SidebarXTheme(
                width: 200,
                decoration: BoxDecoration(
                  color: canvasColor,
                ),
                margin: EdgeInsets.only(right: 10),
              ),
              footerDivider: divider,
              headerBuilder: (context, extended) {
                return SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('../../../../assets/Healthsync.png'),
                  ),
                );
              },
              items: [
                SidebarXItem(
                  icon: Icons.home,
                  label: 'Home',
                  onTap: () {
                    debugPrint('Home');
                    // Navigate to Home screen
                  },
                ),
                SidebarXItem(
                  icon: Icons.search,
                  label: 'Find doctors',
                  onTap: () {
                    debugPrint('Find doctors');
                    // Navigate to Find doctors screen
                  },
                ),
                SidebarXItem(
                  icon: Icons.description,
                  label: 'Prescriptions',
                  onTap: () {
                    debugPrint('Prescriptions');
                    // Navigate to Prescriptions screen
                  },
                ),
                SidebarXItem(
                  icon: Icons.logout,
                  label: 'Signout',
                  onTap: () {
                    debugPrint('Signout');
                    // Perform signout action
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: _ScreensExample(controller: _controller),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            // Home screen content
            return Center(
              child: Text(
                'Home',
                style: theme.textTheme.headlineSmall,
              ),
            );
          case 1:
            // Find doctors screen content
            return Center(
              child: Text(
                'Find doctors',
                style: theme.textTheme.headlineSmall,
              ),
            );
          case 2:
            // Prescriptions screen content
            return Center(
              child: Text(
                'Prescriptions',
                style: theme.textTheme.headlineSmall,
              ),
            );
          default:
            // Handle other cases (optional)
            return Center(
              child: Text(
                'Not found page',
                style: theme.textTheme.headlineSmall,
              ),
            );
        }
      },
    );
  }
}

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);

final divider = Divider(color: white.withOpacity(0.3), height: 1);