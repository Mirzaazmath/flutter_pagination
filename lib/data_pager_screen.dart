

import 'package:flutter/material.dart';
import 'package:pager/pager.dart';

class Temparaoty extends StatefulWidget {
  const Temparaoty({Key? key}) : super(key: key);

  @override
  _TemparaotyState createState() => _TemparaotyState();
}

class _TemparaotyState extends State<Temparaoty> {
  late int _currentPage;
  late int _itemsPerPage;
  List<Widget> listitems = [];
  List<Widget> newList = [];
  List<int> pages = [5, 10, 18, 50, 100];
  late int _totalPages;
  int _totalElements = 10;
  @override
  void initState() {
    super.initState();
    _currentPage = 1;
    _itemsPerPage = pages.first;
    _totalPages = (_totalElements / _itemsPerPage).ceil();
    rowdata();
  }

  void rowdata() {
    for (int i = 0; i < 41; i++) {
      listitems.add(Text("Number is $i"));
    }
    setState(() {
      _totalElements = listitems.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.blue,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: rowej(_currentPage)),
            ),
            const SizedBox(height: 32),
            FittedBox(
              child: Pager(
                currentItemsPerPage: _itemsPerPage,
                currentPage: _currentPage,
                totalPages: _totalPages,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                showItemsPerPage: true,
                onItemsPerPageChanged: (itemsPerPage) {
                  setState(() {
                    _itemsPerPage = itemsPerPage;
                    _totalPages = (_totalElements / _itemsPerPage).ceil();
                    _currentPage = 1;
                  });
                },
                itemsPerPageList: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> rowej(var page) {
    int pageindex = page == 1 ? 0 : page - 1;

    print(pageindex);
    int startRowIndex = pageindex * _itemsPerPage;
    int endRowIndex = startRowIndex + _itemsPerPage;

    if (endRowIndex > listitems.length) {
      endRowIndex = listitems.length;
    }

    newList = listitems.getRange(startRowIndex, endRowIndex).toList();
    return newList;
  }
}













//this is another way of doing it


// import 'package:flutter/material.dart';
// import 'package:list_patination/view_model/paging_view_model.dart';
//
// import 'model/paging_product.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
//
// class DataPagerWithListView extends StatefulWidget {
//   @override
//   _DataPagerWithListView createState() => _DataPagerWithListView();
// }
//
// List<PagingProduct> _paginatedProductData = [];
//
// class CustomSliverChildBuilderDelegate extends SliverChildBuilderDelegate
//     with DataPagerDelegate, ChangeNotifier {
//   CustomSliverChildBuilderDelegate(builder) : super(builder);
//
//   @override
//   bool shouldRebuild(covariant CustomSliverChildBuilderDelegate oldDelegate) {
//     return true;
//   }
//
//   @override
//   int get childCount => _paginatedProductData.length;
//
//   @override
//   Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
//     int startRowIndex = newPageIndex * rowsPerPage;
//     int endRowIndex = startRowIndex + rowsPerPage;
//
//     if (endRowIndex > _products.length) {
//       endRowIndex = _products.length - 1;
//     }
//
//     await Future.delayed(Duration(milliseconds: 2000));
//     _paginatedProductData =
//         _products.getRange(startRowIndex, endRowIndex).toList(growable: false);
//     notifyListeners();
//     return true;
//   }
// }



// List<PagingProduct> _products = [];
//
// int rowsPerPage = 10;
//
// class _DataPagerWithListView extends State<DataPagerWithListView> {
//   static const double dataPagerHeight = 70.0;
//   bool showLoadingIndicator = false;
//   double pageCount = 0;
//   @override
//   void initState() {
//     super.initState();
//     _products = List.from(populateData());
//     pageCount = (_products.length / rowsPerPage).ceilToDouble();
//   }
//
//   void rebuildList() {
//     setState(() {});
//   }
//
//   Widget loadListView(BoxConstraints constraints) {
//     List<Widget> _getChildren() {
//       final List<Widget> stackChildren = [];
//
//       if (_products.isNotEmpty) {
//         stackChildren.add(ListView.custom(
//             childrenDelegate: CustomSliverChildBuilderDelegate(indexBuilder)));
//       }
//
//       if (showLoadingIndicator) {
//         stackChildren.add(Container(
//           color: Colors.black12,
//           width: constraints.maxWidth,
//           height: constraints.maxHeight,
//           child: const Align(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(
//               strokeWidth: 3,
//             ),
//           ),
//         ));
//       }
//       return stackChildren;
//     }
//
//     return Stack(
//       children: _getChildren(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: SafeArea(
//         bottom: true,
//         top: false,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text('Fruits'),
//           ),
//           body: LayoutBuilder(builder: (context, constraint) {
//             return Column(
//               children: [
//                 Container(
//                   height: constraint.maxHeight - dataPagerHeight,
//                   child: loadListView(constraint),
//                 ),
//                 Container(
//                   height: dataPagerHeight,
//                   child: SfDataPagerTheme(
//                       data: SfDataPagerThemeData(
//                         itemBorderRadius: BorderRadius.circular(5),
//                       ),
//                       child: SfDataPager(
//                           pageCount: pageCount,
//                           onPageNavigationStart: (pageIndex) {
//                             setState(() {
//                               showLoadingIndicator = true;
//                             });
//                           },
//                           onPageNavigationEnd: (pageIndex) {
//                             setState(() {
//                               showLoadingIndicator = false;
//                             });
//                           },
//                           delegate:
//                               CustomSliverChildBuilderDelegate(indexBuilder)
//                                 ..addListener(rebuildList))),
//                 )
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//   Widget indexBuilder(BuildContext context, int index) {
//     final PagingProduct data = _paginatedProductData[index];
//     return ListTile(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       title: LayoutBuilder(
//         builder: (context, constraint) {
//           return Container(
//               width: constraint.maxWidth,
//               height: 100,
//               child: Row(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.fromLTRB(20, 10, 5, 5),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Container(
//                           width: constraint.maxWidth - 130,
//                           child: Text(data.name!,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black87,
//                                   fontSize: 15)),
//                         ),
//                         Container(
//                           width: constraint.maxWidth - 130,
//                           child: Text(data.weight!,
//                               style: TextStyle(
//                                   color: Colors.black87, fontSize: 10)),
//                         ),
//                         Container(
//                           width: constraint.maxWidth - 130,
//                           child: Row(
//                             children: [
//                               Container(
//                                 color: Colors.green.shade900,
//                                 padding: EdgeInsets.all(3),
//                                 child: Row(
//                                   children: [
//                                     Text('${data.reviewValue}',
//                                         textAlign: TextAlign.end,
//                                         style: TextStyle(
//                                             color: Colors.white, fontSize: 13)),
//                                     SizedBox(width: 2),
//                                     Icon(
//                                       Icons.star,
//                                       color: Colors.white,
//                                       size: 15,
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 5),
//                               Text('${data.ratings}',
//                                   textAlign: TextAlign.end,
//                                   style: TextStyle(
//                                       color: Colors.black87, fontSize: 11))
//                             ],
//                           ),
//                         ),
//                         Container(
//                           width: constraint.maxWidth - 130,
//                           child: Row(
//                             children: [
//                               Container(
//                                 child: Text('\$${data.price}',
//                                     style: TextStyle(
//                                         color: Colors.green.shade800,
//                                         fontSize: 13)),
//                               ),
//                               SizedBox(width: 8),
//                               Text('${data.offer}',
//                                   style: TextStyle(
//                                       color: Colors.black87, fontSize: 10))
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ));
//         },
//       ),
//     );
//   }
// }
