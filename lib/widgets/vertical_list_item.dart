


import 'package:isolate_bloc/isolate_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unlimit_list/bloc/head_index_bloc.dart';
import 'package:unlimit_list/bloc/stack_bloc.dart';
import 'package:unlimit_list/model/aitem.dart';
import 'package:unlimit_list/model/event/show_person.dart';
import 'package:unlimit_list/model/event/update_current_index.dart';
import 'package:unlimit_list/model/json/person.dart';
import 'package:unlimit_list/model/state/head_index_state.dart';
import 'package:unlimit_list/model/state/stack_state.dart';
import 'package:unlimit_list/widgets/error.dart';
import 'package:unlimit_list/widgets/indicator.dart';
import 'package:unlimit_list/widgets/alimit_list_item.dart';

class VerticalItem extends AUnlimitListItem {

    const VerticalItem( {Function onCreate, int index, AItem itemData } ) : super(onCreate, index, itemData);

    @override
    _VerticalListItemState createState() => _VerticalListItemState();

}

class _VerticalListItemState extends AUnlimitListItemState {

    double _height = 100;

    Widget listItem( Widget child ) {
        return Container(
            height: _height,
            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                    BoxShadow(
                        color: Colors.grey[600],
                    ),
                ],
            ),
            child: child,
            alignment: Alignment.center,
        );
    }

    @override
    Widget buildIndicator() {
        // print("buildIndicator");
        return listItem( new Indicator() );
    }

    @override
    Widget buildError() {
        // print("buildError");        
        return listItem( new ErrorItem() );
    }

    @override
    Widget buildPerson( BuildContext context ) {
        // print("buildPerson");
        Person person = widget.itemData;
        return listItem(
            InkWell(
                onTap: () {
                    // print('person :: ${widget.index} :: $person');
                    IsolateBlocProvider.of<HeadIndexStateBloc, HeadIndexState>(context)
                        .add( UpdateCurrentIndex( widget.index ) );
                    IsolateBlocProvider.of<StackBloc, StackState>(context)
                        .add( ShowPerson( widget.index ) );
                },
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                        children: [
                            CachedNetworkImage(
                                height: _height * 0.8,
                                imageUrl: person.photo.large,
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
                            Flexible(
                                fit: FlexFit.tight,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                    ),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                '${person.name}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18
                                                ),
                                                overflow: TextOverflow.fade,
                                                maxLines: 1,
                                                softWrap: false,
                                            ),
                                            Flexible(
                                                child: Container(
                                                    padding: EdgeInsets.only(top: 5),
                                                    child: Text(
                                                        '${person.address}',
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 14
                                                        ),
                                                        overflow: TextOverflow.ellipsis,
                                                        maxLines: 3,
                                                        // softWrap: false,
                                                    ),
                                                ),
                                            )
                                        ],
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            )
        );
    }

}