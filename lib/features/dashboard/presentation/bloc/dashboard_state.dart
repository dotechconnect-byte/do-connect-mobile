import 'package:equatable/equatable.dart';
import '../../data/models/dashboard_stat_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<DashboardStatModel> stats;
  final List<TopPerformerModel> topPerformers;
  final List<ShiftModel> shifts;
  final int selectedTab;

  const DashboardLoaded({
    required this.stats,
    required this.topPerformers,
    required this.shifts,
    this.selectedTab = 0,
  });

  @override
  List<Object> get props => [stats, topPerformers, shifts, selectedTab];

  DashboardLoaded copyWith({
    List<DashboardStatModel>? stats,
    List<TopPerformerModel>? topPerformers,
    List<ShiftModel>? shifts,
    int? selectedTab,
  }) {
    return DashboardLoaded(
      stats: stats ?? this.stats,
      topPerformers: topPerformers ?? this.topPerformers,
      shifts: shifts ?? this.shifts,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object> get props => [message];
}
