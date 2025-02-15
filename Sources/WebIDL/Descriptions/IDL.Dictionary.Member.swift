import JSON

extension IDL.Dictionary
{
    @frozen public
    struct Member
    {
        public
        let name:String
        public
        let type:IDL.TypeMetadata
        public
        let `default`:IDL.ValueExpression?
        public
        let required:Bool
        public
        let extAttrs:[IDL.ExtendedAttribute]
    }
}
extension IDL.Dictionary.Member:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case idlType
        case `default`
        case required
        case extAttrs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(
            name: try json[.name].decode(),
            type: try json[.idlType].decode(),
            default: try json[.default].decode(),
            required: try json[.required].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
