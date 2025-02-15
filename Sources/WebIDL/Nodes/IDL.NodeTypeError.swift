extension IDL
{
    struct NodeTypeError:Error
    {
        let name:String?
    }
}
extension IDL.NodeTypeError:CustomStringConvertible
{
    var description:String
    {
        if let name:String = self.name
        {
            return "Unknown node type: \(name)"
        }
        else
        {
            return "Unknown node type"
        }
    }
}
