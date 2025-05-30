import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skillbridge_dentistry/ui/screens/consultant_flow/data/api/consultant_services.dart';
import 'model/cosult_level_model.dart';

@injectable
class LevelCubit extends Cubit<LevelState> {
  final ConsultantServices consultantServices;

  LevelCubit(this.consultantServices) : super(LevelInitial());

  Future<void> fetchLevels() async {
    emit(LevelLoading());
    try {
      final levels = await consultantServices.getConsultantLevels();
      emit(LevelLoaded(levels));
    } catch (e) {
      emit(LevelError(e.toString()));
    }
  }
}

abstract class LevelState {}

class LevelInitial extends LevelState {}

class LevelLoading extends LevelState {}

class LevelLoaded extends LevelState {
  final List<ConsultantLevel> levels;
  LevelLoaded(this.levels);
}

class LevelError extends LevelState {
  final String message;
  LevelError(this.message);
}
