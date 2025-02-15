import JSON

extension IDL
{
    @frozen public
    struct Constructor
    {
        public
        let arguments:[Argument]
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Constructor:IDL.SyntaxNode, IDL.InterfaceMember
{
    @inlinable public
    static var type:IDL.NodeType { .constructor }
}
extension IDL.Constructor:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case arguments
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            arguments: try json[.arguments].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
