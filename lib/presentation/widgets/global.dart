
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';
class Global {
  static int id = 0;
  static int machineLengh = 0;
  static int machineindex = 0;
  static DeviceQueryResult deviceQueryResult = DeviceQueryResult(deviceId: 'deviceId', connected: false, tagQueryResults: []);
}