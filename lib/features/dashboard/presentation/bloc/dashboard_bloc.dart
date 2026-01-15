import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/dashboard_stat_model.dart';
import '../../../../core/consts/color_manager.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<LoadDashboardData>(_onLoadDashboardData);
    on<RefreshDashboardData>(_onRefreshDashboardData);
    on<ChangeTab>(_onChangeTab);
  }

  Future<void> _onLoadDashboardData(
    LoadDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // Mock data - Replace with actual API calls
      final stats = _getMockStats();
      final topPerformers = _getMockTopPerformers();
      final shifts = _getMockShifts();

      emit(DashboardLoaded(
        stats: stats,
        topPerformers: topPerformers,
        shifts: shifts,
      ));
    } catch (e) {
      emit(DashboardError(e.toString()));
    }
  }

  Future<void> _onRefreshDashboardData(
    RefreshDashboardData event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;

      try {
        // Simulate API call
        await Future.delayed(const Duration(milliseconds: 500));

        final stats = _getMockStats();
        final topPerformers = _getMockTopPerformers();
        final shifts = _getMockShifts();

        emit(currentState.copyWith(
          stats: stats,
          topPerformers: topPerformers,
          shifts: shifts,
        ));
      } catch (e) {
        emit(DashboardError(e.toString()));
      }
    }
  }

  void _onChangeTab(ChangeTab event, Emitter<DashboardState> emit) {
    if (state is DashboardLoaded) {
      final currentState = state as DashboardLoaded;
      emit(currentState.copyWith(selectedTab: event.tabIndex));
    }
  }

  // Mock data methods - Replace with actual API calls
  List<DashboardStatModel> _getMockStats() {
    return [
      DashboardStatModel(
        title: 'Active DOER Today',
        value: '1',
        change: '+12%',
        isPositive: true,
        icon: Icons.people_outline,
        iconColor: ColorManager.primary,
      ),
      DashboardStatModel(
        title: 'Shifts in Progress',
        value: '1',
        change: '+8%',
        isPositive: true,
        icon: Icons.work_outline,
        iconColor: ColorManager.success,
      ),
      DashboardStatModel(
        title: 'Requested This Week',
        value: '42',
        change: '-3%',
        isPositive: false,
        icon: Icons.calendar_today_outlined,
        iconColor: const Color(0xFFFBBF24),
      ),
      DashboardStatModel(
        title: 'Rating Rate',
        value: '75%',
        change: '+5%',
        isPositive: true,
        icon: Icons.star_outline,
        iconColor: ColorManager.primary,
      ),
      DashboardStatModel(
        title: 'No-Show Rate',
        value: '8%',
        change: '-8%',
        isPositive: true,
        icon: Icons.person_off_outlined,
        iconColor: ColorManager.error,
      ),
      DashboardStatModel(
        title: 'Unpaid Invoices',
        value: '2',
        change: '2 pending',
        isPositive: false,
        icon: Icons.receipt_long_outlined,
        iconColor: ColorManager.error,
      ),
      DashboardStatModel(
        title: 'Hours This Month',
        value: '2450',
        change: '+18%',
        isPositive: true,
        icon: Icons.access_time,
        iconColor: ColorManager.success,
      ),
      DashboardStatModel(
        title: 'Completed This Week',
        value: '15',
        change: '+6%',
        isPositive: true,
        icon: Icons.check_circle_outline,
        iconColor: ColorManager.primary,
      ),
    ];
  }

  List<TopPerformerModel> _getMockTopPerformers() {
    return [
      TopPerformerModel(name: 'Sarah Johnson', hoursWorked: '42h', rating: 4.9),
      TopPerformerModel(name: 'Emily Rodriguez', hoursWorked: '38h', rating: 4.8),
      TopPerformerModel(name: 'Michael Chen', hoursWorked: '35h', rating: 4.7),
      TopPerformerModel(name: 'Lisa Anderson', hoursWorked: '32h', rating: 4.6),
      TopPerformerModel(name: 'David Park', hoursWorked: '30h', rating: 4.5),
    ];
  }

  List<ShiftModel> _getMockShifts() {
    return [
      ShiftModel(
        date: 'Wed, Dec 17',
        time: '08:00 - 16:00',
        location: 'West Branch',
        position: 'Event Coordinator',
        assignedTo: 'James Wilson',
        status: 'confirmed',
      ),
      ShiftModel(
        date: 'Wed, Dec 17',
        time: '14:00 - 22:00',
        location: 'West Branch',
        position: 'Parking Attendant',
        assignedTo: 'Lisa Anderson',
        status: 'confirmed',
      ),
      ShiftModel(
        date: 'Wed, Dec 17',
        time: '18:00 - 02:00',
        location: 'West Branch',
        position: 'Crowd Control',
        assignedTo: 'David Park',
        status: 'confirmed',
      ),
    ];
  }
}
