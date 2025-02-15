extension IDL
{
    public
    protocol Declaration:InterfaceMember
    {
        var types:[TypeMetadata] { get }
    }
}
