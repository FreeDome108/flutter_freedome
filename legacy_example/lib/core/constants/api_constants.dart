class ApiConstants {
  // Base URLs
  static const String baseUrl = 'https://taxlien.online';
  static const String apiV1 = '$baseUrl/rest/V1';
  static const String graphqlEndpoint = '$baseUrl/graphql';
  
  // Authentication Endpoints
  static const String loginEndpoint = '$apiV1/integration/customer/token';
  static const String registerEndpoint = '$apiV1/customers';
  static const String refreshTokenEndpoint = '$apiV1/integration/customer/token/refresh';
  static const String logoutEndpoint = '$apiV1/customers/me/logout';
  static const String forgotPasswordEndpoint = '$apiV1/customers/password';
  
  // Customer Endpoints
  static const String customerInfoEndpoint = '$apiV1/customers/me';
  static const String updateCustomerEndpoint = '$apiV1/customers/me';
  static const String customerAddressesEndpoint = '$apiV1/customers/me/addresses';
  
  // Product Endpoints
  static const String productsEndpoint = '$apiV1/products';
  static const String productSearchEndpoint = '$apiV1/search';
  static const String categoriesEndpoint = '$apiV1/categories';
  static const String productMediaEndpoint = '$apiV1/products/{sku}/media';
  
  // Cart Endpoints
  static const String createCartEndpoint = '$apiV1/carts/mine';
  static const String cartEndpoint = '$apiV1/carts/mine';
  static const String addToCartEndpoint = '$apiV1/carts/mine/items';
  static const String updateCartItemEndpoint = '$apiV1/carts/mine/items/{itemId}';
  static const String removeCartItemEndpoint = '$apiV1/carts/mine/items/{itemId}';
  static const String cartTotalsEndpoint = '$apiV1/carts/mine/totals';
  
  // Checkout Endpoints
  static const String shippingInformationEndpoint = '$apiV1/carts/mine/shipping-information';
  static const String paymentInformationEndpoint = '$apiV1/carts/mine/payment-information';
  static const String placeOrderEndpoint = '$apiV1/carts/mine/order';
  static const String shippingMethodsEndpoint = '$apiV1/carts/mine/shipping-methods';
  static const String paymentMethodsEndpoint = '$apiV1/carts/mine/payment-methods';
  
  // Order Endpoints
  static const String ordersEndpoint = '$apiV1/orders';
  static const String customerOrdersEndpoint = '$apiV1/orders/mine';
  static const String orderByIdEndpoint = '$apiV1/orders/{orderId}';
  static const String orderStatusEndpoint = '$apiV1/orders/{orderId}/status';
  
  // Wishlist Endpoints
  static const String wishlistEndpoint = '$apiV1/wishlists/mine';
  static const String addToWishlistEndpoint = '$apiV1/wishlists/mine/items';
  static const String removeFromWishlistEndpoint = '$apiV1/wishlists/mine/items/{itemId}';
  
  // Tax Lien Specific Endpoints (Custom API)
  static const String taxLiensEndpoint = '$apiV1/tax-liens';
  static const String taxLienByIdEndpoint = '$apiV1/tax-liens/{id}';
  static const String taxLienSearchEndpoint = '$apiV1/tax-liens/search';
  static const String taxLienFiltersEndpoint = '$apiV1/tax-liens/filters';
  static const String propertyInfoEndpoint = '$apiV1/properties/{propertyId}';
  static const String countyInfoEndpoint = '$apiV1/counties/{countyId}';
  static const String riskAssessmentEndpoint = '$apiV1/risk-assessment/{propertyId}';
  
  // GraphQL Queries
  static const String productQuery = '''
    query GetProducts(\$search: String, \$filter: ProductAttributeFilterInput, \$pageSize: Int, \$currentPage: Int) {
      products(search: \$search, filter: \$filter, pageSize: \$pageSize, currentPage: \$currentPage) {
        total_count
        items {
          id
          name
          sku
          price_range {
            minimum_price {
              regular_price {
                value
                currency
              }
              final_price {
                value
                currency
              }
            }
          }
          image {
            url
            label
          }
          small_image {
            url
            label
          }
          thumbnail {
            url
            label
          }
          description {
            html
          }
          short_description {
            html
          }
          stock_status
          categories {
            id
            name
            url_path
          }
          custom_attributes {
            attribute_code
            value
          }
        }
        page_info {
          current_page
          page_size
          total_pages
        }
        aggregations {
          attribute_code
          label
          options {
            label
            value
            count
          }
        }
      }
    }
  ''';
  
  static const String categoryQuery = '''
    query GetCategories {
      categoryList {
        id
        name
        url_path
        image
        children {
          id
          name
          url_path
          image
          children_count
        }
        children_count
        product_count
      }
    }
  ''';
  
  static const String customerQuery = '''
    query GetCustomer {
      customer {
        id
        firstname
        lastname
        email
        addresses {
          id
          firstname
          lastname
          street
          city
          region {
            region_code
            region
          }
          postcode
          country_code
          telephone
          default_shipping
          default_billing
        }
      }
    }
  ''';
  
  static const String cartQuery = '''
    query GetCart {
      cart {
        id
        email
        total_quantity
        items {
          id
          product {
            id
            name
            sku
            image {
              url
              label
            }
            price_range {
              minimum_price {
                regular_price {
                  value
                  currency
                }
                final_price {
                  value
                  currency
                }
              }
            }
          }
          quantity
          prices {
            price {
              value
              currency
            }
            total_item_discount {
              value
              currency
            }
            row_total {
              value
              currency
            }
          }
        }
        prices {
          grand_total {
            value
            currency
          }
          subtotal_excluding_tax {
            value
            currency
          }
          subtotal_including_tax {
            value
            currency
          }
          applied_taxes {
            amount {
              value
              currency
            }
            label
          }
          discounts {
            amount {
              value
              currency
            }
            label
          }
        }
      }
    }
  ''';
  
  // Headers
  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  static const Map<String, String> graphqlHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Error Codes
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int serverError = 500;
  static const int badGateway = 502;
  static const int serviceUnavailable = 503;
}
