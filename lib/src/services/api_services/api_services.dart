import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:muroexe_store/src/app/app.dart';
import 'package:muroexe_store/src/core/constants/helper/snackbar_services.dart';
import 'package:muroexe_store/src/models/product_list/product_list.dart';
import 'package:muroexe_store/src/models/signin.dart';
import 'package:muroexe_store/src/services/base/failure.dart';

const String scheme = 'https';
const String host = 'fakestoreapi.com';

Uri singleProductUri({required int id}) =>
    Uri(scheme: scheme, host: host, path: '/products/$id');
Uri limitedProductUri({required int limit}) =>
    Uri(scheme: scheme, host: host, path: '/products', query: 'limit=$limit');
Uri allProducts = Uri(scheme: scheme, host: host, path: '/products');
Uri signInUri = Uri(scheme: scheme, host: host, path: '/auth/login');

///https://fakestoreapi.com/products?limit=5
class ApiServices {
  static const String apiBase = 'https://fakestoreapi.com/';

  final _client = Client();

  Future<Response> _post(
      {required Map<String, dynamic> data, required Uri uri}) async {
    log('Making request to $uri');
    final Response response = await _client.post(uri, body: data);
    log('Response from $uri\n ${response.body}');
    return response;
  }

  Future<Response> _getMethod({required Uri uri}) async {
    log('Making request to $uri');
    final Response response = await _client.get(uri);
    log('Response from $uri\n ${response.body}');
    return response;
  }

  Future<Product> singleProduct() async {
    try {
      Response res = await _getMethod(uri: singleProductUri(id: 3));
      Map<String, dynamic> decodedResponse = jsonDecode(res.body);
      return Product.fromJson(decodedResponse);
    } on SocketException catch (ex, stackTrace) {
      throw Failure(
          message: 'You don\'t have internet connection',
          devMessage: stackTrace.toString());
    } catch (ex, stackTrace) {
      throw Failure(
          message: 'Try again',
          devMessage: 'Error:$ex, Stacktrace: $stackTrace');
    }
  }

  Future<List<Product>> limitedProduct() async {
    try {
      Response res = await _getMethod(uri: limitedProductUri(limit: 5));
      List<Product> data = List<Product>.from(
          json.decode(res.body).map((x) => Product.fromJson(x))).toList();
      return data;
    } on SocketException catch (ex, stackTrace) {
      throw Failure(
          message: 'You don\'t have internet connection',
          devMessage: stackTrace.toString());
    } catch (ex, stackTrace) {
      throw Failure(
          message: 'Try again',
          devMessage: 'Error:$ex, Stacktrace: $stackTrace');
    }
  }

  Future signIn(Signin signInData) async {
    try {
      log('Attempting to sign in');
      await _post(data: signInData.toSignIn(), uri: signInUri);
      log('Signed successfully');
    } on SocketException catch (ex, stackTrace) {
      throw Failure(
          message: 'You don\'t have internet connection',
          devMessage: stackTrace.toString());
    } on FormatException {
      throw const Failure(
        message: 'Username or password is incorrect',
        devMessage: 'Username or password is incorrect at format',
      );
    } catch (ex, stackTrace) {
      throw Failure(
          message: 'Try again',
          devMessage: 'Error:$ex, Stacktrace: $stackTrace');
    }
  }
}
