import JSON

extension IDL
{
    @frozen public
    struct Operation
    {
        public
        let name:String
        public
        let type:Metatype?
        public
        let special:String
        public
        let arguments:[Argument]
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Operation:IDL.NominalNode, IDL.InterfaceMember
{
    @inlinable public
    static var type:IDL.NodeType { .operation }
}
extension IDL.Operation:JSONObjectDecodable
{
    public
    enum CodingKeys:String, Sendable
    {
        case name
        case idlType
        case special
        case arguments
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKeys>) throws
    {
        self.init(
            name: try json[.name].decode(),
            type: try json[.idlType].decode(),
            special: try json[.special].decode(),
            arguments: try json[.arguments].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
