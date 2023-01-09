// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/get_presences_by_class_usecase.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/save_presence_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/events/presence_events.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/states/presence_states.dart';

class PresenceBloc extends Bloc<PresenceEvents, PresenceStates> {
  final ISavePresenceUseCase savePresenceUseCase;
  final IGetPresencesByClassUseCase getPresencesByClassUseCase;

  PresenceBloc({
    required this.savePresenceUseCase,
    required this.getPresencesByClassUseCase,
  }) : super(InitialPresence()) {
    on<SavePresenceEvent>(_savePresence);
    on<GetPresenceByClassEvent>(_getPresenceByClassAndDay);
  }

  Future _savePresence(SavePresenceEvent event, emit) async {
    emit(LoadingPresence());

    final result = await savePresenceUseCase(event.presence);

    result.fold(
      (success) => emit(SuccessSavePresence()),
      (failure) => emit(ErrorPresence(message: failure.message)),
    );
  }

  Future _getPresenceByClassAndDay(GetPresenceByClassEvent event, emit) async {
    emit(LoadingPresence());

    final result = await getPresencesByClassUseCase(event.pClass);

    result.fold(
      (success) => emit(SuccessGetPresenceByClass(presences: success)),
      (failure) => emit(ErrorPresence(message: failure.message)),
    );
  }
}
