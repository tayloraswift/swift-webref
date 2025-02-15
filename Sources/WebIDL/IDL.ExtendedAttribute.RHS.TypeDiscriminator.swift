import JSON

extension IDL.ExtendedAttribute.RHS
{
    enum TypeDiscriminator:String, JSONDecodable
    {
        case identifier
        case identifier_list = "identifier-list"
        case string
        case string_list = "string-list"
        case decimal
        case decimal_list = "decimal-list"
        case integer
        case integer_list = "integer-list"
        case wildcard = "*"
    }
}
