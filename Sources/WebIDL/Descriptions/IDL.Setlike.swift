import JSON

extension IDL
{
    @frozen public
    struct Setlike
    {
        public
        let types:[TypeMetadata]
        public
        let readonly:Bool
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Setlike:IDL.SyntaxNode, IDL.InterfaceMember, IDL.Declaration
{
    @inlinable public
    static var type:IDL.NodeType { .setlike }
}
extension IDL.Setlike:JSONObjectDecodable
{
    public
    init(json:JSON.ObjectDecoder<IDL.DeclarationCodingKey>) throws
    {
        let _:[Never] = try json[.arguments].decode()
        self.init(types: try json[.idlType].decode(),
            readonly: try json[.readonly].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
