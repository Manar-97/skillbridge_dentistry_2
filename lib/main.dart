import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/UI/login.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/login/VM/login_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/forgetpassword/forgetpassword.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/forgetpassword/forgetpassword_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/resetpassword/resetpassword.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/resetpassword/resetpassword_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/verifycode/verifycode.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/presentation/paswword/verifycode/verifycode_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_camera/consul_accepted_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_camera/consul_case_description/consul_case_description.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_camera/consul_treate_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_notification/consul_notification.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_profile/consul_profile_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/main_consul_screen.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/UI/consultant_register.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/VM/consultant_register_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/camera.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/camera_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/case_description.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/not_found_treat_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/found_treate_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/home/home.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/profile/profile_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/register/UI/fresh_register.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/register/VM/fresh_register_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/notification.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/notification_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/response_case_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/notification/user_vm.dart';
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
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<RegisterConsultantCubit>()),
        BlocProvider(create: (context) => getIt<RegisterFreshGraduatedCubit>()),
        BlocProvider(create: (context) => getIt<ForgetPasswordCubit>()),
        BlocProvider(create: (context) => getIt<ResetPasswordCubit>()),
        BlocProvider(create: (context) => getIt<VerifyOtpCubit>()),
        BlocProvider(create: (context) => getIt<ProfileCubit>()),
        BlocProvider(create: (context) => getIt<ConsultantProfileCubit>()),
        BlocProvider(create: (context) => getIt<UploadCaseCubit>()),
        BlocProvider(create: (context) => getIt<NotificationsCubit>()),
        BlocProvider(create: (context) => getIt<RespondToCaseCubit>()),
        // BlocProvider(create: (context) => getIt<UserCubit>()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        debugShowCheckedModeBanner: false,
        initialRoute: Login.routeName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case SplashScreen.routeName:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
            case OnboardingScreen.routeName:
              return MaterialPageRoute(
                builder: (_) => const OnboardingScreen(),
              );
            case PersonaScreen.routeName:
              return MaterialPageRoute(builder: (_) => const PersonaScreen());
            case ConsultantRegister.routeName:
              return MaterialPageRoute(
                builder: (_) => const ConsultantRegister(),
              );
            case FreshGraduatedRegister.routeName:
              return MaterialPageRoute(
                builder: (_) => const FreshGraduatedRegister(),
              );
            case Login.routeName:
              return MaterialPageRoute(builder: (_) => const Login());
            case ForgotPassword.routeName:
              return MaterialPageRoute(builder: (_) => const ForgotPassword());
            case ResetPassword.routeName:
              final args = settings.arguments;
              if (args is Map<String, dynamic>) {
                final email = args['email'] as String? ?? '';
                final otpCode = args['otpCode'] as String? ?? '';
                return MaterialPageRoute(
                  builder: (_) => ResetPassword(email: email, otpCode: otpCode),
                );
              }
              // في حال عدم وجود arguments أو كانت غير صحيحة
              return MaterialPageRoute(
                builder: (_) => const ResetPassword(email: '', otpCode: ''),
              );
            case VerifyCode.routeName:
              final email = settings.arguments as String?;
              if (email == null) {
                return MaterialPageRoute(
                  builder: (_) => const VerifyCode(email: ''),
                );
              }
              return MaterialPageRoute(
                builder: (_) => VerifyCode(email: email),
              );
            case Home.routeName:
              return MaterialPageRoute(builder: (_) => Home());
            case MainDentistScreen.routeName:
              return MaterialPageRoute(builder: (_) => MainDentistScreen());
            case MainConsultantScreen.routeName:
              return MaterialPageRoute(builder: (_) => MainConsultantScreen());
            case CameraCases.routeName:
              return MaterialPageRoute(builder: (_) => const CameraCases());
            case CaseDetails.routeName:
              return MaterialPageRoute(builder: (_) => const CaseDetails());
            case ConsultantAcceptedCaseDetails.routeName:
              return MaterialPageRoute(
                builder: (_) => const ConsultantAcceptedCaseDetails(),
              );
            case FoundTreatCaseDetails.routeName:
              final args = settings.arguments as Map<String, dynamic>?;
              final treatment = args?['treatment'] as String? ?? '';
              final imageFile = args?['imageFile'] as File?;
              if (imageFile == null) {
                return MaterialPageRoute(
                  builder:
                      (_) => const Scaffold(
                        body: Center(child: Text('No image provided')),
                      ),
                );
              }
              return MaterialPageRoute(
                builder:
                    (_) => FoundTreatCaseDetails(
                      imageFile: imageFile,
                      treatment: treatment,
                    ),
              );
            case NotFoundTreatCaseDetails.routeName:
              return MaterialPageRoute(
                builder: (_) => const NotFoundTreatCaseDetails(),
              );
            case ConsultantTreatCaseDetails.routeName:
              return MaterialPageRoute(
                builder: (_) => const ConsultantTreatCaseDetails(),
              );
            case CaseDescription.routeName:
              final args = settings.arguments as Map<String, dynamic>?;
              final imageFile = args?['imageFile'] as File?;
              if (imageFile == null) {
                return MaterialPageRoute(
                  builder:
                      (_) => const Scaffold(
                        body: Center(child: Text('No image provided')),
                      ),
                );
              }
              return MaterialPageRoute(
                builder: (_) => CaseDescription(imageFile: imageFile),
              );
            case ConsultantCaseDescription.routeName:
              return MaterialPageRoute(
                builder: (_) => const ConsultantCaseDescription(),
              );
            case Notifications.routeName:
              return MaterialPageRoute(builder: (_) => const Notifications());
            case ConsultantNotifications.routeName:
              return MaterialPageRoute(
                builder: (_) => const ConsultantNotifications(),
              );
            default:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
          }
        },
      ),
    );
  }
}
