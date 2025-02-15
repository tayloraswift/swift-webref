import JSON

extension IDL
{
    /// https://github.com/w3c/webidl2.js#interface
    @frozen public
    struct Interface
    {
        public
        let name:String
        public
        let members:[any InterfaceMember]
        public
        let partial:Bool
        public
        let inheritance:String?
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Interface:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .interface }
}
extension IDL.Interface:JSONObjectDecodable
{
    public
    init(json:JSON.ObjectDecoder<IDL.InterfaceCodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            members: try .decode(from: json[.members]),
            partial: try json[.partial].decode(),
            inheritance: try json[.inheritance].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
