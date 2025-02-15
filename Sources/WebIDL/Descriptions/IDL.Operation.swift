import JSON

extension IDL
{
    @frozen public
    struct Operation
    {
        public
        let name:String
        public
        let type:TypeMetadata?
        public
        let special:String
        public
        let arguments:[Argument]
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Operation:IDL.NominalNode, IDL.InterfaceMember, IDL.NamespaceMember
{
    @inlinable public
    static var type:IDL.NodeType { .operation }
}
extension IDL.Operation:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case idlType
        case special
        case arguments
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            type: try json[.idlType]?.decode(),
            special: try json[.special].decode(),
            arguments: try json[.arguments].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
