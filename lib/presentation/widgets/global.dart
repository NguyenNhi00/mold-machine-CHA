
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';
import 'package:injection_molding_machine_application/domain/entities/supervision.dart';
class Global {
  static String machineId = '';
  static String token = '';
  static int id = 0;
  static int machineLengh = 0;
  static int machineindex = 0;
  static String moldId = '';
  static int currentProductNumber = 0;
  static DeviceQueryResult deviceQueryResult = DeviceQueryResult(deviceId: 'deviceId', connected: false, tagQueryResults: []);
  static NodeQueryResultModel nodeQueryResultModel = NodeQueryResultModel(eonNodeId: '', connected: false, deviceQueryResults: []);
  static Supervision supervision = Supervision(null,[]);
}