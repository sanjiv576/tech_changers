import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/register_view.dart';
import '../../features/home/presentation/view/dashboard/home_view.dart';
import '../../features/home/presentation/view/dashboard/profile_view.dart';
import '../../features/home/presentation/view/dashboard/routine_view.dart';
import '../../features/home/presentation/view/dashboard_view.dart';
import '../../features/home/presentation/view/supplier_dashboard_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';

class AppRoutes {
  static const String splashRoute = '/splash';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String homeRoute = '/home';
  static const String routineRoute = '/routine';
  static const String profileRoute = '/profile';
  static const String supplierRoute = '/supplierDashboard';

  static getApplicationRoutes() {
    return {
      splashRoute: (context) => const SplashView(),
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      dashboardRoute: (context) => const DashboardView(),
      homeRoute: (context) => const HomeView(),
      profileRoute: (context) => const ProfileView(),
      routineRoute: (context) => const RoutineView(),
      supplierRoute: (context) => const SupplierDashboardView(),
    };
  }
}
