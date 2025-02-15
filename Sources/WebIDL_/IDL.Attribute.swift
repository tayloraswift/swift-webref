import JSON

extension IDL
{
    @frozen public
    struct Attribute
    {
        public
        let name:String
        public
        let type:Metatype
        public
        let special:String
        public
        let readonly:Bool
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Attribute:IDL.NominalNode, IDL.InterfaceMember
{
    @inlinable public
    static var type:IDL.NodeType { .attribute }
}
extension IDL.Attribute:JSONObjectDecodable
{
    public
    enum CodingKeys:String, Sendable
    {
        case name
        case idlType
        case special
        case readonly
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKeys>) throws
    {
        self.init(
            name: try json[.name].decode(),
            type: try json[.idlType].decode(),
            special: try json[.special].decode(),
            readonly: try json[.readonly].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
