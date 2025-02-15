import JSON

extension [any IDL.InterfaceMember]
{
    static func decode(from json:JSON.OptionalDecoder<some Any>) throws -> Self
    {
        try json.decode(as: JSON.Array.self)
        {
            try $0.map
            {
                let node:IDL.AnyNode = try $0.decode()

                guard case let member as any IDL.InterfaceMember = node.cast
                else
                {
                    throw IDL.NodeCastError.init(
                        type: type(of: node.cast).type,
                        cast: (any IDL.InterfaceMember).self)
                }

                return member
            }
        }
    }
}

import JSON

extension IDL
{
    @frozen public
    struct Argument
    {
        public
        let name:String
        public
        let metatype:Metatype
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
    enum CodingKeys:String, Sendable
    {
        case name
        case idlType
        case optional
        case variadic
        case `default`
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKeys>) throws
    {
        self.init(name: try json[.name].decode(),
            metatype: try json[.idlType].decode(),
            optional: try json[.optional].decode(),
            variadic: try json[.variadic].decode(),
            default: try json[.default].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
