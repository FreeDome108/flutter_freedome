import 'package:dio/dio.dart';
import '../models/order_models.dart';
import 'magento_api_client.dart';

/// Order API for Magento
class OrderApi {
  final MagentoApiClient _client;

  OrderApi(this._client);

  /// Get customer orders with pagination and filters
  Future<OrderListResponse> getCustomerOrders({
    int page = 1,
    int pageSize = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      String url = '/rest/V1/customers/me/orders?searchCriteria[currentPage]=$page&searchCriteria[pageSize]=$pageSize';
      
      if (filters != null) {
        filters.forEach((key, value) {
          url += '&searchCriteria[filterGroups][0][filters][0][field]=$key&searchCriteria[filterGroups][0][filters][0][value]=$value';
        });
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(url);

      if (response.statusCode == 200) {
        return OrderListResponse.fromJson(response.data!);
      } else {
        throw Exception('Failed to get customer orders: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get customer orders: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get customer orders: $e');
    }
  }

  /// Get order by ID
  Future<Order> getOrder(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId',
      );

      if (response.statusCode == 200) {
        return Order.fromJson(response.data!);
      } else {
        throw Exception('Failed to get order: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get order: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get order: $e');
    }
  }

  /// Get order by increment ID
  Future<Order> getOrderByIncrementId(String incrementId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders?searchCriteria[filterGroups][0][filters][0][field]=increment_id&searchCriteria[filterGroups][0][filters][0][value]=$incrementId',
      );

      if (response.statusCode == 200) {
        final items = response.data!['items'] as List<dynamic>;
        if (items.isNotEmpty) {
          return Order.fromJson(items.first);
        } else {
          throw Exception('Order not found with increment ID: $incrementId');
        }
      } else {
        throw Exception('Failed to get order by increment ID: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get order by increment ID: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get order by increment ID: $e');
    }
  }

  /// Get order items
  Future<List<OrderItem>> getOrderItems(String orderId) async {
    try {
      final order = await getOrder(orderId);
      return order.items ?? [];
    } catch (e) {
      throw Exception('Failed to get order items: $e');
    }
  }

  /// Get order totals
  Future<OrderTotals> getOrderTotals(String orderId) async {
    try {
      final order = await getOrder(orderId);
      return order.totals ?? OrderTotals();
    } catch (e) {
      throw Exception('Failed to get order totals: $e');
    }
  }

  /// Get order status
  Future<String> getOrderStatus(String orderId) async {
    try {
      final order = await getOrder(orderId);
      return order.status ?? '';
    } catch (e) {
      throw Exception('Failed to get order status: $e');
    }
  }

  /// Get order comments
  Future<List<OrderComment>> getOrderComments(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/comments',
      );

      if (response.statusCode == 200) {
        final List<dynamic> comments = response.data!['items'] ?? [];
        return comments.map((comment) => OrderComment.fromJson(comment)).toList();
      } else {
        throw Exception('Failed to get order comments: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get order comments: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get order comments: $e');
    }
  }

  /// Get order history
  Future<List<OrderHistory>> getOrderHistory(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/status-history',
      );

      if (response.statusCode == 200) {
        final List<dynamic> history = response.data!['items'] ?? [];
        return history.map((item) => OrderHistory.fromJson(item)).toList();
      } else {
        throw Exception('Failed to get order history: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get order history: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get order history: $e');
    }
  }

  /// Reorder - create new cart from existing order
  Future<Cart> reorder(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/reorder',
        method: 'POST',
      );

      if (response.statusCode == 200) {
        // TODO: Return Cart model instead of Map
        // For now, create a basic cart response
        return Cart.fromJson(response.data!);
      } else {
        throw Exception('Failed to reorder: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to reorder: ${e.message}');
    } catch (e) {
      throw Exception('Failed to reorder: $e');
    }
  }

  /// Cancel order
  Future<bool> cancelOrder(String orderId, {String? reason}) async {
    try {
      final data = <String, dynamic>{};
      if (reason != null) {
        data['reason'] = reason;
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/cancel',
        method: 'POST',
        data: data,
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to cancel order: ${e.message}');
    } catch (e) {
      throw Exception('Failed to cancel order: $e');
    }
  }

  /// Hold order
  Future<bool> holdOrder(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/hold',
        method: 'POST',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to hold order: ${e.message}');
    } catch (e) {
      throw Exception('Failed to hold order: $e');
    }
  }

  /// Unhold order
  Future<bool> unholdOrder(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/unhold',
        method: 'POST',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to unhold order: ${e.message}');
    } catch (e) {
      throw Exception('Failed to unhold order: $e');
    }
  }

  /// Get order invoices
  Future<List<Invoice>> getOrderInvoices(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/invoices',
      );

      if (response.statusCode == 200) {
        final List<dynamic> invoices = response.data!['items'] ?? [];
        return invoices.map((invoice) => Invoice.fromJson(invoice)).toList();
      } else {
        throw Exception('Failed to get order invoices: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get order invoices: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get order invoices: $e');
    }
  }

  /// Get invoice details
  Future<Invoice> getInvoice(String invoiceId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/invoices/$invoiceId',
      );

      if (response.statusCode == 200) {
        return Invoice.fromJson(response.data!);
      } else {
        throw Exception('Failed to get invoice: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get invoice: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get invoice: $e');
    }
  }

  /// Get invoice PDF
  Future<String> getInvoicePdf(String invoiceId) async {
    try {
      final response = await _client.authenticatedRequest<String>(
        '/rest/V1/invoices/$invoiceId/pdf',
        responseType: ResponseType.plain,
      );

      if (response.statusCode == 200) {
        return response.data!;
      } else {
        throw Exception('Failed to get invoice PDF: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get invoice PDF: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get invoice PDF: $e');
    }
  }

  /// Get order shipments
  Future<List<Shipment>> getOrderShipments(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/shipments',
      );

      if (response.statusCode == 200) {
        final List<dynamic> shipments = response.data!['items'] ?? [];
        return shipments.map((shipment) => Shipment.fromJson(shipment)).toList();
      } else {
        throw Exception('Failed to get order shipments: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get order shipments: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get order shipments: $e');
    }
  }

  /// Get shipment details
  Future<Shipment> getShipment(String shipmentId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/shipments/$shipmentId',
      );

      if (response.statusCode == 200) {
        return Shipment.fromJson(response.data!);
      } else {
        throw Exception('Failed to get shipment: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get shipment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get shipment: $e');
    }
  }

  /// Get shipment tracking
  Future<List<ShipmentTracking>> getShipmentTracking(String shipmentId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/shipments/$shipmentId/tracks',
      );

      if (response.statusCode == 200) {
        final List<dynamic> tracks = response.data!['items'] ?? [];
        return tracks.map((track) => ShipmentTracking.fromJson(track)).toList();
      } else {
        throw Exception('Failed to get shipment tracking: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get shipment tracking: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get shipment tracking: $e');
    }
  }

  /// Get shipping label
  Future<String> getShippingLabel(String shipmentId) async {
    try {
      final response = await _client.authenticatedRequest<String>(
        '/rest/V1/shipments/$shipmentId/labels',
        responseType: ResponseType.plain,
      );

      if (response.statusCode == 200) {
        return response.data!;
      } else {
        throw Exception('Failed to get shipping label: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get shipping label: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get shipping label: $e');
    }
  }

  /// Get order credit memos
  Future<List<CreditMemo>> getOrderCreditMemos(String orderId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/creditmemos',
      );

      if (response.statusCode == 200) {
        final List<dynamic> creditMemos = response.data!['items'] ?? [];
        return creditMemos.map((memo) => CreditMemo.fromJson(memo)).toList();
      } else {
        throw Exception('Failed to get order credit memos: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get order credit memos: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get order credit memos: $e');
    }
  }

  /// Get credit memo details
  Future<CreditMemo> getCreditMemo(String creditMemoId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/creditmemos/$creditMemoId',
      );

      if (response.statusCode == 200) {
        return CreditMemo.fromJson(response.data!);
      } else {
        throw Exception('Failed to get credit memo: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get credit memo: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get credit memo: $e');
    }
  }

  /// Get credit memo PDF
  Future<String> getCreditMemoPdf(String creditMemoId) async {
    try {
      final response = await _client.authenticatedRequest<String>(
        '/rest/V1/creditmemos/$creditMemoId/pdf',
        responseType: ResponseType.plain,
      );

      if (response.statusCode == 200) {
        return response.data!;
      } else {
        throw Exception('Failed to get credit memo PDF: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get credit memo PDF: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get credit memo PDF: $e');
    }
  }

  /// Create return for order
  Future<Return> createReturn({
    required String orderId,
    required List<ReturnItem> items,
    String? comment,
  }) async {
    try {
      final data = {
        'items': items.map((item) => item.toJson()).toList(),
      };

      if (comment != null) {
        data['comment'] = comment;
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/orders/$orderId/returns',
        method: 'POST',
        data: data,
      );

      if (response.statusCode == 200) {
        return Return.fromJson(response.data!);
      } else {
        throw Exception('Failed to create return: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to create return: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create return: $e');
    }
  }

  /// Get customer returns
  Future<List<Return>> getCustomerReturns({
    int page = 1,
    int pageSize = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      String url = '/rest/V1/returns?searchCriteria[currentPage]=$page&searchCriteria[pageSize]=$pageSize';
      
      if (filters != null) {
        filters.forEach((key, value) {
          url += '&searchCriteria[filterGroups][0][filters][0][field]=$key&searchCriteria[filterGroups][0][filters][0][value]=$value';
        });
      }

      final response = await _client.authenticatedRequest<Map<String, dynamic>>(url);

      if (response.statusCode == 200) {
        final List<dynamic> returns = response.data!['items'] ?? [];
        return returns.map((returnItem) => Return.fromJson(returnItem)).toList();
      } else {
        throw Exception('Failed to get customer returns: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get customer returns: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get customer returns: $e');
    }
  }

  /// Get return details
  Future<Return> getReturn(String returnId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/returns/$returnId',
      );

      if (response.statusCode == 200) {
        return Return.fromJson(response.data!);
      } else {
        throw Exception('Failed to get return: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to get return: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get return: $e');
    }
  }

  /// Update return
  Future<Return> updateReturn({
    required String returnId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/returns/$returnId',
        method: 'PUT',
        data: data,
      );

      if (response.statusCode == 200) {
        return Return.fromJson(response.data!);
      } else {
        throw Exception('Failed to update return: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update return: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update return: $e');
    }
  }

  /// Cancel return
  Future<bool> cancelReturn(String returnId) async {
    try {
      final response = await _client.authenticatedRequest<Map<String, dynamic>>(
        '/rest/V1/returns/$returnId/cancel',
        method: 'POST',
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to cancel return: ${e.message}');
    } catch (e) {
      throw Exception('Failed to cancel return: $e');
    }
  }
}
