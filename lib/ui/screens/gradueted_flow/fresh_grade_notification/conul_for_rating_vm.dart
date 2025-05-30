import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/Auth/domain/api_result.dart';

import '../domain/usecase/consul_for_rate_usecase.dart';
import '../rating/model/consul_rating.dart';

@injectable
class ConsultantsForRatingCubit extends Cubit<ConsultantsForRatingState> {
  final GetConsultantsForRatingUseCase getConsultantsForRatingUseCase;

  ConsultantsForRatingCubit(this.getConsultantsForRatingUseCase)
    : super(ConsultantsForRatingInitial());

  List<ConsultantForRating> consultants = [];
  ConsultantForRating? selectedConsultant; // استشاري مختار

  Future<void> fetchConsultants(int caseRequestId) async {
    if (isClosed) return;

    emit(ConsultantsForRatingLoading());

    final result = await getConsultantsForRatingUseCase(caseRequestId);

    if (isClosed) return;

    if (result is Success<List<ConsultantForRating>>) {
      consultants = result.data!;
      emit(ConsultantsForRatingLoaded(consultants));
    } else if (result is ServerFailure) {
      emit(
        ConsultantsForRatingError(
          (result as ServerFailure).message ?? "Unknown error",
        ),
      );
    } else {
      emit(ConsultantsForRatingError("Unexpected error"));
    }
  }

  void selectConsultant(ConsultantForRating consultant) {
    selectedConsultant = consultant;
    emit(
      ConsultantsForRatingLoaded(consultants),
    ); // لإعادة البناء وإظهار التحديد إذا أردت
  }
}

abstract class ConsultantsForRatingState {}

class ConsultantsForRatingInitial extends ConsultantsForRatingState {}

class ConsultantsForRatingLoading extends ConsultantsForRatingState {}

class ConsultantsForRatingLoaded extends ConsultantsForRatingState {
  final List<ConsultantForRating> consultants;

  ConsultantsForRatingLoaded(this.consultants);
}

class ConsultantsForRatingError extends ConsultantsForRatingState {
  final String message;

  ConsultantsForRatingError(this.message);
}
