

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unlimit_list/model/aitem.dart';
import 'package:unlimit_list/model/json/person.dart';
import 'package:unlimit_list/service/constant.dart';
import 'package:unlimit_list/widgets/error.dart';
import 'package:unlimit_list/widgets/indicator.dart';
import 'package:unlimit_list/widgets/alimit_list_item.dart';




class HorizontalItem extends AUnlimitListItem {

    final double width;

    const HorizontalItem( this.width, {Function onCreate, int index, AItem itemData} ) : super(onCreate, index, itemData);

    @override
    _HorizontalListItemState createState() => _HorizontalListItemState();

}

class _HorizontalListItemState extends AUnlimitListItemState {    

    static Widget listItem( Widget child, double width, int index ) {
        
        double marginLeft = width * ( 1.0 - CARD_COEF_WIDTH ) * 0.125;
        double marginRight = marginLeft;
        return Container(
            margin: EdgeInsets.only(
                top: 5,
                bottom: 5,
                left: marginLeft,
                right: marginRight
            ),
            width: width * CARD_COEF_WIDTH,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
            ),
            child: child,
        );
    }

    @override
    Widget buildIndicator() {
        return listItem(
            Center(
                child: Indicator(),
            ),
            (widget as HorizontalItem).width,
            widget.index,
        );
    }

    @override
    Widget buildError() {
        return listItem(
            ErrorItem(),
            (widget as HorizontalItem).width,
            widget.index,
        );
    }

    @override
    Widget buildPerson( BuildContext context ) {
        
        double width = (widget as HorizontalItem).width;
        Person person = widget.itemData;

        double paddingName = 15.0;

        TextStyle metaHeadStyle = TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
        );

        TextStyle metaDataStyle = TextStyle(
            fontSize: 18,
            color: Colors.grey[700]
        );

        Widget child = Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        imageUrl: person.photo.large,
                        imageBuilder: (context, imageProvider) => Container(
                            // height: 100,
                            // width: 100,
                            height: width * CARD_COEF_WIDTH,
                            width: width * CARD_COEF_WIDTH,
                            decoration: BoxDecoration(
                                // borderRadius: BorderRadius.all(Radius.circular(50)),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                ),
                            ),
                        ),
                        placeholder: (context, url) => Center(
                            child: Container(
                                child: SizedBox(
                                    height: 36.0,
                                    width: 36.0,
                                    child: CircularProgressIndicator()
                                ),
                            ),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        
                    ),
                    Container(
                        width: double.infinity,
                        color: Colors.white,
                        padding: EdgeInsets.all(paddingName),
                        child: Text(
                            '${person.name}',
                            style: metaHeadStyle,
                        ),
                    ),
                    Flexible(
                        fit: FlexFit.tight,
                        child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(paddingName),
                            decoration: BoxDecoration(
                                color: Colors.grey[50],
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                ),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                'Address:',
                                                style: metaHeadStyle,
                                            ),
                                            Text(
                                                '${person.address}',
                                                style: metaDataStyle,
                                            ),
                                        ],
                                    ),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                'Email:',
                                                style: metaHeadStyle,
                                            ),
                                            Text(
                                                '${person.email}',
                                                style: metaDataStyle,
                                            ),
                                        ],
                                    ),
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                'Phone:',
                                                style: metaHeadStyle,
                                            ),
                                            Text(
                                                '${person.phone}',
                                                style: metaDataStyle,
                                            ),
                                        ],
                                    )
                                ],
                            ),
                        ),
                    )
                ],
            ),
        );
        return listItem(
            child,
            (widget as HorizontalItem).width,
            widget.index,
        );
        // return listItem( Text( "H :: Person" ) );
    }

    // @override
    // void deactivate() { 
    //     super.deactivate();
    //     print('deactivate :: ${widget.index}');
    // }

    // @override
    // void didChangeDependencies() { 
    //     super.didChangeDependencies();
    //     print('didChangeDependencies :: ${widget.index}');
    // }

    // @override
    // void didUpdateWidget(Widget oldWidget) {
    //     print('didUpdateWidget :: ${widget.index}');
    //     super.didUpdateWidget(oldWidget);
        
    // }

}