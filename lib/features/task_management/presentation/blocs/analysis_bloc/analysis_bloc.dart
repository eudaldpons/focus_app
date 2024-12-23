import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pomodore/features/task_management/domain/entities/analysis_entity.dart";

import "../../../domain/usecases/get_analysis_usecase.dart";

part "analysis_event.dart";

part "analysis_state.dart";

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  final GetAnalysisUseCase getAnalysisUseCase;

  AnalysisBloc(this.getAnalysisUseCase) : super(AnalysisInitial()) {
    on<AnalysisEvent>((event, emit) {});
    on<AnalysisFetched>(_analysisFetched);
  }

  void _analysisFetched(AnalysisFetched event, Emitter emit) async {
    emit(FetchAnalysisLoading());

    final Either<String, AnalysisEntity> result =
        await getAnalysisUseCase.call();

    result.fold((l) => emit(FetchAnalysisFailure()),
        (r) => emit(FetchAnalysisSuccess(r)));
  }
}
