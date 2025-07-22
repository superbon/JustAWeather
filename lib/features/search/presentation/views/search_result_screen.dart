/*
 * @Author: Bon Ryan
 * @Created: 2025-07-23
 * @Page: search_result_screen
 * @Description: This file contains the SearchResultScreen class for displaying search results.
 * It is used to show weather details for a specific city after a search.
 * The SearchResultScreen is part of the presentation layer and provides a user interface for displaying weather information.
 * It uses Riverpod for state management and allows users to view weather details for a searched city.
 * It is used to encapsulate the logic for displaying search results.
 * It is used to provide a user-friendly interface for viewing weather information.
 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResultScreen extends StatefulWidget {
  final String city;
  const SearchResultScreen({required this.city, super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.city);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    if (query.trim().isEmpty) return;
    context.push('/search/${Uri.encodeComponent(query.trim())}');
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Use [widget.city] to fetch weather data.
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/'); // Always goes back to home screen
          },
        ), // Shows the back arrow
        title: TextField(
          controller: _searchController,
          autofocus: false,
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            hintText: 'Search city...',
            hintStyle: TextStyle(color: Colors.black),
            border: InputBorder.none,
          ),
          onSubmitted: _onSearch,
          textInputAction: TextInputAction.search,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Show weather details for "${widget.city}" here',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
