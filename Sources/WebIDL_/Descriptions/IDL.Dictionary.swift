import JSON

extension IDL
{
    @frozen public
    struct Dictionary
    {
        public
        let name:String
        public
        let members:[Member]
        public
        let partial:Bool
        public
        let inheritance:String?
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Dictionary:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .dictionary }
}
extension IDL.Dictionary:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case members
        case partial
        case inheritance
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            members: try json[.members].decode(),
            partial: try json[.partial].decode(),
            inheritance: try json[.inheritance].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
