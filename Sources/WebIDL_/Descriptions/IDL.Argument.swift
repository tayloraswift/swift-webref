import JSON

extension IDL
{
    @frozen public
    struct Argument
    {
        public
        let name:String
        public
        let type:TypeMetadata
        public
        let optional:Bool
        public
        let variadic:Bool
        public
        let `default`:ValueExpression?
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Argument:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .argument }
}
extension IDL.Argument:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case idlType
        case optional
        case variadic
        case `default`
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            type: try json[.idlType].decode(),
            optional: try json[.optional].decode(),
            variadic: try json[.variadic].decode(),
            default: try json[.default].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
