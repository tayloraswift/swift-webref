import ArgumentParser
import JSON
import System_ArgumentParser
import SystemIO

@main
struct Main:ParsableCommand
{
    @Argument(help: "The path to the WebIDL JSON file")
    var path:FilePath

    func run() throws
    {
        let json:JSON = .init(utf8: try self.path.read()[...])
        print(json.utf8.count)

        let modules:[String: [IDL.AnyNode]] = try json.decode()
        print(modules)
    }
}

public
enum IDL
{
}

extension IDL
{
    struct NodeTypeError:Error
    {
        let name:String?
    }
}
extension IDL.NodeTypeError:CustomStringConvertible
{
    public
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
extension IDL
{
    struct NodeCastError:Error
    {
        let type:NodeType
        let cast:Any.Type
    }
}
extension IDL
{
    @frozen public
    enum NodeType:String
    {
        case argument
        case attribute
        case callback
        case callback_interface = "callback interface"
        case const
        case constructor
        case maplike
        case setlike
        case iterable
        case dictionary
        case `enum`
        case includes
        case interface
        case interface_mixin = "interface mixin"
        case namespace
        case operation
        case typedef
    }
}
extension IDL
{
    struct AnyNode
    {
        let cast:any SyntaxNode
    }
}
extension IDL.AnyNode:JSONDecodable
{
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
        case .argument:     constructor = IDL.Argument.self
        case .attribute:    constructor = IDL.Attribute.self
        case .const:        constructor = IDL.Const.self
        case .constructor:  constructor = IDL.Constructor.self
        case .enum:         constructor = IDL.Enum.self
        case .interface:    constructor = IDL.Interface.self
        case .operation:    constructor = IDL.Operation.self
        default:            throw IDL.NodeTypeError.init(name: type.rawValue)
        }

        self.init(cast: try constructor.init(json: json))
    }
}

extension IDL
{
    public
    protocol SyntaxNode:JSONObjectDecodable
    {
        static var type:NodeType { get }

        var extAttrs:[ExtendedAttribute] { get }
    }
}
extension IDL
{
    public
    protocol InterfaceMember:SyntaxNode
    {
    }
}

extension IDL
{
    protocol NominalNode:SyntaxNode
    {
        var name:String { get }
    }
}

