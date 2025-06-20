import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
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
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consul_profile/consul_profile_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/case_consultant_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/notification.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/notification_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/consultant_notification/response_to_case_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/level/level_screen.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/level/level_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/main_consul_screen.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/UI/consultant_register.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/register/VM/consultant_register_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/camera.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/camera_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/case_description.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/case_disease.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_description/not_found_treat_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/camera/found_treate_case_details.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/data/model/upload_case_response.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/fresh_grade_notification/conul_for_rating_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/fresh_grade_notification/fresh_notification.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/fresh_grade_notification/fresh_notification_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/home/home.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/mains_dentist_creen.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/profile/profile_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/rating/rate_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/register/UI/fresh_register.dart';
import 'package:skillbridge_dentistry/ui/screens/gradueted_flow/register/VM/fresh_register_vm.dart';
import 'package:skillbridge_dentistry/ui/screens/splash_and_onboarding/onboarding/onboarding.dart';
import 'package:skillbridge_dentistry/ui/screens/splash_and_onboarding/persona/persona.dart';
import 'package:skillbridge_dentistry/ui/screens/splash_and_onboarding/splash/splash.dart';
import 'di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UploadCaseResponseAdapter());

  await Hive.openBox<UploadCaseResponse>('upload_case_response');
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
        BlocProvider(create: (context) => getIt<RatingCubit>()),
        BlocProvider(create: (context) => getIt<LevelCubit>()),
        BlocProvider(create: (context) => getIt<CaseConsultantCubit>()),
        BlocProvider(
          create: (context) => getIt<FreshGraduatedNotificationCubit>(),
        ),
        BlocProvider(create: (context) => getIt<ConsultantsForRatingCubit>()),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Inter'),
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
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
            case ResponseToCase.routeName:
              return MaterialPageRoute(builder: (_) => const ResponseToCase());
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
            case ConsultantNotifications.routeName:
              return MaterialPageRoute(
                builder: (_) => const ConsultantNotifications(),
              );
            case ConsultantLevelScreen.routeName:
              return MaterialPageRoute(
                builder: (_) => const ConsultantLevelScreen(),
              );
            case FreshGraduatedNotification.routeName:
              return MaterialPageRoute(
                builder: (_) => FreshGraduatedNotification(),
              );
            case CaseDisease.routeName:
              return MaterialPageRoute(
                builder: (_) => CaseDisease(),
              );
            default:
              return MaterialPageRoute(builder: (_) => const SplashScreen());
          }
        },
      ),
    );
  }
}
