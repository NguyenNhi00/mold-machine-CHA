import 'package:bloc/bloc.dart';
import 'package:injection_molding_machine_application/domain/usecases/modify_machine_status_usecase.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/send_condition_check_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/send_condition_check_state.dart';
import 'package:injection_molding_machine_application/presentation/widgets/global.dart';

class SendConditionCheckBloc
    extends Bloc<SendConditionCheckEvent, SendConditionCheckState> {
  final ModifyMachineStatusUsecase modifyMachineStatusUsecase;
  SendConditionCheckBloc(this.modifyMachineStatusUsecase) : super(IntState()) {
    on<ConfirmSendConditionCheckevent>(sendConditionCheck);
  }
  Future<void> sendConditionCheck(SendConditionCheckEvent event,
      Emitter<SendConditionCheckState> emit) async {
    if (event is ConfirmSendConditionCheckevent) {
      await modifyMachineStatusUsecase
          .requestModifyStatusMachine(Global.supervision);
      return emit(SendConditionCheckDoneState());
    }
  }
}
