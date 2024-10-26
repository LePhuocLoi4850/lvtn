import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import '/ui/candidate/candidate_overview_screen.dart';
import '/ui/company/company_overview_screen.dart';
import './ui/screens.dart';
import 'ui/job/edit_job_screen.dart';
import 'ui/splash_screen.dart';

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
          create: (ctx) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, JobManager>(
          create: (ctx) => JobManager(),
          update: (ctx, authManager, productsManager) {
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          },
        ),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'MyShop',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              scaffoldBackgroundColor:
                  Colors.white, // Set scaffold background color to white
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch:
                    Colors.blue, // You can specify primarySwatch if needed
              ).copyWith(
                secondary: Colors.white,
              ),
            ),
            home: authManager.isAuth
                ? const JobOverviewScreen()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SplashScreen()
                          : const AuthScreen();
                    },
                  ),
            routes: {
              CompanyOverviewScreen.routeName: (context) =>
                  const CompanyOverviewScreen(),
              CandidateOverviewScreen.routeName: (context) =>
                  const CandidateOverviewScreen(),
              UserJobScreen.routeName: (context) => const UserJobScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == JobDetailPage.routeName) {
                final jobId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return JobDetailPage(
                      ctx.read<JobManager>().findById(jobId),
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
                          ? ctx.read<JobManager>().findById(jobId)
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
