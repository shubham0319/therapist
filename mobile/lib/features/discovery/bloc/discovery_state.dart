part of 'discovery_bloc.dart';

abstract class DiscoveryState {}

class DiscoveryInitial extends DiscoveryState {}

class DiscoveryLoading extends DiscoveryState {}

class DiscoveryLoadingMore extends DiscoveryState {
  DiscoveryLoadingMore({required this.therapists, required this.isSearch});
  final List<TherapistCardModel> therapists;
  final bool isSearch;
}

class DiscoveryLoaded extends DiscoveryState {
  DiscoveryLoaded({
    required this.therapists,
    required this.isSearch,
    required this.query,
    required this.sessionType,
    required this.page,
    required this.hasMore,
    this.total = 0,
  });
  final List<TherapistCardModel> therapists;
  final bool isSearch;
  final String query;
  final String sessionType;
  final int page;
  final bool hasMore;
  final int total;
}

class DiscoveryError extends DiscoveryState {
  DiscoveryError(this.message);
  final String message;
}
