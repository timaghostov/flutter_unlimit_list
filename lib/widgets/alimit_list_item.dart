


import 'package:flutter/cupertino.dart';
import 'package:unlimit_list/model/aitem.dart';

abstract class AUnlimitListItem extends StatefulWidget {

    final Function onCreate;
    final int index;
    final AItem itemData;

    const AUnlimitListItem( this.onCreate, this.index, this.itemData, {Key key} ) : super(key: key);

}

abstract class AUnlimitListItemState extends State<AUnlimitListItem> {

    @override
    void initState() {
        super.initState();
        if (widget.onCreate != null) {
            widget.onCreate();
        }
    }

    @override
    Widget build(BuildContext context) {
        switch(widget.itemData.dataType) {
            case ItemType.Indicator: { 
                return buildIndicator();
            } 
            break;
            case ItemType.Error: { 
                return buildError();
            } 
            break;
            case ItemType.Person: { 
                return buildPerson(context);
            } 
            break;
            default: {
                return null;
            }
            break;
        }        
    }

    @protected
    Widget buildIndicator();

    @protected
    Widget buildError();

    @protected
    Widget buildPerson(BuildContext context);

}