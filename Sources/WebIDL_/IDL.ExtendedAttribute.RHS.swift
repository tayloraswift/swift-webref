import JSON

extension IDL.ExtendedAttribute
{
    @frozen public
    enum RHS
    {
        case identifier(String)
        case identifiers([String])
        case string(String)
        case strings([String])
        case decimal(String)
        case decimals([String])
        case integer(String)
        case integers([String])
        case wildcard
    }
}
extension IDL.ExtendedAttribute.RHS:JSONObjectDecodable
{
    public
    enum CodingKeys:String, Sendable
    {
        case type
        case value
    }

    public
    init(json:JSON.ObjectDecoder<CodingKeys>) throws
    {
        switch try json[.type].decode(to: TypeDiscriminator.self)
        {
        case .identifier:
            self = .identifier(try json[.value].decode())

        case .identifier_list:
            self = .identifiers(try json[.value].decode(to: [IDL.ValueNest].self).map(\.value))

        case .string:
            self = .string(try json[.value].decode())

        case .string_list:
            self = .strings(try json[.value].decode(to: [IDL.ValueNest].self).map(\.value))

        case .decimal:
            self = .decimal(try json[.value].decode())

        case .decimal_list:
            self = .decimals(try json[.value].decode(to: [IDL.ValueNest].self).map(\.value))

        case .integer:
            self = .integer(try json[.value].decode())

        case .integer_list:
            self = .integers(try json[.value].decode(to: [IDL.ValueNest].self).map(\.value))

        case .wildcard:
            self = .wildcard
        }
    }
}
