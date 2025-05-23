import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../data/api/graduated_services.dart';
import 'model/consul_rating.dart';

@injectable
class RatingCubit extends Cubit<RatingState> {
  final GraduatedServices repository;

  RatingCubit(this.repository) : super(RatingInitial());

  Future<void> fetchConsultants(int caseRequestId) async {
    emit(RatingLoading());
    try {
      final consultants = await repository.getConsultantsForRating(
        caseRequestId,
      );
      emit(
        RatingLoaded(consultants),
      ); // consultants هنا List<ConsultantForRating>
    } catch (e) {
      emit(RatingError(e.toString()));
    }
  }

  Future<void> submitRating(
      int caseRequestId,
      String consultantId,
      int rate,
      ) async {
    emit(RatingSubmitting());
    try {
      await repository.rateConsultant(caseRequestId, consultantId, rate);
      emit(RatingSubmitted());
    } catch (e) {
      emit(RatingError(e.toString()));
    }
  }

}

abstract class RatingState {}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingLoaded extends RatingState {
  final List<ConsultantForRating> consultants;
  RatingLoaded(this.consultants);
}

class RatingSubmitting extends RatingState {}

class RatingSubmitted extends RatingState {}

class RatingError extends RatingState {
  final String message;
  RatingError(this.message);
}
