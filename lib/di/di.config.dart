// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i973;

import '../ui/screens/Auth/data/api/api_services.dart' as _i766;
import '../ui/screens/Auth/data/api/api_services_impl.dart' as _i578;
import '../ui/screens/Auth/data/repositories/auth_ds/auth_ds.dart' as _i226;
import '../ui/screens/Auth/data/repositories/auth_ds/auth_offline_ds_impl.dart'
    as _i913;
import '../ui/screens/Auth/data/repositories/auth_ds/auth_online_ds_impl.dart'
    as _i457;
import '../ui/screens/Auth/data/repositories/auth_repo_impl.dart' as _i942;
import '../ui/screens/Auth/domain/repositories/auth_repo.dart' as _i285;
import '../ui/screens/Auth/domain/usecase/forget_pass_usecase.dart' as _i542;
import '../ui/screens/Auth/domain/usecase/login_usecase.dart' as _i732;
import '../ui/screens/Auth/domain/usecase/register_consultant_usecase.dart'
    as _i568;
import '../ui/screens/Auth/domain/usecase/register_fresh_usecase.dart'
    as _i1055;
import '../ui/screens/Auth/domain/usecase/reset_pass_usecase.dart' as _i735;
import '../ui/screens/Auth/domain/usecase/verifycode_usecase.dart' as _i658;
import '../ui/screens/Auth/presentation/login/VM/login_vm.dart' as _i637;
import '../ui/screens/Auth/presentation/paswword/forgetpassword/forgetpassword_vm.dart'
    as _i113;
import '../ui/screens/Auth/presentation/paswword/resetpassword/resetpassword_vm.dart'
    as _i971;
import '../ui/screens/Auth/presentation/paswword/verifycode/verifycode_vm.dart'
    as _i991;
import '../ui/screens/consultant_flow/consul_profile/consul_profile_vm.dart'
    as _i894;
import '../ui/screens/consultant_flow/consultant_notification/case_consultant_vm.dart'
    as _i350;
import '../ui/screens/consultant_flow/consultant_notification/data/api/notifications_services.dart'
    as _i730;
import '../ui/screens/consultant_flow/consultant_notification/data/api/notifications_services_impl.dart'
    as _i989;
import '../ui/screens/consultant_flow/consultant_notification/data/repositories/notifications_ds/notifications_ds.dart'
    as _i214;
import '../ui/screens/consultant_flow/consultant_notification/data/repositories/notifications_ds/notifications_online_ds.dart'
    as _i626;
import '../ui/screens/consultant_flow/consultant_notification/data/repositories/notifications_repo_impl.dart'
    as _i336;
import '../ui/screens/consultant_flow/consultant_notification/domain/repositories/notifications_repo.dart'
    as _i555;
import '../ui/screens/consultant_flow/consultant_notification/domain/usecase/delete_notifications_usecase.dart'
    as _i75;
import '../ui/screens/consultant_flow/consultant_notification/domain/usecase/get_all_notifications_usecase.dart'
    as _i1063;
import '../ui/screens/consultant_flow/consultant_notification/domain/usecase/get_unread_count_usecase.dart'
    as _i439;
import '../ui/screens/consultant_flow/consultant_notification/domain/usecase/mark_all_as_read_usecase.dart'
    as _i923;
import '../ui/screens/consultant_flow/consultant_notification/domain/usecase/mark_as_read_usecase.dart'
    as _i471;
import '../ui/screens/consultant_flow/consultant_notification/notification_vm.dart'
    as _i1073;
import '../ui/screens/consultant_flow/consultant_notification/response_to_case_vm.dart'
    as _i1003;
import '../ui/screens/consultant_flow/data/api/consultant_services.dart'
    as _i295;
import '../ui/screens/consultant_flow/data/api/consultant_services_impl.dart'
    as _i1012;
import '../ui/screens/consultant_flow/data/repositories/response_case_ds/response_case_ds.dart'
    as _i18;
import '../ui/screens/consultant_flow/data/repositories/response_case_ds/response_case_online_ds_impl.dart'
    as _i498;
import '../ui/screens/consultant_flow/data/repositories/response_case_repo_impl.dart'
    as _i622;
import '../ui/screens/consultant_flow/domain/repositories/response_case_repo.dart'
    as _i625;
import '../ui/screens/consultant_flow/domain/usecase/get_cosultantId_usecase.dart'
    as _i746;
import '../ui/screens/consultant_flow/domain/usecase/response_to_case_usecase.dart'
    as _i470;
import '../ui/screens/consultant_flow/level/level_vm.dart' as _i702;
import '../ui/screens/consultant_flow/register/VM/consultant_register_vm.dart'
    as _i812;
import '../ui/screens/gradueted_flow/camera/camera_vm.dart' as _i505;
import '../ui/screens/gradueted_flow/data/api/graduated_services.dart' as _i137;
import '../ui/screens/gradueted_flow/data/api/graduated_services_impl.dart'
    as _i357;
import '../ui/screens/gradueted_flow/data/repositories/case_ds/case_ds.dart'
    as _i765;
import '../ui/screens/gradueted_flow/data/repositories/case_ds/case_offline_ds_impl.dart'
    as _i80;
import '../ui/screens/gradueted_flow/data/repositories/case_ds/case_online_ds_impl.dart'
    as _i893;
import '../ui/screens/gradueted_flow/data/repositories/case_repo_impl.dart'
    as _i172;
import '../ui/screens/gradueted_flow/domain/repositories/case_repo.dart'
    as _i60;
import '../ui/screens/gradueted_flow/domain/usecase/get_case_resonse_usecase.dart'
    as _i639;
import '../ui/screens/gradueted_flow/domain/usecase/get_upload_case_usecase.dart'
    as _i727;
import '../ui/screens/gradueted_flow/domain/usecase/save_case_usecase.dart'
    as _i726;
import '../ui/screens/gradueted_flow/domain/usecase/upload_case_usecase.dart'
    as _i866;
import '../ui/screens/gradueted_flow/fresh_grade_notification/case_response_vm.dart'
    as _i683;
import '../ui/screens/gradueted_flow/fresh_grade_notification/fresh_notification_vm.dart'
    as _i816;
import '../ui/screens/gradueted_flow/profile/profile_vm.dart' as _i447;
import '../ui/screens/gradueted_flow/rating/rate_vm.dart' as _i812;
import '../ui/screens/gradueted_flow/register/VM/fresh_register_vm.dart'
    as _i205;
import 'modules/network_modul.dart' as _i680;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final networkModules = _$NetworkModules();
    gh.lazySingleton<_i973.InternetConnectionChecker>(
      () => networkModules.getInternetConnectionChecker(),
    );
    gh.lazySingleton<_i361.Dio>(() => networkModules.getDio());
    gh.factory<_i765.CaseOfflineDS>(() => _i80.CaseOfflineDSImpl());
    gh.factory<_i137.GraduatedServices>(
      () => _i357.GraduatedServicesImpl(
        gh<_i361.Dio>(),
        gh<_i765.CaseOfflineDS>(),
      ),
    );
    gh.factory<_i226.AuthOfflineDS>(() => _i913.AuthOfflineDSImpl());
    gh.factory<_i730.NotificationsServices>(
      () => _i989.NotificationsServicesImpl(gh<_i361.Dio>()),
    );
    gh.factory<_i295.ConsultantServices>(
      () => _i1012.ConsultantServicesImpl(
        gh<_i361.Dio>(),
        gh<_i765.CaseOfflineDS>(),
      ),
    );
    gh.factory<_i727.GetUploadedCaseUseCase>(
      () => _i727.GetUploadedCaseUseCase(gh<_i765.CaseOfflineDS>()),
    );
    gh.factory<_i726.SaveUploadedCaseUseCase>(
      () => _i726.SaveUploadedCaseUseCase(gh<_i765.CaseOfflineDS>()),
    );
    gh.factory<_i812.RatingCubit>(
      () => _i812.RatingCubit(gh<_i137.GraduatedServices>()),
    );
    gh.factory<_i765.CaseOnlineDS>(
      () => _i893.CaseOnlineDSImpl(gh<_i137.GraduatedServices>()),
    );
    gh.factory<_i18.ResponseCaseOnlineDS>(
      () => _i498.ResponseCaseOnlineDSImpl(gh<_i295.ConsultantServices>()),
    );
    gh.factory<_i702.LevelCubit>(
      () => _i702.LevelCubit(gh<_i295.ConsultantServices>()),
    );
    gh.factory<_i60.CaseRepository>(
      () => _i172.CaseRepositoryImpl(gh<_i765.CaseOnlineDS>()),
    );
    gh.factory<_i766.ApiServices>(
      () => _i578.ApiServicesImpl(gh<_i361.Dio>(), gh<_i226.AuthOfflineDS>()),
    );
    gh.factory<_i214.NotificationsOnlineDS>(
      () => _i626.NotificationsOnlineDSImpl(gh<_i730.NotificationsServices>()),
    );
    gh.factory<_i625.ResponseCaseRepository>(
      () => _i622.ResponseCaseRepositoryImpl(gh<_i18.ResponseCaseOnlineDS>()),
    );
    gh.factory<_i226.AuthOnlineDS>(
      () => _i457.AuthOnlineDSImpl(gh<_i766.ApiServices>()),
    );
    gh.factory<_i639.GetCaseResponsesUseCase>(
      () => _i639.GetCaseResponsesUseCase(gh<_i60.CaseRepository>()),
    );
    gh.factory<_i866.UploadCaseUseCase>(
      () => _i866.UploadCaseUseCase(gh<_i60.CaseRepository>()),
    );
    gh.factory<_i555.NotificationsRepositories>(
      () => _i336.NotificationsRepositoriesImpl(
        gh<_i214.NotificationsOnlineDS>(),
      ),
    );
    gh.factory<_i505.UploadCaseCubit>(
      () => _i505.UploadCaseCubit(gh<_i866.UploadCaseUseCase>()),
    );
    gh.factory<_i683.CaseResponseCubit>(
      () => _i683.CaseResponseCubit(gh<_i639.GetCaseResponsesUseCase>()),
    );
    gh.factory<_i816.FreshGraduatedNotificationCubit>(
      () => _i816.FreshGraduatedNotificationCubit(
        gh<_i639.GetCaseResponsesUseCase>(),
      ),
    );
    gh.factory<_i746.GetCaseConsultantDataUseCase>(
      () => _i746.GetCaseConsultantDataUseCase(
        gh<_i625.ResponseCaseRepository>(),
      ),
    );
    gh.factory<_i470.RespondToCaseUseCase>(
      () => _i470.RespondToCaseUseCase(gh<_i625.ResponseCaseRepository>()),
    );
    gh.factory<_i894.ConsultantProfileCubit>(
      () => _i894.ConsultantProfileCubit(gh<_i226.AuthOnlineDS>()),
    );
    gh.factory<_i447.ProfileCubit>(
      () => _i447.ProfileCubit(gh<_i226.AuthOnlineDS>()),
    );
    gh.factory<_i285.AuthRepository>(
      () => _i942.AuthRepositoryImpl(
        gh<_i226.AuthOnlineDS>(),
        gh<_i226.AuthOfflineDS>(),
      ),
    );
    gh.factory<_i542.ForgetPasswordUseCase>(
      () => _i542.ForgetPasswordUseCase(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i732.LoginUseCase>(
      () => _i732.LoginUseCase(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i735.ResetPasswordUseCase>(
      () => _i735.ResetPasswordUseCase(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i658.VerifyOtpUseCase>(
      () => _i658.VerifyOtpUseCase(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i113.ForgetPasswordCubit>(
      () => _i113.ForgetPasswordCubit(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i971.ResetPasswordCubit>(
      () => _i971.ResetPasswordCubit(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i991.VerifyOtpCubit>(
      () => _i991.VerifyOtpCubit(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i1003.RespondToCaseCubit>(
      () => _i1003.RespondToCaseCubit(gh<_i470.RespondToCaseUseCase>()),
    );
    gh.factory<_i568.RegisterConsultantUseCase>(
      () => _i568.RegisterConsultantUseCase(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i1055.RegisterFreshGraduatedUseCase>(
      () => _i1055.RegisterFreshGraduatedUseCase(gh<_i285.AuthRepository>()),
    );
    gh.factory<_i350.CaseConsultantCubit>(
      () => _i350.CaseConsultantCubit(gh<_i746.GetCaseConsultantDataUseCase>()),
    );
    gh.factory<_i637.LoginCubit>(
      () =>
          _i637.LoginCubit(gh<_i732.LoginUseCase>(), gh<_i226.AuthOfflineDS>()),
    );
    gh.factory<_i75.DeleteNotificationUseCase>(
      () =>
          _i75.DeleteNotificationUseCase(gh<_i555.NotificationsRepositories>()),
    );
    gh.factory<_i1063.GetAllNotificationsUseCase>(
      () => _i1063.GetAllNotificationsUseCase(
        gh<_i555.NotificationsRepositories>(),
      ),
    );
    gh.factory<_i439.GetUnreadCountUseCase>(
      () => _i439.GetUnreadCountUseCase(gh<_i555.NotificationsRepositories>()),
    );
    gh.factory<_i923.MarkAllAsReadUseCase>(
      () => _i923.MarkAllAsReadUseCase(gh<_i555.NotificationsRepositories>()),
    );
    gh.factory<_i471.MarkAsReadUseCase>(
      () => _i471.MarkAsReadUseCase(gh<_i555.NotificationsRepositories>()),
    );
    gh.factory<_i812.RegisterConsultantCubit>(
      () =>
          _i812.RegisterConsultantCubit(gh<_i568.RegisterConsultantUseCase>()),
    );
    gh.factory<_i1073.NotificationsCubit>(
      () => _i1073.NotificationsCubit(
        getAllNotificationsUseCase: gh<_i1063.GetAllNotificationsUseCase>(),
        getUnreadCountUseCase: gh<_i439.GetUnreadCountUseCase>(),
        markAllAsReadUseCase: gh<_i923.MarkAllAsReadUseCase>(),
        markAsReadUseCase: gh<_i471.MarkAsReadUseCase>(),
        deleteNotificationUseCase: gh<_i75.DeleteNotificationUseCase>(),
      ),
    );
    gh.factory<_i205.RegisterFreshGraduatedCubit>(
      () => _i205.RegisterFreshGraduatedCubit(
        gh<_i1055.RegisterFreshGraduatedUseCase>(),
      ),
    );
    return this;
  }
}

class _$NetworkModules extends _i680.NetworkModules {}
