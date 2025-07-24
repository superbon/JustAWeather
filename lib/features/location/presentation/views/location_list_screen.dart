



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/location_list_viewmodel.dart';
import '../../domain/entities/saved_location.dart';
import 'edi_location_dialog.dart';

class LocationListScreen extends ConsumerWidget {
  const LocationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationsAsync = ref.watch(locationListViewModelProvider);
    final viewModel = ref.read(locationListViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Locations')),
      body: locationsAsync.when(
        data: (locations) => ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, i) {
            final loc = locations[i];
            return ListTile(
              title: Text(loc.name),
              subtitle: loc.country != null ? Text(loc.country!) : null,
              onTap: () {
                // Navigate to search result screen for this location
                // Use GoRouter or similar
                Navigator.of(context).pushNamed(
                  '/weather',
                  arguments: loc.name,
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      final updated = await showDialog<SavedLocation>(
                        context: context,
                        builder: (_) => EditLocationDialog(location: loc),
                      );
                      if (updated != null) await viewModel.updateLocation(updated);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => viewModel.deleteLocation(loc.id),
                  ),
                ],
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newLoc = await showDialog<SavedLocation>(
            context: context,
            builder: (_) => const EditLocationDialog(),
          );
          if (newLoc != null) await viewModel.addLocation(newLoc);
        },
        child: const Icon(Icons.add),
        tooltip: "Add Location",
      ),
    );
  }
}
