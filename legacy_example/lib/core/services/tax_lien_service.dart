import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class TaxLien {
  final String id;
  final String parcelId;
  final String owner;
  final String address;
  final String county;
  final String state;
  final double assessedValue;
  final double taxAmount;
  final double interestRate;
  final DateTime auctionDate;
  final DateTime redemptionDeadline;
  final String status; // 'available', 'sold', 'redeemed', 'foreclosed'
  final double? salePrice;
  final String? buyerId;
  final Map<String, dynamic>? additionalData;

  TaxLien({
    required this.id,
    required this.parcelId,
    required this.owner,
    required this.address,
    required this.county,
    required this.state,
    required this.assessedValue,
    required this.taxAmount,
    required this.interestRate,
    required this.auctionDate,
    required this.redemptionDeadline,
    required this.status,
    this.salePrice,
    this.buyerId,
    this.additionalData,
  });

  factory TaxLien.fromJson(Map<String, dynamic> json) {
    return TaxLien(
      id: json['id'],
      parcelId: json['parcelId'],
      owner: json['owner'],
      address: json['address'],
      county: json['county'],
      state: json['state'],
      assessedValue: json['assessedValue'].toDouble(),
      taxAmount: json['taxAmount'].toDouble(),
      interestRate: json['interestRate'].toDouble(),
      auctionDate: DateTime.parse(json['auctionDate']),
      redemptionDeadline: DateTime.parse(json['redemptionDeadline']),
      status: json['status'],
      salePrice: json['salePrice']?.toDouble(),
      buyerId: json['buyerId'],
      additionalData: json['additionalData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parcelId': parcelId,
      'owner': owner,
      'address': address,
      'county': county,
      'state': state,
      'assessedValue': assessedValue,
      'taxAmount': taxAmount,
      'interestRate': interestRate,
      'auctionDate': auctionDate.toIso8601String(),
      'redemptionDeadline': redemptionDeadline.toIso8601String(),
      'status': status,
      'salePrice': salePrice,
      'buyerId': buyerId,
      'additionalData': additionalData,
    };
  }
}

class TaxLienService extends ChangeNotifier {
  static const String _baseUrl = 'https://api.taxlien.online';
  List<TaxLien> _availableLiens = [];
  List<TaxLien> _myLiens = [];
  bool _isLoading = false;
  String? _error;

  // Mock data for prototype
  final List<Map<String, dynamic>> _mockAvailableLiens = [
    {
      'id': 'TL005',
      'parcelId': 'R00061-000',
      'owner': 'David Brown',
      'address': '555 Maple Dr, Columbia, FL 32025',
      'county': 'Columbia',
      'state': 'FL',
      'assessedValue': 75000.0,
      'taxAmount': 1100.0,
      'interestRate': 18.0,
      'auctionDate': '2024-05-15',
      'redemptionDeadline': '2025-05-15',
      'status': 'available',
    },
    {
      'id': 'TL006',
      'parcelId': '340913449600000050',
      'owner': 'Lisa Anderson',
      'address': '777 Cedar Ln, Dixie, FL 32329',
      'county': 'Dixie',
      'state': 'FL',
      'assessedValue': 180000.0,
      'taxAmount': 2700.0,
      'interestRate': 18.0,
      'auctionDate': '2024-06-20',
      'redemptionDeadline': '2025-06-20',
      'status': 'available',
    },
  ];

  final List<Map<String, dynamic>> _mockMyLiens = [
    {
      'id': 'TL001',
      'parcelId': 'R00051-000',
      'owner': 'John Smith',
      'address': '123 Main St, Columbia, FL 32025',
      'county': 'Columbia',
      'state': 'FL',
      'assessedValue': 85000.0,
      'taxAmount': 1250.0,
      'interestRate': 18.0,
      'auctionDate': '2024-01-15',
      'redemptionDeadline': '2025-01-15',
      'status': 'sold',
      'salePrice': 1250.0,
      'buyerId': 'user123',
    },
    {
      'id': 'TL002',
      'parcelId': '340913449600000040',
      'owner': 'Mary Johnson',
      'address': '456 Oak Ave, Dixie, FL 32329',
      'county': 'Dixie',
      'state': 'FL',
      'assessedValue': 120000.0,
      'taxAmount': 1800.0,
      'interestRate': 18.0,
      'auctionDate': '2024-02-20',
      'redemptionDeadline': '2025-02-20',
      'status': 'sold',
      'salePrice': 1800.0,
      'buyerId': 'user123',
    },
    {
      'id': 'TL003',
      'parcelId': 'L00001-000',
      'owner': 'Robert Wilson',
      'address': '789 Pine Rd, Lafayette, FL 32060',
      'county': 'Lafayette',
      'state': 'FL',
      'assessedValue': 95000.0,
      'taxAmount': 1425.0,
      'interestRate': 18.0,
      'auctionDate': '2024-03-10',
      'redemptionDeadline': '2025-03-10',
      'status': 'sold',
      'salePrice': 1425.0,
      'buyerId': 'user123',
    },
    {
      'id': 'TL004',
      'parcelId': 'P00001-000',
      'owner': 'Sarah Davis',
      'address': '321 Elm St, Polk, FL 33801',
      'county': 'Polk',
      'state': 'FL',
      'assessedValue': 150000.0,
      'taxAmount': 2250.0,
      'interestRate': 18.0,
      'auctionDate': '2024-04-05',
      'redemptionDeadline': '2025-04-05',
      'status': 'sold',
      'salePrice': 2250.0,
      'buyerId': 'user123',
    },
  ];

  List<TaxLien> get availableLiens => _availableLiens;
  List<TaxLien> get myLiens => _myLiens;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initialize() async {
    await loadAvailableLiens();
    await loadMyLiens();
  }

  Future<void> loadAvailableLiens() async {
    _setLoading(true);
    try {
      // For prototype, we'll use mock data
      await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
      
      _availableLiens = _mockAvailableLiens.map((json) => TaxLien.fromJson(json)).toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to load available liens: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadMyLiens() async {
    _setLoading(true);
    try {
      // For prototype, we'll use mock data
      await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
      
      _myLiens = _mockMyLiens.map((json) => TaxLien.fromJson(json)).toList();
      _error = null;
    } catch (e) {
      _error = 'Failed to load my liens: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> purchaseLien(String lienId, double bidAmount) async {
    _setLoading(true);
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/tax-liens/$lienId/purchase'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'bidAmount': bidAmount}),
      );

      if (response.statusCode == 200) {
        await loadAvailableLiens();
        await loadMyLiens();
        _error = null;
        return true;
      } else {
        _error = 'Failed to purchase lien';
        return false;
      }
    } catch (e) {
      _error = 'Network error: $e';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<List<TaxLien>> searchLiens({
    String? county,
    String? state,
    double? minAmount,
    double? maxAmount,
    double? minInterestRate,
  }) async {
    try {
      final queryParams = <String, String>{};
      if (county != null) queryParams['county'] = county;
      if (state != null) queryParams['state'] = state;
      if (minAmount != null) queryParams['minAmount'] = minAmount.toString();
      if (maxAmount != null) queryParams['maxAmount'] = maxAmount.toString();
      if (minInterestRate != null) queryParams['minInterestRate'] = minInterestRate.toString();

      final uri = Uri.parse('$_baseUrl/api/tax-liens/search').replace(queryParameters: queryParams);
      final response = await http.get(uri, headers: {'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => TaxLien.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search liens');
      }
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
