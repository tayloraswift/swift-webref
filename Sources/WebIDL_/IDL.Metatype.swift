import JSON

extension IDL
{
    @frozen public
    struct Metatype
    {
        let name:String?
        let children:[Self]
        let nullable:Bool
        let extAttrs:[ExtendedAttribute]
    }
}
extension IDL.Metatype:JSONObjectDecodable
{
    public
    enum CodingKeys:String, Sendable
    {
        case extAttrs
        case generic
        case idlType
        case nullable
        case union
    }

    public
    init(json:JSON.ObjectDecoder<CodingKeys>) throws
    {
        let generic:String = try json[.generic].decode()

        let name:String?
        let children:[Self]

        if  try json[.union].decode()
        {
            name = nil
            children = try json[.idlType].decode()
        }
        else if generic.isEmpty
        {
            name = try json[.idlType].decode()
            children = []
        }
        else
        {
            name = generic
            children = try json[.idlType].decode()
        }

        self.init(name: name,
            children: children,
            nullable: try json[.nullable].decode(),
            extAttrs: try json[.extAttrs].decode())
    }
}
