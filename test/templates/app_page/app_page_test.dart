import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pragma_design_system/templates.dart';
import 'package:pragma_design_system/atoms.dart';

void main() {
  group('AppPage Tests', () {
    group('Constructor and Properties', () {
      testWidgets('should create with required parameters', (tester) async {
        const appPage = AppPage(
          title: 'Test Page',
          body: Text('Test Content'),
        );

        expect(appPage.title, 'Test Page');
        expect(appPage.body, isA<Text>());
        expect(appPage.showBackButton, true); // Default value
        expect(appPage.actions, isNull); // Default value
        expect(appPage.bottomNavigationBar, isNull); // Default value
        expect(appPage.floatingActionButton, isNull); // Default value
      });

      testWidgets('should accept all optional parameters', (tester) async {
        final actions = [IconButton(icon: const Icon(Icons.search), onPressed: () {})];
        final bottomNav = BottomNavigationBar(items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ]);
        final fab = FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add));
        
        final appPage = AppPage(
          title: 'Custom Page',
          body: const Text('Custom Content'),
          showBackButton: false,
          actions: actions,
          bottomNavigationBar: bottomNav,
          floatingActionButton: fab,
        );

        expect(appPage.title, 'Custom Page');
        expect(appPage.showBackButton, false);
        expect(appPage.actions, actions);
        expect(appPage.bottomNavigationBar, bottomNav);
        expect(appPage.floatingActionButton, fab);
      });
    });

    group('Basic Page Structure', () {
      testWidgets('should display basic page with title and body', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Home Page',
              body: Text('Welcome to the app'),
            ),
          ),
        );

        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(AppBar), findsOneWidget);
        expect(find.text('Home Page'), findsOneWidget);
        expect(find.text('Welcome to the app'), findsOneWidget);
      });

      testWidgets('should use Scaffold as root widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Test',
              body: Text('Content'),
            ),
          ),
        );

        final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
        expect(scaffold.appBar, isNotNull);
        expect(scaffold.body, isNotNull);
      });

      testWidgets('should wrap body with SafeArea', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Safe Area Test',
              body: Text('Safe Content'),
            ),
          ),
        );

        final safeAreas = tester.widgetList<SafeArea>(find.byType(SafeArea));
        final bodySafeArea = safeAreas.firstWhere((sa) => sa.child is Text);
        expect(bodySafeArea.child, isA<Text>());
        expect(find.descendant(
          of: find.byType(SafeArea),
          matching: find.text('Safe Content'),
        ), findsOneWidget);
      });
    });

    group('AppBar Configuration', () {
      testWidgets('should display title with correct AppText styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Styled Title',
              body: Text('Content'),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Styled Title'),
        );
        expect(titleWidget.variant, AppTextVariant.titleLarge);
      });

      testWidgets('should have zero elevation on AppBar', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'No Elevation',
              body: Text('Content'),
            ),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.elevation, 0.0);
      });

      testWidgets('should show back button when Navigator can pop and showBackButton is true', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppPage(
                            title: 'Second Page',
                            body: Text('Second Page Content'),
                            showBackButton: true,
                          ),
                        ),
                      );
                    },
                    child: const Text('Navigate'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Navigate'));
        await tester.pumpAndSettle();

        expect(find.byType(BackButton), findsOneWidget);
      });

      testWidgets('should not show back button when showBackButton is false', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppPage(
                            title: 'No Back Button',
                            body: Text('Content'),
                            showBackButton: false,
                          ),
                        ),
                      );
                    },
                    child: const Text('Navigate'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Navigate'));
        await tester.pumpAndSettle();

        expect(find.byType(BackButton), findsNothing);
      });

      testWidgets('should not show back button when Navigator cannot pop', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Home Page',
              body: Text('Content'),
              showBackButton: true,
            ),
          ),
        );

        expect(find.byType(BackButton), findsNothing);
      });

      testWidgets('should display actions when provided', (tester) async {
        final searchButton = IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        );
        final moreButton = IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        );

        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Page with Actions',
              body: const Text('Content'),
              actions: [searchButton, moreButton],
            ),
          ),
        );

        expect(find.byIcon(Icons.search), findsOneWidget);
        expect(find.byIcon(Icons.more_vert), findsOneWidget);
      });

      testWidgets('should not display actions when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'No Actions',
              body: Text('Content'),
            ),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.actions, isNull);
      });

      testWidgets('should display empty actions list', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Empty Actions',
              body: Text('Content'),
              actions: [],
            ),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.actions, isEmpty);
      });
    });

    group('Body Content', () {
      testWidgets('should display simple text body', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Simple Body',
              body: Text('Simple content'),
            ),
          ),
        );

        expect(find.text('Simple content'), findsOneWidget);
      });

      testWidgets('should display complex widget body', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Complex Body',
              body: Column(
                children: [
                  const Text('Header'),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: const Text('Padded content'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Action Button'),
                  ),
                ],
              ),
            ),
          ),
        );

        expect(find.text('Header'), findsOneWidget);
        expect(find.text('Padded content'), findsOneWidget);
        expect(find.text('Action Button'), findsOneWidget);
        expect(find.byType(Column), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
      });

      testWidgets('should handle scrollable body content', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Scrollable Body',
              body: ListView(
                children: List.generate(
                  50,
                  (index) => ListTile(title: Text('Item $index')),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(ListView), findsOneWidget);
        expect(find.text('Item 0'), findsOneWidget);
        
        // Scroll to find items at the bottom
        await tester.drag(find.byType(ListView), const Offset(0, -2000));
        await tester.pumpAndSettle();
        
        // Scroll more to ensure we reach the bottom
        await tester.drag(find.byType(ListView), const Offset(0, -2000));
        await tester.pumpAndSettle();
        expect(find.text('Item 49'), findsOneWidget);
      });

      testWidgets('should handle body with custom widgets', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Custom Widgets',
              body: Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text('Card Content'),
                        const SizedBox(height: 8),
                        LinearProgressIndicator(value: 0.5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

        expect(find.byType(Card), findsOneWidget);
        expect(find.byType(LinearProgressIndicator), findsOneWidget);
        expect(find.text('Card Content'), findsOneWidget);
      });
    });

    group('Bottom Navigation Bar', () {
      testWidgets('should display bottom navigation bar when provided', (tester) async {
        final bottomNavBar = BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        );

        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'With Bottom Nav',
              body: const Text('Content'),
              bottomNavigationBar: bottomNavBar,
            ),
          ),
        );

        expect(find.byType(BottomNavigationBar), findsOneWidget);
        expect(find.text('Home'), findsOneWidget);
        expect(find.text('Search'), findsOneWidget);
        expect(find.text('Profile'), findsOneWidget);
      });

      testWidgets('should not display bottom navigation bar when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'No Bottom Nav',
              body: Text('Content'),
            ),
          ),
        );

        expect(find.byType(BottomNavigationBar), findsNothing);
      });

      testWidgets('should handle custom bottom navigation widgets', (tester) async {
        final customBottomWidget = Container(
          height: 60,
          color: Colors.blue,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.favorite, color: Colors.white),
              Icon(Icons.share, color: Colors.white),
            ],
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Custom Bottom',
              body: const Text('Content'),
              bottomNavigationBar: customBottomWidget,
            ),
          ),
        );

        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.share), findsOneWidget);
      });
    });

    group('Floating Action Button', () {
      testWidgets('should display floating action button when provided', (tester) async {
        final fab = FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'With FAB',
              body: const Text('Content'),
              floatingActionButton: fab,
            ),
          ),
        );

        expect(find.byType(FloatingActionButton), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
      });

      testWidgets('should not display floating action button when null', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'No FAB',
              body: Text('Content'),
            ),
          ),
        );

        expect(find.byType(FloatingActionButton), findsNothing);
      });

      testWidgets('should handle extended floating action button', (tester) async {
        final extendedFab = FloatingActionButton.extended(
          onPressed: () {},
          icon: const Icon(Icons.create),
          label: const Text('Create'),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Extended FAB',
              body: const Text('Content'),
              floatingActionButton: extendedFab,
            ),
          ),
        );

        expect(find.byType(FloatingActionButton), findsOneWidget);
        expect(find.byIcon(Icons.create), findsOneWidget);
        expect(find.text('Create'), findsOneWidget);
      });

      testWidgets('should handle custom floating action button', (tester) async {
        final customFab = FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          child: const Icon(Icons.star),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Custom FAB',
              body: const Text('Content'),
              floatingActionButton: customFab,
            ),
          ),
        );

        final fab = tester.widget<FloatingActionButton>(find.byType(FloatingActionButton));
        expect(fab.backgroundColor, Colors.purple);
        expect(fab.foregroundColor, Colors.white);
        expect(find.byIcon(Icons.star), findsOneWidget);
      });
    });

    group('Complete Page Scenarios', () {
      testWidgets('should display complete page with all components', (tester) async {
        bool fabPressed = false;
        int navIndex = 0;
        bool searchPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: StatefulBuilder(
              builder: (context, setState) {
                return AppPage(
                  title: 'Complete App Page',
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Welcome to the complete page!'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Action Button'),
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () => searchPressed = true,
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                  bottomNavigationBar: BottomNavigationBar(
                    currentIndex: navIndex,
                    onTap: (index) => setState(() => navIndex = index),
                    items: const [
                      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                    ],
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => fabPressed = true,
                    child: const Icon(Icons.add),
                  ),
                );
              },
            ),
          ),
        );

        expect(find.text('Complete App Page'), findsOneWidget);
        expect(find.text('Welcome to the complete page!'), findsOneWidget);
        expect(find.byType(BottomNavigationBar), findsOneWidget);
        expect(find.byType(FloatingActionButton), findsOneWidget);
        expect(find.byIcon(Icons.search), findsNWidgets(2)); // In actions and bottom nav

        // Test interactions
        await tester.tap(find.byType(FloatingActionButton));
        expect(fabPressed, true);

        await tester.tap(find.byIcon(Icons.search).first); // AppBar search icon
        expect(searchPressed, true);
      });

      testWidgets('should display minimal page with only required parameters', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Minimal Page',
              body: Text('Just the basics'),
            ),
          ),
        );

        expect(find.text('Minimal Page'), findsOneWidget);
        expect(find.text('Just the basics'), findsOneWidget);
        expect(find.byType(BottomNavigationBar), findsNothing);
        expect(find.byType(FloatingActionButton), findsNothing);
        expect(find.byType(BackButton), findsNothing);
      });

      testWidgets('should handle page with nested navigation', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Navigator(
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(
                    builder: (context) => const AppPage(
                      title: 'Nested Page',
                      body: Text('Nested content'),
                    ),
                  );
                },
              ),
            ),
          ),
        );

        expect(find.text('Nested Page'), findsOneWidget);
        expect(find.text('Nested content'), findsOneWidget);
      });
    });

    group('Theme Integration', () {
      testWidgets('should adapt to light theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.light,
              ),
            ),
            home: const AppPage(
              title: 'Light Theme',
              body: Text('Light content'),
            ),
          ),
        );

        final appBar = tester.widget<AppBar>(find.byType(AppBar));
        expect(appBar.elevation, 0);
        expect(find.text('Light Theme'), findsOneWidget);
      });

      testWidgets('should adapt to dark theme', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: Brightness.dark,
              ),
            ),
            home: const AppPage(
              title: 'Dark Theme',
              body: Text('Dark content'),
            ),
          ),
        );

        expect(find.text('Dark Theme'), findsOneWidget);
        expect(find.text('Dark content'), findsOneWidget);
      });

      testWidgets('should use AppText for title styling', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Styled Title',
              body: Text('Content'),
            ),
          ),
        );

        final titleWidget = tester.widget<AppText>(
          find.widgetWithText(AppText, 'Styled Title'),
        );
        expect(titleWidget.variant, AppTextVariant.titleLarge);
      });
    });

    group('Edge Cases', () {
      testWidgets('should handle very long titles', (tester) async {
        const longTitle = 'This is an extremely long page title that might overflow or wrap and should be handled gracefully by the AppPage template';
        
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: longTitle,
              body: Text('Content'),
            ),
          ),
        );

        expect(find.text(longTitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle empty title string', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: '',
              body: Text('Empty title content'),
            ),
          ),
        );

        expect(find.text(''), findsOneWidget);
        expect(find.text('Empty title content'), findsOneWidget);
      });

      testWidgets('should handle special characters in title', (tester) async {
        const specialTitle = 'Title: !@#\$%^&*() 🚀 Special';
        
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: specialTitle,
              body: Text('Special content'),
            ),
          ),
        );

        expect(find.text(specialTitle), findsOneWidget);
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle complex body layouts', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Complex Layout',
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(height: 200, color: Colors.red),
                    Container(height: 200, color: Colors.green),
                    Container(height: 200, color: Colors.blue),
                  ],
                ),
              ),
            ),
          ),
        );

        expect(find.byType(SingleChildScrollView), findsOneWidget);
        expect(find.byType(Container), findsNWidgets(3));
        expect(tester.takeException(), isNull);
      });

      testWidgets('should handle many actions', (tester) async {
        final manyActions = List.generate(
          10,
          (index) => IconButton(
            icon: Icon(Icons.star, key: Key('star_$index')),
            onPressed: () {},
          ),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: AppPage(
              title: 'Many Actions',
              body: const Text('Content'),
              actions: manyActions,
            ),
          ),
        );

        expect(find.byIcon(Icons.star), findsNWidgets(10));
        expect(tester.takeException(), isNull);
      });
    });

    group('Accessibility', () {
      testWidgets('should be semantically accessible', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: const AppPage(
              title: 'Accessible Page',
              body: Text('Accessible content'),
            ),
          ),
        );

        // AppBar should provide semantic structure
        expect(find.byType(AppBar), findsOneWidget);
        
        // Title should use proper AppText component
        expect(find.byType(AppText), findsOneWidget);
        
        // SafeArea ensures content is accessible
        expect(find.byType(SafeArea), findsWidgets);
      });

      testWidgets('should handle navigation accessibility', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AppPage(
                            title: 'Second Page',
                            body: Text('Second page content'),
                          ),
                        ),
                      );
                    },
                    child: const Text('Navigate'),
                  );
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Navigate'));
        await tester.pumpAndSettle();

        // Back button should be accessible
        expect(find.byType(BackButton), findsOneWidget);
      });
    });
  });
}