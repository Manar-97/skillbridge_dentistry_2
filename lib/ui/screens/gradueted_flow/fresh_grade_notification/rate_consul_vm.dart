// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:injectable/injectable.dart';
// import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';
//
// import '../domain/usecase/rate_consul_usecase.dart';
//
// @injectable
// class RatingCubit extends Cubit<RatingState> {
//   final RateConsultantUseCase rateConsultantUseCase;
//
//   RatingCubit(this.rateConsultantUseCase) : super(RatingInitial());
//
//   Future<void> rate(int caseRequestId, String consultantId, int rate) async {
//     if (isClosed) return;
//
//     emit(RatingLoading());
//
//     final result = await rateConsultantUseCase(
//       caseRequestId,
//       consultantId,
//       rate,
//     );
//
//     if (isClosed) return;
//
//     if (result is Success) {
//       emit(RatingSuccess());
//     } else if (result is ServerFailure) {
//       emit(RatingFailure((result).message ?? 'Unknown error'));
//     } else {
//       emit(RatingFailure('Unknown error'));
//     }
//   }
// }
//
// abstract class RatingState {}
//
// class RatingInitial extends RatingState {}
//
// class RatingLoading extends RatingState {}
//
// class RatingSuccess extends RatingState {}
//
// class RatingFailure extends RatingState {
//   final String message;
//
//   RatingFailure(this.message);
// }
