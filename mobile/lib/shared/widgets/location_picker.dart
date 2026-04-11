import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
    hide LatLng;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:therapist/core/config/env.dart';
import 'package:therapist/core/theme/app_theme.dart';

// ── Data class returned by the picker ────────────────────────────────────────

class PickedLocation {
  const PickedLocation({
    required this.addressText,
    required this.latitude,
    required this.longitude,
    required this.placeId,
  });

  final String addressText;
  final double latitude;
  final double longitude;
  final String placeId;
}

// ── LocationPickerField ───────────────────────────────────────────────────────
//
// Tappable card that opens the full-screen location picker.
// Shows the chosen address (or a placeholder) with a map-pin icon.

class LocationPickerField extends StatelessWidget {
  const LocationPickerField({
    super.key,
    required this.onPicked,
    this.picked,
    this.errorText,
  });

  final ValueChanged<PickedLocation> onPicked;
  final PickedLocation? picked;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Practice location *',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            final result = await Navigator.of(context).push<PickedLocation>(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (_) => _LocationPickerScreen(initial: picked),
              ),
            );
            if (result != null) onPicked(result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null
                    ? AppColors.error
                    : Theme.of(context).colorScheme.outline,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,
                    color: errorText != null
                        ? AppColors.error
                        : AppColors.subtle),
                const SizedBox(width: 10),
                Expanded(
                  child: picked != null
                      ? Text(picked!.addressText,
                          style: const TextStyle(fontSize: 14))
                      : Text('Search for your practice address',
                          style: TextStyle(
                              fontSize: 14, color: AppColors.subtle)),
                ),
                if (picked != null)
                  const Icon(Icons.check_circle_outline,
                      color: Colors.green, size: 18),
              ],
            ),
          ),
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(errorText!,
              style: TextStyle(fontSize: 12, color: AppColors.error)),
        ],
      ],
    );
  }
}

// ── Full-screen picker screen ─────────────────────────────────────────────────

class _LocationPickerScreen extends StatefulWidget {
  const _LocationPickerScreen({this.initial});
  final PickedLocation? initial;

  @override
  State<_LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<_LocationPickerScreen> {
  late final FlutterGooglePlacesSdk _places;
  final _searchCtrl = TextEditingController();
  final _focusNode = FocusNode();

  GoogleMapController? _mapCtrl;
  PickedLocation? _selected;

  List<AutocompletePrediction> _predictions = [];
  bool _searching = false;
  Timer? _debounce;

  static const _initialPosition = LatLng(20.5937, 78.9629); // India centre

  @override
  void initState() {
    super.initState();
    _places = FlutterGooglePlacesSdk(Env.googleMapsApiKey);
    if (widget.initial != null) {
      _selected = widget.initial;
      _searchCtrl.text = widget.initial!.addressText;
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    _mapCtrl?.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    if (query.trim().isEmpty) {
      setState(() => _predictions = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () => _fetchPredictions(query));
  }

  Future<void> _fetchPredictions(String query) async {
    setState(() => _searching = true);
    try {
      final res = await _places.findAutocompletePredictions(query);
      if (mounted) setState(() => _predictions = res.predictions);
    } catch (_) {
      if (mounted) setState(() => _predictions = []);
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  Future<void> _selectPrediction(AutocompletePrediction prediction) async {
    _focusNode.unfocus();
    setState(() {
      _predictions = [];
      _searching = true;
    });
    try {
      final detail = await _places.fetchPlace(
        prediction.placeId,
        fields: [PlaceField.Location, PlaceField.Address],
      );
      final place = detail.place;
      if (place?.latLng == null) return;

      final loc = PickedLocation(
        addressText: place!.address ?? prediction.fullText,
        latitude: place.latLng!.lat,
        longitude: place.latLng!.lng,
        placeId: prediction.placeId,
      );

      _searchCtrl.text = loc.addressText;
      final target = LatLng(loc.latitude, loc.longitude);

      _mapCtrl?.animateCamera(
        CameraUpdate.newLatLngZoom(target, 15),
      );

      if (mounted) setState(() => _selected = loc);
    } catch (_) {
      // keep previous selection on error
    } finally {
      if (mounted) setState(() => _searching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialTarget = _selected != null
        ? LatLng(_selected!.latitude, _selected!.longitude)
        : _initialPosition;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select practice location'),
        actions: [
          if (_selected != null)
            TextButton(
              onPressed: () => Navigator.of(context).pop(_selected),
              child: const Text('Confirm'),
            ),
        ],
      ),
      body: Column(
        children: [
          // ── Search bar ──────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: TextField(
              controller: _searchCtrl,
              focusNode: _focusNode,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search address…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searching
                    ? const Padding(
                        padding: EdgeInsets.all(12),
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      )
                    : _searchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchCtrl.clear();
                              setState(() => _predictions = []);
                            },
                          )
                        : null,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // ── Autocomplete list ────────────────────────────────────────────
          if (_predictions.isNotEmpty)
            Container(
              constraints: const BoxConstraints(maxHeight: 220),
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                border: Border.all(
                    color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: _predictions.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (_, i) {
                  final p = _predictions[i];
                  return ListTile(
                    dense: true,
                    leading: const Icon(Icons.location_on_outlined, size: 20),
                    title: Text(p.primaryText,
                        style: const TextStyle(fontSize: 14)),
                    subtitle: Text(p.secondaryText,
                        style: const TextStyle(fontSize: 12)),
                    onTap: () => _selectPrediction(p),
                  );
                },
              ),
            ),

          // ── Map ──────────────────────────────────────────────────────────
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialTarget,
                zoom: _selected != null ? 15 : 5,
              ),
              onMapCreated: (c) => _mapCtrl = c,
              markers: _selected != null
                  ? {
                      Marker(
                        markerId: const MarkerId('selected'),
                        position:
                            LatLng(_selected!.latitude, _selected!.longitude),
                        infoWindow:
                            InfoWindow(title: _selected!.addressText),
                      ),
                    }
                  : {},
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
            ),
          ),

          // ── Selected address chip ────────────────────────────────────────
          if (_selected != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Row(
                children: [
                  const Icon(Icons.check_circle_outline, size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _selected!.addressText,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
