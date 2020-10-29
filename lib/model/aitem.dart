



enum ItemType {
    Indicator,
    Error,
    Person
}

abstract class AItem {
    ItemType _dataType;

    AItem( this._dataType );

    ItemType get dataType => _dataType;
}