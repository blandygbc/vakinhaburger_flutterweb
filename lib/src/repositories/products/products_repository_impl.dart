import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/product_model.dart';
import './products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio _dio;
  final productsPath = '/products';

  ProductsRepositoryImpl(this._dio);

  @override
  Future<void> deleteProduct(int id) async {
    try {
      await _dio.auth().put(
        '$productsPath/$id',
        data: {
          'enabled': false,
        },
      );
    } on DioError catch (e, s) {
      log('Erro ao deletar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao deletar produto');
    }
  }

  @override
  Future<List<ProductModel>> findAll(String? name) async {
    try {
      final productResponse = await _dio.auth().get(
        productsPath,
        queryParameters: {
          if (name != null) 'name': name,
          'enabled': true,
        },
      );
      return productResponse.data
          .map<ProductModel>((p) => ProductModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }

  @override
  Future<ProductModel> getProduct(int id) async {
    try {
      final productResponse = await _dio.auth().get(
            '$productsPath/$id',
          );
      return ProductModel.fromMap(productResponse.data);
    } on DioError catch (e, s) {
      log('Erro ao recuperar o produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao recuperar o produto');
    }
  }

  @override
  Future<void> save(ProductModel productModel) async {
    try {
      final client = _dio.auth();
      if (productModel.id != null) {
        await client.put(
          '$productsPath/${productModel.id}',
          data: productModel.toMap(),
        );
      } else {
        await client.post(
          productsPath,
          data: productModel.toMap(),
        );
      }
    } on DioError catch (e, s) {
      log('Erro ao salvar o produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar o produto');
    }
  }

  @override
  Future<String> uploadProductImage(Uint8List file, String filename) async {
    try {
      final formData = FormData.fromMap(
        {
          'file': MultipartFile.fromBytes(file, filename: filename),
        },
      );
      final response = await _dio.auth().post('/uploads', data: formData);
      return response.data['url'];
    } on DioError catch (e, s) {
      log('Erro ao fazer o upload do arquivo', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao fazer o upload do arquivo');
    }
  }
}
