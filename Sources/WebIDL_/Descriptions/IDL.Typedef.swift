import JSON

extension IDL
{
    @frozen public
    struct Typedef
    {
        public
        let name:String
        public
        let type:TypeMetadata
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Typedef:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .typedef }
}
extension IDL.Typedef:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case idlType
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            type: try json[.idlType].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
