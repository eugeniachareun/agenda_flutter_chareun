import 'dart:convert';
import 'package:agenda_flutter_chareun/model/contacto.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'api_client.dart';

class AgendaApi {
  AgendaApi({ApiClient? client}) : _client = client ?? ApiClient();

  final ApiClient _client;

  Future<void> create(Contacto c) async {
    final res = await _client.dio.post(
      '/api/contacto/add',
      data: {
        'nombre': c.nombre,
        'apellido': c.apellido,
        'telefono': c.telefono,
        'email': c.email
      },
    );

    debugPrint('AgendaApi.create statusCode: ${res.statusCode}');
    debugPrint('AgendaApi.create response body: ${res.data}');

    if (res.statusCode != 200) {
      throw Exception(
        'Error al crear contacto: ${res.data}',
      );
    }
  }

  Future<List<Contacto>> getAll() async {
    try {
      final res = await _client.dio.get('/minimal/contactos');

      debugPrint('AgendaApi.getAll statusCode: ${res.statusCode}');
      debugPrint('AgendaApi.getAll response body: ${res.data}');

      if (!_isSuccess(res.statusCode)) {
        throw Exception(
          'Error al obtener contactos: ${res.data}'
        );
      }

      final decoded = _decodeResponse(res.data);
      final data = _extractContactsList(decoded);

      return data.map(_contactFromJson).toList();
    } on DioException catch (e) {
      debugPrint('AgendaApi.getAll error: ${e.message}');
      throw Exception('Error al obtener contactos: ${e.message}');
    } catch (e) {
      debugPrint('AgendaApi.getAll error: $e');
      rethrow;
    }
  }

  Future<Contacto> getById(String id) async {
    final res = await _client.dio.get('/api/contacto/$id');

    debugPrint('AgendaApi.getById statusCode: ${res.statusCode}');
    debugPrint('AgendaApi.getById response body: ${res.data}');

    if (!_isSuccess(res.statusCode)) {
      throw Exception(
        'Error al obtener contacto: ${res.data}'
      );
    }

    final decoded = _decodeResponse(res.data);
    return _contactFromJson(decoded);
  }

  Future<void> update(Contacto c) async {
    final res = await _client.dio.put(
      '/api/contacto/edit/${c.id}',
      data: {
        'nombre': c.nombre,
        'apellido': c.apellido,
        'telefono': c.telefono,
        'email': c.email,
      },
    );

    debugPrint('AgendaApi.update statusCode: ${res.statusCode}');
    debugPrint('AgendaApi.update response body: ${res.data}');

    if (!_isSuccess(res.statusCode)) {
      throw Exception(
        'Error al actualizar contacto: ${res.data}'        
      );
    }
  }

  Future<void> delete(int id) async {
    final res = await _client.dio.delete('/api/contacto/delete/$id');

    debugPrint('AgendaApi.delete statusCode: ${res.statusCode}');
    debugPrint('AgendaApi.delete response body: ${res.data}');

    if (!_isSuccess(res.statusCode)) {
      throw Exception(
        'Error al eliminar contacto: ${res.data}'
      );
    }
  }

  bool _isSuccess(int? statusCode) {
    return statusCode != null && statusCode >= 200 && statusCode < 300;
  }

  dynamic _decodeResponse(dynamic data) {
    if (data is String) return jsonDecode(data);
    return data;
  }

  List<dynamic> _extractContactsList(dynamic decoded) {
    if (decoded is List) return decoded;

    if (decoded is Map<String, dynamic>) {
      final wrappedList =
          decoded['data'] ?? decoded['contactos'] ?? decoded['contacts'];
      if (wrappedList is List) return wrappedList;
    }

    throw Exception('Respuesta inesperada al obtener contactos');
  }

  Contacto _contactFromJson(dynamic value) {
    if (value is! Map<String, dynamic>) {
      throw Exception('Contacto con formato inesperado');
    }

    return Contacto(
      //id: (value['id'] ?? value['contactoId'] ?? '').toString(),
      nombre: (value['nombre'] ?? '').toString(),
      apellido: (value['apellido'] ?? '').toString(),
      telefono: (value['telefono'] ?? '').toString(),
      email: (value['email'] ?? '').toString(),
    );
  }
}
