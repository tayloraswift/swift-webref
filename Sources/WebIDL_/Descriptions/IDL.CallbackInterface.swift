import JSON

extension IDL
{
    @frozen public
    struct CallbackInterface
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
extension IDL.CallbackInterface:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .callback_interface }
}
extension IDL.CallbackInterface:JSONObjectDecodable
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
