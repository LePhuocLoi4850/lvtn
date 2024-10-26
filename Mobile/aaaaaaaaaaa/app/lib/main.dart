import 'package:flutter/material.dart';
import 'ui/products/favorite_products.dart';
import 'ui/products/find_products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, JobsManager>(
          create: (ctx) => JobsManager(),
          update: (ctx, authManager, jobsManager) {
            jobsManager!.authToken = authManager.authToken;
            return jobsManager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager(),
        )
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'Job',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              // fontFamily: 'Lato',
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.purple,
              ),
            ),
            home: authManager.isAuth() == 'User'
                ? const JobsOverviewScreen()
                : authManager.isAuth() == 'Admin'
                    ? const UserJobsScreen()
                    : FutureBuilder(
                        future: authManager.tryAutoLogin(),
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SplashScreen();
                          } else {
                            return const AuthScreen();
                          }
                        },
                      ),
            routes: {
              CartScreen.routeName: (ctx) => const CartScreen(),
              OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              UserJobsScreen.routeName: (ctx) => const UserJobsScreen(),
              FindJobsScreen.routeName: (ctx) => const FindJobsScreen(),
              FavoriteScreen.routeName: (ctx) => const FavoriteScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == JobDetailScreen.routeName) {
                final jobId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return JobDetailScreen(
                      ctx.read<JobsManager>().findById(jobId)!,
                    );
                  },
                );
              }

              if (settings.name == EditJobScreen.routeName) {
                final jobId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditJobScreen(
                      jobId != null
                          ? ctx.read<JobsManager>().findById(jobId)
                          : null,
                    );
                  },
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
