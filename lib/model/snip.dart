import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Snip {
  String? snipSender;
  String? snipText;

  static const baseUrl = 'http://10.0.2.2:4000';

  Snip({required this.snipSender, required this.snipText});

  // Parsing function to convert a map to a Snip
  factory Snip.fromJson(Map<String, dynamic> json) {
    return Snip(
      snipSender: json['snipSender'],
      snipText: json['snipText'],
    );
  }

  // Making an HTTP request to fetch snips
  static Future<List<Snip>> fetchSnips() async {
    final response = await http.get(Uri.parse(Snip.baseUrl + '/snips'));
    // final response = await http.get(Uri.parse('http://10.0.2.2:4000/snips'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((snip) => Snip.fromJson(snip)).toList();
    } else {
      throw Exception('Failed to load snips from the server');
    }
  }

  static Future<dynamic> addSnip(String snipSender, String snipText) async {
    final requestBody = {
      'snipSender': snipSender,
      'snipText': snipText,
    };

    final response =
        await http.post(Uri.parse(Snip.baseUrl + '/snips'), body: requestBody);

    print(response.statusCode);

    if (response.statusCode == 201) {
      dynamic jsonResponse = json.decode(
        response.body,
      );

      print(jsonResponse);

      final newSnip = {
        snipSender: jsonResponse['snipSender'],
        snipText: jsonResponse['snipText']
      };

      return newSnip;
    }
  }
}
