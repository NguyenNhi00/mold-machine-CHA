import 'package:equatable/equatable.dart';

class DeviceQuery extends Equatable {
  final String deviceId;
  final List<String> tagNames;

  const DeviceQuery({
    required this.deviceId,
    required this.tagNames,
  });

  @override
  List<Object> get props => [tagNames, deviceId];
}

class NodeQuery extends Equatable {
  final String eonNodeId;
  final List<DeviceQuery> deviceQueries;

  const NodeQuery({
    required this.eonNodeId,
    required this.deviceQueries,
  });
  @override
  List<Object> get props => [eonNodeId, deviceQueries];

  // convert to json
}
