import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/UI/login.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/VM/login_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/forgetpassword/forgetpassword.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/resetpassword/resetpassword.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/verifycode/verifycode.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_camera/consul_accepted_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_camera/consul_case_description/consul_case_description.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_camera/consul_treate_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_notification/consul_notification.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/main_consul_screen.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/UI/consultant_register.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/VM/consultant_register_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/camera.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/case_description.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/not_found_treat_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/found_treate_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/home/home.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/notification/notification.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/register/UI/fresh_register.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/register/VM/fresh_register_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/splash_and_onboarding/onboarding/onboarding.dart';
import 'package:skillbridge_dentistry/ui/screens/splash_and_onboarding/persona/persona.dart';
import 'package:skillbridge_dentistry/ui/screens/splash_and_onboarding/splash/splash.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegisterConsultantCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<RegisterFreshGraduatedCubit>(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Inter',
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          SplashScreen.routeName: (_) => const SplashScreen(),
          OnboardingScreen.routeName: (_) => const OnboardingScreen(),
          PersonaScreen.routeName: (_) => const PersonaScreen(),
          ConsultantRegister.routeName: (_) => const ConsultantRegister(),
          FreshGraduatedRegister.routeName: (_) =>
              const FreshGraduatedRegister(),
          Login.routeName: (_) => const Login(),
          ForgotPassword.routeName: (_) => const ForgotPassword(),
          ResetPassword.routeName: (_) => const ResetPassword(),
          VerifyCode.routeName: (_) => const VerifyCode(),
          Home.routeName: (_) => const Home(),
          MainDentistScreen.routeName: (_) => const MainDentistScreen(),
          MainConsultantScreen.routeName: (_) => const MainConsultantScreen(),
          CameraCases.routeName: (_) => const CameraCases(),
          CaseDetails.routeName: (_) => const CaseDetails(),
          ConsultantAcceptedCaseDetails.routeName: (_) =>
              const ConsultantAcceptedCaseDetails(),
          FoundTreatCaseDetails.routeName: (_) => const FoundTreatCaseDetails(),
          NotFoundTreatCaseDetails.routeName: (_) =>
              const NotFoundTreatCaseDetails(),
          ConsultantTreatCaseDetails.routeName: (_) =>
              const ConsultantTreatCaseDetails(),
          CaseDescription.routeName: (_) => const CaseDescription(),
          ConsultantCaseDescription.routeName: (_) =>
              const ConsultantCaseDescription(),
          Notifications.routeName: (_) => const Notifications(),
          ConsultantNotifications.routeName: (_) =>
              const ConsultantNotifications(),
        },
        initialRoute: Login.routeName,
      ),
    );
  }
}
