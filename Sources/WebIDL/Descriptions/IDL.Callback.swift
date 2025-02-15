import JSON

extension IDL
{
    @frozen public
    struct Callback
    {
        public
        let name:String
        public
        let type:TypeMetadata
        public
        let arguments:[Argument]
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Callback:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .callback }
}
extension IDL.Callback:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case idlType
        case arguments
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            type: try json[.idlType].decode(),
            arguments: try json[.arguments].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
