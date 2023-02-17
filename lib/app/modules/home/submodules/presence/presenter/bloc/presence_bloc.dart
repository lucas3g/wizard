// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/get_presences_by_class_and_date.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/get_presences_by_class_usecase.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/save_presence_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/events/presence_events.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/states/presence_states.dart';

class PresenceBloc extends Bloc<PresenceEvents, PresenceStates> {
  final ISavePresenceUseCase savePresenceUseCase;
  final IGetPresencesByClassUseCase getPresencesByClassUseCase;
  final IGetPresencesByClassAndDateUseCase getPresencesByClassAndDateUseCase;

  PresenceBloc({
    required this.savePresenceUseCase,
    required this.getPresencesByClassUseCase,
    required this.getPresencesByClassAndDateUseCase,
  }) : super(InitialPresence()) {
    on<SavePresenceEvent>(_savePresence);
    on<GetPresenceByClassEvent>(_getPresenceByClass);
    on<GetPresenceByClassAndDateEvent>(_getPresenceByClassAndDate);
  }

  Future _savePresence(SavePresenceEvent event, emit) async {
    emit(LoadingPresence());

    final result = await savePresenceUseCase(event.presence);

    result.fold(
      (success) => emit(SuccessSavePresence()),
      (failure) => emit(ErrorPresence(message: failure.message)),
    );
  }

  Future _getPresenceByClass(GetPresenceByClassEvent event, emit) async {
    emit(LoadingPresence());

    final result = await getPresencesByClassUseCase(event.pClass);

    result.fold(
      (success) => emit(SuccessGetPresenceByClass(presences: success)),
      (failure) => emit(ErrorPresence(message: failure.message)),
    );
  }

  Future _getPresenceByClassAndDate(
      GetPresenceByClassAndDateEvent event, emit) async {
    emit(LoadingPresence());

    final result =
        await getPresencesByClassAndDateUseCase(event.pClass, event.date);

    result.fold(
      (success) => emit(SuccessGetPresenceByClass(presences: success)),
      (failure) => emit(ErrorPresence(message: failure.message)),
    );
  }
}
