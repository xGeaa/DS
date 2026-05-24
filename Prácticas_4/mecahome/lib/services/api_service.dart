import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../models/dispositivo_model.dart';

class ApiService {
  static final String baseUrl = kIsWeb
      ? 'http://localhost:3000'
      : (Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000');

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Future<List<Dispositivo>> getDispositivos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/dispositivos'), headers: _headers);
      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        return body.map((dynamic item) => Dispositivo.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar dispositivos');
      }
    } catch (e) {
      throw Exception('No se pudo conectar con el servidor: $e');
    }
  }

  Future<bool> crearDispositivo(Map<String, dynamic> datos) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/dispositivos'),
        headers: _headers,
        body: json.encode({'dispositivo': datos}),
      );
      return response.statusCode == 201;
    } catch (e) {
      return false;
    }
  }

  Future<bool> actualizarDispositivo(int id, Map<String, dynamic> datos) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/dispositivos/$id'),
        headers: _headers,
        body: json.encode({'dispositivo': datos}),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> borrarDispositivo(int id) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/dispositivos/$id'), headers: _headers);
      return response.statusCode == 204 || response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}