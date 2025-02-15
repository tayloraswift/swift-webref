extension IDL
{
    struct NodeCastError:Error
    {
        let type:NodeType
        let cast:Any.Type
    }
}
