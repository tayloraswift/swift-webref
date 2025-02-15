import JSON

extension IDL
{
    @frozen public
    struct InterfaceMixin
    {
        public
        let name:String
        public
        let members:[any NamespaceMember]
        public
        let partial:Bool
        public
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.InterfaceMixin:IDL.NominalNode
{
    @inlinable public
    static var type:IDL.NodeType { .interface_mixin }
}
extension IDL.InterfaceMixin:JSONObjectDecodable
{
    public
    init(json:JSON.ObjectDecoder<IDL.NamespaceCodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            members: try .decode(from: json[.members]),
            partial: try json[.partial].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
