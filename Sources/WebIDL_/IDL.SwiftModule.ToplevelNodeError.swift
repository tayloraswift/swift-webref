import WebIDL

extension IDL.SwiftModule
{
    enum ToplevelNodeError:Error
    {
        case unexpected(IDL.AnyNode)
    }
}
