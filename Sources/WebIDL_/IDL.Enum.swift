import JSON

extension IDL
{
    @frozen public
    struct Enum
    {
        public
        let name:String
        public
        let cases:[String]
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Enum:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .enum }
}
extension IDL.Enum:JSONObjectDecodable
{
    public
    enum CodingKeys:String, Sendable
    {
        case name
        case values
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKeys>) throws
    {
        self.init(name: try json[.name].decode(),
            cases: try json[.values].decode(to: [IDL.ValueNest].self).map(\.value),
            extAttrs: try json[.extAttrs].decode())
    }
}
