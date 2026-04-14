part of 'discovery_bloc.dart';

abstract class DiscoveryEvent {}

/// Load first page of recommendations (on screen open or refresh).
class DiscoveryRecommendationsRequested extends DiscoveryEvent {
  DiscoveryRecommendationsRequested({required this.state, required this.nation});
  final String state;
  final String nation;
}

/// User typed in the search bar; reset to page 1.
class DiscoverySearchChanged extends DiscoveryEvent {
  DiscoverySearchChanged({
    required this.query,
    this.sessionType = '',
  });
  final String query;
  final String sessionType;
}

/// User changed the session-type filter chip.
class DiscoveryFilterChanged extends DiscoveryEvent {
  DiscoveryFilterChanged({
    required this.query,
    required this.sessionType,
    required this.userState,
    required this.userNation,
  });
  final String query;
  final String sessionType;
  final String userState;
  final String userNation;
}

/// Load next page of results (either search or recommendations).
class DiscoveryLoadMoreRequested extends DiscoveryEvent {}
