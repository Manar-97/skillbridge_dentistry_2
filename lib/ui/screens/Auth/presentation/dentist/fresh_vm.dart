// import 'package:either_dart/either.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/register_request.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/domain/repositories/auth_repo.dart';
// import '../../../../base/failures/failures.dart';
// import 'fresh_cubit_state.dart';
//
// @injectable
// class FreshGraduatedCubit extends Cubit<FreshGraduatedCubitState> {
//   final AuthRepository authRepository;
//   FreshGraduatedCubit(this.authRepository) : super(FreshGraduatedInitial());
//
//   Future<void> registerFreshGraduated(
//       FreshGraduateRegisterRequest graduate) async {
//     emit(FreshGraduatedLoading());
//     Either<Failures, void> response =
//         await authRepository.freshRegister(graduate);
//     response.fold(
//       (failure) {
//         String message = "Unknown error";
//         if (failure is ConnectionFailures) {
//           message = "No internet connection.";
//         } else if (failure is ApiFailures) {
//           message = failure.errorMessage;
//         }
//         emit(FreshGraduatedError(message));
//       },
//       (_) => emit(FreshGraduatedSuccess()),
//     );
//   }
// }
