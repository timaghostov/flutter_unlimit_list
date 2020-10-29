

import 'package:unlimit_list/model/aitem.dart';
import 'package:unlimit_list/model/error.dart';
import 'package:unlimit_list/model/indicator.dart';
import 'package:unlimit_list/model/json/person.dart';


class ListState {
    List<AItem> _list;
    

    ListState() {
        _list = new List();
    }

    void addPerson( Person person ) {
        this._list.add(person);
    }

    void addLoadIndicator( LoadIndicator loadIndicator ) {
        this._list.add( loadIndicator );
    }

    void addError( Error error ) {
        this._list.add( error );
    }

    // void remove(Object object) {
    //     this._list.remove(object);
    // }

    void removeIndicator() {
        this._list.removeWhere((element) => (element.dataType == ItemType.Indicator) );
    }

    void removeError() {
        this._list.removeWhere((element) => (element.dataType == ItemType.Error) );
    }

    void removeAt(int index) {
        this._list.removeAt(index);
    }

    void addPersonList( List<Person> list ) {
        this._list.addAll(list);
    }

    int size() {
        return _list.length;
    }

    AItem item( int index ) {
        return index < size() ? _list[index] : null;
    }
}