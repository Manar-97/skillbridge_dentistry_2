// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/data/model/request/register_request.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/domain/repositories/auth_repo.dart';
// import 'consultant_cubit_state.dart';
//
// @injectable
// class ConsultantCubit extends Cubit<ConsultantCubitState> {
//   final AuthRepository authRepository;
//
//   ConsultantCubit(this.authRepository) : super(ConsultantInitial());
//
//   Future<void> registerConsultant(ConsultantRegisterRequest consultant) async {
//     emit(ConsultantLoading());
//     try {
//       final response = await authRepository.consultantRegister(consultant);
//
//       // استخدام fold بشكل صحيح لمعالجة النجاح والفشل
//       response.fold(
//             (failure) {
//           // التعامل مع الفشل
//           emit(ConsultantError(failure.errorMessage));
//         },
//             (response) {
//           // التعامل مع النجاح
//           emit(ConsultantSuccess());
//         },
//       );
//     } catch (e) {
//       // في حال حدوث خطأ غير متوقع
//       emit(ConsultantError("An unexpected error occurred: ${e.toString()}"));
//     }
//   }
// }
