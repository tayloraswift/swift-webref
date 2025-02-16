import JSON

extension IDL
{
    @frozen public
    struct AnyNode:Sendable
    {
        public
        let cast:any SyntaxNode
    }
}
extension IDL.AnyNode
{
    func cast<T>(to _:T.Type = T.self) throws -> T
    {
        guard case let member as T = self.cast
        else
        {
            throw IDL.NodeCastError.init(type: type(of: self.cast).type, cast: T.self)
        }
        return member
    }
}
extension IDL.AnyNode:JSONDecodable
{
    public
    init(json:JSON.Node) throws
    {
        // Deduce the type of the node
        let json:JSON.Object = try .init(json: json)
        var type:String? = nil
        for case ("type", .string(let name)) in json.fields
        {
            type = name.value
            break
        }

        guard
        let type:String,
        let type:IDL.NodeType = .init(rawValue: type)
        else
        {
            throw IDL.NodeTypeError.init(name: type)
        }

        let constructor:any IDL.SyntaxNode.Type

        switch type
        {
        case .argument:             constructor = IDL.Argument.self
        case .attribute:            constructor = IDL.Attribute.self
        case .callback:             constructor = IDL.Callback.self
        case .callback_interface:   constructor = IDL.CallbackInterface.self
        case .const:                constructor = IDL.Const.self
        case .constructor:          constructor = IDL.Constructor.self
        case .dictionary:           constructor = IDL.Dictionary.self
        case .enum:                 constructor = IDL.Enum.self
        case .includes:             constructor = IDL.Includes.self
        case .interface:            constructor = IDL.Interface.self
        case .interface_mixin:      constructor = IDL.InterfaceMixin.self
        case .iterable:             constructor = IDL.Iterable.self
        case .maplike:              constructor = IDL.Maplike.self
        case .namespace:            constructor = IDL.Namespace.self
        case .operation:            constructor = IDL.Operation.self
        case .setlike:              constructor = IDL.Setlike.self
        case .typedef:              constructor = IDL.Typedef.self
        }

        self.init(cast: try constructor.init(json: json))
    }
}
