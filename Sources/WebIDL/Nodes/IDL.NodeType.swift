extension IDL
{
    @frozen public
    enum NodeType:String
    {
        case argument
        case attribute
        case callback
        case callback_interface = "callback interface"
        case const
        case constructor
        case dictionary
        case `enum`
        case iterable
        case includes
        case interface
        case interface_mixin = "interface mixin"
        case maplike
        case namespace
        case operation
        case setlike
        case typedef
    }
}
