import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:therapist/core/di/injection.dart';
import 'package:therapist/features/discovery/data/discovery_repository.dart';

part 'discovery_event.dart';
part 'discovery_state.dart';

class DiscoveryBloc extends Bloc<DiscoveryEvent, DiscoveryState> {
  DiscoveryBloc() : super(DiscoveryInitial()) {
    on<DiscoveryRecommendationsRequested>(_onRecommendations);
    on<DiscoverySearchChanged>(_onSearchChanged);
    on<DiscoveryFilterChanged>(_onFilterChanged);
    on<DiscoveryLoadMoreRequested>(_onLoadMore);
  }

  final _repo = sl<DiscoveryRepository>();

  // ── Recommendations (empty query) ─────────────────────────────────────────

  Future<void> _onRecommendations(
    DiscoveryRecommendationsRequested e,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    final result = await _repo.getRecommendedTherapists(
      state: e.state,
      nation: e.nation,
    );
    result.fold(
      (f) => emit(DiscoveryError(f.message)),
      (list) => emit(DiscoveryLoaded(
        therapists:  list,
        isSearch:    false,
        query:       '',
        sessionType: '',
        page:        1,
        hasMore:     list.length >= 20,
      )),
    );
  }

  // ── Search ────────────────────────────────────────────────────────────────

  Future<void> _onSearchChanged(
    DiscoverySearchChanged e,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    final result = await _repo.searchTherapists(
      query:       e.query,
      sessionType: e.sessionType,
    );
    result.fold(
      (f) => emit(DiscoveryError(f.message)),
      (data) => emit(DiscoveryLoaded(
        therapists:  data.therapists,
        isSearch:    true,
        query:       e.query,
        sessionType: e.sessionType,
        page:        1,
        hasMore:     data.therapists.length < data.total,
        total:       data.total,
      )),
    );
  }

  // ── Filter change (session type) ──────────────────────────────────────────

  Future<void> _onFilterChanged(
    DiscoveryFilterChanged e,
    Emitter<DiscoveryState> emit,
  ) async {
    emit(DiscoveryLoading());
    if (e.query.isEmpty) {
      final result = await _repo.getRecommendedTherapists(
        state:  e.userState,
        nation: e.userNation,
      );
      result.fold(
        (f) => emit(DiscoveryError(f.message)),
        (list) => emit(DiscoveryLoaded(
          therapists:  list,
          isSearch:    false,
          query:       '',
          sessionType: e.sessionType,
          page:        1,
          hasMore:     list.length >= 20,
        )),
      );
    } else {
      final result = await _repo.searchTherapists(
        query:       e.query,
        sessionType: e.sessionType,
      );
      result.fold(
        (f) => emit(DiscoveryError(f.message)),
        (data) => emit(DiscoveryLoaded(
          therapists:  data.therapists,
          isSearch:    true,
          query:       e.query,
          sessionType: e.sessionType,
          page:        1,
          hasMore:     data.therapists.length < data.total,
          total:       data.total,
        )),
      );
    }
  }

  // ── Load more ─────────────────────────────────────────────────────────────

  Future<void> _onLoadMore(
    DiscoveryLoadMoreRequested e,
    Emitter<DiscoveryState> emit,
  ) async {
    final current = state;
    if (current is! DiscoveryLoaded || !current.hasMore) return;

    emit(DiscoveryLoadingMore(
      therapists: current.therapists,
      isSearch:   current.isSearch,
    ));

    final nextPage = current.page + 1;

    if (current.isSearch) {
      final result = await _repo.searchTherapists(
        query:       current.query,
        sessionType: current.sessionType,
        page:        nextPage,
      );
      result.fold(
        (f) => emit(DiscoveryError(f.message)),
        (data) {
          final all = [...current.therapists, ...data.therapists];
          emit(DiscoveryLoaded(
            therapists:  all,
            isSearch:    true,
            query:       current.query,
            sessionType: current.sessionType,
            page:        nextPage,
            hasMore:     all.length < data.total,
            total:       data.total,
          ));
        },
      );
    } else {
      // Recommendations don't have total — use list-length heuristic.
      final result = await _repo.getRecommendedTherapists(
        state:  '',
        nation: '',
        page:   nextPage,
      );
      result.fold(
        (f) => emit(DiscoveryError(f.message)),
        (list) {
          final all = [...current.therapists, ...list];
          emit(DiscoveryLoaded(
            therapists:  all,
            isSearch:    false,
            query:       '',
            sessionType: current.sessionType,
            page:        nextPage,
            hasMore:     list.length >= 20,
          ));
        },
      );
    }
  }
}
