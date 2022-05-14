
import 'package:injection_molding_machine_application/domain/entities/node_query.dart';

class DeviceQuryModel extends NodeQuery {
  DeviceQuryModel(
      {required String eonNodeId, required List<DeviceQuery> deviceQueries})
      : super(eonNodeId: eonNodeId, deviceQueries: deviceQueries);
}

class NodeQueryModel extends NodeQuery {
  NodeQueryModel(
      {required String eonNodeId, required List<DeviceQuery> deviceQueries})
      : super(eonNodeId: eonNodeId, deviceQueries: deviceQueries);
}
