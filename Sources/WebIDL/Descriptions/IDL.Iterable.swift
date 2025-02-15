import JSON

extension IDL
{
    @frozen public
    struct Iterable
    {
        public
        let arguments:[Argument]
        public
        let types:[TypeMetadata]
        public
        let async:Bool
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Iterable:IDL.SyntaxNode, IDL.InterfaceMember, IDL.Declaration
{
    @inlinable public
    static var type:IDL.NodeType { .iterable }
}
extension IDL.Iterable:JSONObjectDecodable
{
    public
    init(json:JSON.ObjectDecoder<IDL.DeclarationCodingKey>) throws
    {
        self.init(
            arguments: try json[.arguments].decode(),
            types: try json[.idlType].decode(),
            async: try json[.async].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
