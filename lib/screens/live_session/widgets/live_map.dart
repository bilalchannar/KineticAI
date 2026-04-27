import 'package:flutter/material.dart';

class LiveMap extends StatelessWidget {
  const LiveMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black, // Background for the map
      child: Stack(
        children: [
          // Placeholder for Google Maps / Flutter Map
          const Center(
            child: Icon(Icons.map_rounded, color: Colors.white10, size: 120),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton.small(
              onPressed: () {},
              backgroundColor: Colors.white10,
              child: const Icon(Icons.my_location, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}