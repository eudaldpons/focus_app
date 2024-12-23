
import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:pomodore/core/resources/params/settings_params.dart";
import "package:pomodore/features/configuration/domain/entities/settings_entity.dart";
import "package:pomodore/features/configuration/domain/usecases/change_theme_usecase.dart";

import "../../../../../core/resources/params/theme_params.dart";
import "../../../domain/usecases/change_locale_usecase.dart";
import "../../../domain/usecases/change_settings_usecase.dart";
import "../../../domain/usecases/get_locale_usecase.dart";
import "../../../domain/usecases/get_settings_usecase.dart";
import "../../../domain/usecases/get_theme_usecase.dart";

part "settings_event.dart";

part "settings_state.dart";

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingUseCase;
  final ChangeSettingsUseCase changeSettingsUseCase;
  final ChangeLocaleUseCase changeLocaleUseCase;
  final GetLocaleUseCase getLocaleUseCase;
  final GetThemeUseCase getThemeUseCase;
  final ChangeThemeUseCase changeThemeUseCase;

  SettingsBloc({
    required this.getSettingUseCase,
    required this.changeSettingsUseCase,
    required this.changeLocaleUseCase,
    required this.getLocaleUseCase,
    required this.getThemeUseCase,
    required this.changeThemeUseCase,
  }) : super(SettingsInitial()) {
    on<SettingsEvent>((event, emit) {});
    on<InitDataFetched>(_localeFetched);
    on<SettingsFromDeviceFetched>(_settingsFromDeviceFetched);
    on<SettingsChanged>(_settingsChanged);
    on<LocaleChanged>(_languageChanged);
    on<ThemeChanged>(_themeChanged);
  }

  void _themeChanged(ThemeChanged event, Emitter emit) async {
    emit(ChangeThemeLoading());
    final Either<String, ThemeData>? theme =
        await changeThemeUseCase.call(params: event.themeParams);

    if (theme != null) {
      theme.fold(
        (l) => emit(ChangeThemeFailure()),
        (r) => emit(ChangeThemeSuccess(r)),
      );
    } else {
      emit(ChangeThemeFailure());
    }
  }

  void _localeFetched(InitDataFetched event, Emitter emit) async {
    final Either<String, String> result = await getLocaleUseCase.call();
    final Either<String, ThemeData> themeResult = await getThemeUseCase.call();
    result.fold((l) => emit(InitDataFetchFailure()), (r) {
      themeResult.fold(
        (l) => emit(InitDataFetchFailure()),
        (theme) => emit(
          InitDataFetchSuccess(locale: Locale(r), themeData: theme),
        ),
      );
    });
  }

  void _settingsChanged(SettingsChanged event, Emitter emit) async {
    emit(SettingFetchingLoading());
    final Either<String, SettingsEntity> result =
        await changeSettingsUseCase.call(params: event.params);
    result.fold(
      (l) => emit(SettingFetchingFail()),
      (r) => emit(SettingFetchingSuccess(r)),
    );
  }

  void _settingsFromDeviceFetched(
      SettingsFromDeviceFetched event, Emitter emit) async {
    emit(SettingFetchingLoading());

    final Either<String, SettingsEntity> result = await getSettingUseCase.call();

    result.fold(
      (l) => emit(SettingFetchingFail()),
      (r) => emit(SettingFetchingSuccess(r)),
    );
  }

  void _languageChanged(LocaleChanged event, Emitter emit) async {
    await changeLocaleUseCase.call(params: event.local);
    emit(ChangeLanguageSuccess(Locale(event.local)));
  }
}
