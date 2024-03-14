import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;

// Model class for property data
class Property {
  final String propertyName;
  final String type;
  final String listingDate;
  final String location;
  final double rating;
  final int price;

  Property({
    required this.propertyName,
    required this.type,
    required this.listingDate,
    required this.location,
    required this.rating,
    required this.price,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      propertyName: json['propertyName'],
      type: json['type'],
      listingDate: json['listingDate'],
      location: json['location'],
      rating: json['rating'].toDouble(),
      price: json['price'],
    );
  }
}

// Function to load property data from JSON file
Future<List<Property>> loadProperties() async {
  // Load the JSON file
  String jsonString = await rootBundle.loadString('assests/properties.json');
  // Parse the JSON data
  List<dynamic> jsonList = convert.json.decode(jsonString);
  // Convert JSON data to a list of Property objects
  List<Property> properties = [];
  for (var jsonItem in jsonList) {
    properties.add(Property.fromJson(jsonItem));
  }
  return properties;
}

// Property Page Widget
class PropertyPage extends StatefulWidget {
  const PropertyPage({super.key});

  @override
  _PropertyPageState createState() => _PropertyPageState();
}

class _PropertyPageState extends State<PropertyPage> {
  List<Property> _allProperties = [];
  List<Property> _filteredProperties = [];

  @override
  void initState() {
    super.initState();
    loadProperties().then((properties) {
      setState(() {
        _allProperties = properties;
        _filteredProperties = _allProperties;
      });
    });
  }

  void _filterProperties(String type) {
    setState(() {
      if (type == "All") {
        _filteredProperties = _allProperties;
      } else {
        _filteredProperties = _allProperties.where((property) => property.type == type).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Properties'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 8.0,
            children: [
              FilterChip(
                label: Text('All'),
                selected: _filteredProperties == _allProperties,
                onSelected: (isSelected) => _filterProperties("All"),
              ),
              FilterChip(
                label: Text('1BHK'),
                selected: _filteredProperties != _allProperties && _filteredProperties.every((property) => property.type == "1BHK"),
                onSelected: (isSelected) => _filterProperties("1BHK"),
              ),
              FilterChip(
                label: Text('2BHK'),
                selected: _filteredProperties != _allProperties && _filteredProperties.every((property) => property.type == "2BHK"),
                onSelected: (isSelected) => _filterProperties("2BHK"),
              ),
              // Add more filter chips as needed for other property types
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProperties.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredProperties[index].propertyName),
                  subtitle: Text(_filteredProperties[index].location),
                  // Add more details as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

