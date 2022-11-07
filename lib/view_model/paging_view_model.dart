import 'package:flutter/material.dart';

import '../model/paging_product.dart';
import '../model/paging_product_repository.dart';

final PagingProductRepository pagingProductRepository =
    PagingProductRepository();

List<PagingProduct> populateData() {
  final List<PagingProduct> pagingProducts = [];
  var index = 0;
  for (int i = 0; i < pagingProductRepository.names.length; i++) {
    // if (index == 21) index = 0;

    var p = PagingProduct(
        name: pagingProductRepository.names[i],
        price: pagingProductRepository.prices[i],
        offer: pagingProductRepository.offer[i],
        ratings: pagingProductRepository.ratings[i],
        reviewValue: pagingProductRepository.reviewValue[i],
        weight: pagingProductRepository.weights[i]);

    index++;
    pagingProducts.add(p);
  }

  return pagingProducts;
}
