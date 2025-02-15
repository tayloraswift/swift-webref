import JSON

extension IDL
{
    /// https://github.com/w3c/webidl2.js/#extended-attributes
    @frozen public
    struct ExtendedAttribute
    {
        public
        let name:String
        public
        let arguments:[Argument]
        public
        let rhs:RHS?
    }
}
extension IDL.ExtendedAttribute:JSONObjectDecodable
{
    public
    enum CodingKey:String, Sendable
    {
        case name
        case arguments
        case rhs
    }

    public
    init(json:JSON.ObjectDecoder<CodingKey>) throws
    {
        self.init(name: try json[.name].decode(),
            arguments: try json[.arguments].decode(),
            rhs: try json[.rhs]?.decode())
    }
}
