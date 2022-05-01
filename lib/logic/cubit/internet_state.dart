part of 'internet_cubit.dart';

abstract class InternetState extends Equatable {
  const InternetState();
}

class InternetLoading extends InternetState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({
    required this.connectionType,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}

class InternetDisconnected extends InternetState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
