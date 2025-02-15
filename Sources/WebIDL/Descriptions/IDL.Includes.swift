import JSON

extension IDL
{
    @frozen public
    struct Includes
    {
        public
        let target:String
        public
        let includes:String
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Includes:IDL.SyntaxNode
{
    @inlinable public
    static var type:IDL.NodeType { .includes }
}
extension IDL.Includes:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case target
        case includes
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            target: try json[.target].decode(),
            includes: try json[.includes].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
