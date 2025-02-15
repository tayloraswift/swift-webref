import JSON

extension IDL
{
    @frozen public
    enum ValueExpression
    {
        case bool(Bool)
        case dictionary
        case infinity(negative: Bool)
        case nan
        case null
        case number(String)
        case sequence([Never])
        case string(String)
    }
}
extension IDL.ValueExpression:JSONObjectDecodable
{
    public
    enum CodingKeys:String, Sendable
    {
        case type
        case value
        case negative
    }

    public
    init(json:JSON.ObjectDecoder<CodingKeys>) throws
    {
        switch try json[.type].decode(to: IDL.ValueExpressionType.self)
        {
        case .boolean:
            self = .bool(try json[.value].decode())

        case .dictionary:
            try json[.value]?.decode(to: Never.self)
            self = .dictionary

        case .infinity:
            try json[.value]?.decode(to: Never.self)
            self = .infinity(negative: try json[.negative].decode())

        case .nan:
            try json[.value]?.decode(to: Never.self)
            self = .nan

        case .null:
            try json[.value]?.decode(to: Never.self)
            self = .null

        case .number:
            self = .number(try json[.value].decode())

        case .sequence:
            self = .sequence(try json[.value].decode())

        case .string:
            self = .string(try json[.value].decode())
        }
    }
}
