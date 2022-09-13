import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:muroexe_store/src/core/constants/app_color.dart';
import 'package:stacked/stacked.dart';
import 'home_screen_viewmodel.dart';

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
        viewModelBuilder: () => HomeScreenViewModel(),
        disposeViewModel: false,
        onModelReady: (model) => model.limitedProducts(),
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Colors.grey.shade50, //Muroexe.mainColor,

            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.grey.shade100,
              actions: [
                IconButton(
                  onPressed: () => model.navigateToSignIn(),
                  padding: const EdgeInsets.only(right: 5),
                  icon: Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.grey.shade900,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
              title: RichText(
                overflow: TextOverflow.fade,
                text: TextSpan(
                    text: 'M U R O ',
                    style: TextStyle(
                        fontSize: 25,
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.w900,
                        color: Colors.grey.shade900,
                        letterSpacing: 3.0),
                    children: [
                      TextSpan(
                        text: 'E X E',
                        style: TextStyle(
                            overflow: TextOverflow.fade,
                            color: Colors.grey.shade800,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 3),
                      ),
                    ]),
              ),
              centerTitle: true,
              automaticallyImplyLeading: false,
            ),
            body: ListView(
              children: [
                const Divider(
                  thickness: 2,
                ),
                Center(
                  child: Text(
                    model.advertText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                model.hasError
                    ? Center(child: Text(model.networkErrorText))
                    : model.singleProductLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                        : model.product == null
                            ? Center(child: Text(model.networkErrorText))
                            : Stack(
                                children: [
                                  Image.network(
                                    model.product!.image!,
                                    filterQuality: FilterQuality.high,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                        blurRadius: 0.30,
                                        color: Colors.purple.shade100
                                            .withOpacity(0.1),
                                        spreadRadius: 0.90,
                                      )
                                    ]),
                                    padding: const EdgeInsets.all(24.0),
                                    child: RichText(
                                      text: TextSpan(
                                          text: 'EXTRA',
                                          style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.grey.shade800,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: '\nSALES\n',
                                              style: TextStyle(
                                                fontSize: 60,
                                                color: Colors.grey.shade200,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Up to 60%',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.grey.shade800,
                                              ),
                                            ),
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                Center(
                  heightFactor: 2.0,
                  child: Text(
                    'FEATURED PRODUCTS',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade900,
                    ),
                  ),
                ),
                model.hasError
                    ? Center(child: Text(model.networkErrorText))
                    : model.limitedProductLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ))
                        : model.limitedProductData == null
                            ? Center(child: Text(model.networkErrorText))
                            : GridView.builder(
                                itemCount:
                                    4, //model.limitedProductData!.length,
                                shrinkWrap: true,
                                //addRepaintBoundaries: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisExtent: 300,
                                ),
                                itemBuilder: (_, index) => Container(
                                  height: 350,
                                  width: 150,
                                  decoration: const BoxDecoration(
                                    color: Colors.white, //Colors.grey.shade200,
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Image.network(
                                            model.limitedProductData![index]
                                                .image
                                                .toString(),
                                            height: 200,
                                            width: 250,
                                            alignment: Alignment.center,
                                            fit: BoxFit.contain,
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 30,
                                              width: 40,
                                              color: Colors.red.shade700,
                                              alignment: Alignment.center,
                                              child: const Text(
                                                '60%',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.grey.shade800,
                                                size: 30,
                                              )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 6.0, horizontal: 12),
                                        child: Text(
                                          model.limitedProductData![index].title
                                              .toString(),
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                            text:
                                                '\$${model.limitedProductData![index].price.toString()} ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                overflow: TextOverflow.fade,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.red
                                                    .shade800 //Colors.grey.shade800,
                                                ),
                                            children: [
                                              TextSpan(
                                                  text: '\$99.00',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                  ))
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }
}
