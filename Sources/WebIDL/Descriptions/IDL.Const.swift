import JSON

extension IDL
{
    @frozen public
    struct Const
    {
        public
        let name:String
        public
        let type:TypeMetadata
        public
        let value:ValueExpression?
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Const:IDL.NominalNode, IDL.InterfaceMember, IDL.NamespaceMember
{
    @inlinable public
    static var type:IDL.NodeType { .const }
}
extension IDL.Const:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case idlType
        case value
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(name: try json[.name].decode(),
            type: try json[.idlType].decode(),
            value: try json[.value].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
