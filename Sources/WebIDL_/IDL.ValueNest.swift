import JSON

extension IDL
{
    struct ValueNest
    {
        let value:String
    }
}
extension IDL.ValueNest:JSONObjectDecodable
{
    enum CodingKey:String, Sendable
    {
        case value
    }

    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(value: try json[.value].decode())
    }
}
