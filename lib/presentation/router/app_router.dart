

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';
import 'package:injection_molding_machine_application/injector.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/login_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/machine_details_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/machine_management_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/send_condition_check.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/machine_details_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/machines_management_event.dart';
import 'package:injection_molding_machine_application/presentation/views/device_query_result_screen.dart';
import 'package:injection_molding_machine_application/presentation/views/login_screen.dart';
import 'package:injection_molding_machine_application/presentation/views/machine_details_screen.dart';
import 'package:injection_molding_machine_application/presentation/views/home_screen.dart';
import 'package:injection_molding_machine_application/presentation/views/send_condition_check_screen.dart';
import 'package:injection_molding_machine_application/presentation/views/supervision_Screen.dart';
import 'package:injection_molding_machine_application/presentation/widgets/global.dart';

class AppRouter {
  static NodeQueryResult nodeQueryResult =
      NodeQueryResult(connected: false, deviceQueryResults: [], eonNodeId: '');
  static NodeQueryResultModel nodeQueryResultModel = NodeQueryResultModel(
      eonNodeId: '', connected: false, deviceQueryResults: []);
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case 'loginView':
        return MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<LoginBloc>(
                      create: (context) => injector(),
                    ),
                    BlocProvider<MachineDetailsBloc>(
                        create: (context) => injector())
                  ],
                  child: LoginScreen(),
                ));
      case '/supervisionView':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<SendConditionCheckBloc>(
            create: (context) => injector(),
            child: SupervisionScreen(Global.machineId),
          ),
          );
      case '/SendConditionCheckScreen': return MaterialPageRoute(builder: (context)=> SendConditionCheckScreen());
      case '/DeviceQueryResultView':
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MachineDetailsBloc>(
            create: (context) => injector()
              ..add(MachineDetailsEventDataUpDated(
                  nodeQueryResultModel: NodeQueryResultModel(
                      connected: false,
                      deviceQueryResults: [],
                      eonNodeId: ''))),
            child: DeviceQueryResultView(),
          ),
        );
      case '/MachineDetailsScreen':
        return MaterialPageRoute(
            builder: (context) => BlocProvider<MachinesManagementBloc>(
                create: (context) =>
                    injector()..add(FetchDetailMachinesEvent()),
                child: MachineDetailsScreen(Global.deviceQueryResult)));
      default:
        return MaterialPageRoute(builder: (context) => HomeScreen());
    }
  }
}
