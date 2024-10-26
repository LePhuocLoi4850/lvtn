// import 'package:chatbot/chat_bot.dart';
import 'package:chatbot/company_screen.dart';
import 'package:flutter/material.dart';
import 'user_screen.dart';
import 'ui/auth/update.dart';
import 'ui/company/search_user.dart';
import 'ui/job/admin/edit_user_screen.dart';
import 'ui/job/favorite_jobs.dart';
import 'ui/job/profile.dart';
import 'ui/job/search_app.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ui/screens.dart';
import 'ui/user/user_overview_screen.dart';
import 'ui/user/users_manager.dart';

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
        ChangeNotifierProxyProvider<AuthManager, UsersManager>(
          create: (ctx) => UsersManager(),
          update: (ctx, authManager, usersManager) {
            usersManager!.authToken = authManager.authToken;
            return usersManager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'Job',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light().copyWith(
              appBarTheme: const AppBarTheme(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            home: authManager.isAuth() == 'user'
                ? const MainScreen()
                : authManager.isAuth() == 'Admin'
                    ? const UserJobsScreen()
                    : authManager.isAuth() == 'company'
                        ? const CompanyScreen()
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
              // OrdersScreen.routeName: (ctx) => const OrdersScreen(),
              UserJobsScreen.routeName: (ctx) => const UserJobsScreen(),
              SearchJobsScreen.routeName: (ctx) => const SearchJobsScreen(),
              SearchUserScreen.routeName: (ctx) => const SearchUserScreen(),
              UpdateProfilePage.routeName: (ctx) =>
                  const UpdateProfilePage(userId: '', email: ''),
              ProfilePage.routeName: (ctx) => ProfilePage(),

              UsersOverviewScreen.routeName: (ctx) =>
                  const UsersOverviewScreen(),
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
              if (settings.name == EditUserScreen.routeName) {
                final userId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditUserScreen(
                      userId != null
                          ? ctx.read<UsersManager>().findById(userId)
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
