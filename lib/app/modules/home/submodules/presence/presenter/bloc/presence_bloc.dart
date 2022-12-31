// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/save_presence_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/events/presence_events.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/states/presence_states.dart';

class PresenceBloc extends Bloc<PresenceEvents, PresenceStates> {
  final ISavePresenceUseCase savePresenceUseCase;

  PresenceBloc({
    required this.savePresenceUseCase,
  }) : super(InitialPresence()) {
    on<SavePresenceEvent>(_savePresence);
  }

  Future _savePresence(SavePresenceEvent event, emit) async {
    emit(LoadingPresence());

    final result = await savePresenceUseCase(event.presence);

    result.fold(
      (success) => emit(SuccessSavePresence()),
      (failure) => emit(ErrorPresence(message: failure.message)),
    );
  }
}
