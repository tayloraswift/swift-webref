import JSON

extension IDL
{
    /// https://github.com/w3c/webidl2.js#default-and-const-values
    enum ValueExpressionType:String, JSONDecodable
    {
        case boolean
        case dictionary
        case infinity = "Infinity"
        case nan = "NaN"
        case null
        case number
        case sequence
        case string
    }
}
