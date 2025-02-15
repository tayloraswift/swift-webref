import JSON

extension [any IDL.InterfaceMember]
{
    static func decode(
        from json:JSON.OptionalDecoder<some RawRepresentable<String>>) throws -> Self
    {
        try json.decode(as: JSON.Array.self)
        {
            try $0.map
            {
                let node:IDL.AnyNode = try $0.decode()
                return try node.cast(to: (any IDL.InterfaceMember).self)
            }
        }
    }
}

extension [any IDL.NamespaceMember]
{
    static func decode(
        from json:JSON.OptionalDecoder<some RawRepresentable<String>>) throws -> Self
    {
        try json.decode(as: JSON.Array.self)
        {
            try $0.map
            {
                let node:IDL.AnyNode = try $0.decode()
                return try node.cast(to: (any IDL.NamespaceMember).self)
            }
        }
    }
}
