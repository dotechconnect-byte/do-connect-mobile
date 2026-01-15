import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class LoadDashboardData extends DashboardEvent {
  const LoadDashboardData();
}

class RefreshDashboardData extends DashboardEvent {
  const RefreshDashboardData();
}

class ChangeTab extends DashboardEvent {
  final int tabIndex;

  const ChangeTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
