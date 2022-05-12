

import 'package:bloc/bloc.dart';
import 'package:injection_molding_machine_application/domain/usecases/login_usecase.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/login_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/login_state.dart';
import 'package:injection_molding_machine_application/presentation/widgets/global.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  LoginBloc(this._loginUseCase) : super(LoginInitState(false, false, false)){
    on<LoginEventToggleShow>(
      (event,emit)=> emit(LoginStateToggleShow(event.isShow))
    );
    on<LoginEventChecking>(onChecking);
    on<LoginEventLoginClicked>(onlogin);
  }
  void onChecking(LoginEvent event,Emitter<LoginState> emit){
    if(event is LoginEventChecking){
      bool passwordErr = event.passWord.length < 6;
      bool userErr = event.userName.length < 3;
      emit(LoginStateFormatChecking(passwordErr, userErr));
    }
  }
  Future<void> onlogin(LoginEvent event, Emitter<LoginState> emit) async{
    if(event is LoginEventLoginClicked){
      emit(LoginStateLoadingRequest(DateTime.now()));
      try{
        final res = await _loginUseCase.getToken(event.username, event.password);
        final dataUser = res;
        Global.token = res.token!.authToken.toString();
        return emit(LoginStateLoginSuccessful(dataUser));
      }catch(e){
        print(e);
      }
    }
  }
}
