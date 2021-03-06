import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/splash_page.dart';
import 'core/di/injection_container.dart' as di;
import 'core/presentation/routes/router.gr.dart';
import 'core/theme/theme_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 비동기로 진행 시, 반드시 추가해야함.
  await di.init();
  runApp(Main());
}

class Main extends StatelessWidget {
  // final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.container<ThemeNotifier>(),
      child: Builder(builder: (context) {
        ThemeNotifier themeService = Provider.of<ThemeNotifier>(context);
        return MaterialApp(
          theme: themeService.getTheme(),
          debugShowCheckedModeBanner: false,
          builder: ExtendedNavigator.builder(
            router: AppRouter(),
            builder: (context, extendedNav) => Theme(
              data: themeService.getTheme(),
              child: extendedNav,
            ),
          ),
          home: SplashView(),
          // MaterialApp.router(
          // routerDelegate: _appRouter .delegate(),
          // routeInformationParser: _appRouter.defaultRouteParser(),
          // ),
        );
      }),
    );
  }
}
