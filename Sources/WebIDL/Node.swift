public protocol IDLNode: Decodable {
    static var type: String { get }
    var extAttrs: [IDLExtendedAttribute] { get }
}

public protocol IDLNamed {
    var name: String { get }
}

private enum TypeKey: String, CodingKey {
    case type
}

struct IDLNodeDecoder: Decodable {
    let node: IDLNode
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TypeKey.self)
        let typeName = try container.decode(String.self, forKey: .type)
        let type:any IDLNode.Type

        switch typeName
        {
        case "argument":            type = IDLArgument.self
        case "attribute":           type = IDLAttribute.self
        case "callback":            type = IDLCallback.self
        case "callback interface":  type = IDLCallbackInterface.self
        case "const":               type = IDLConstant.self
        case "constructor":         type = IDLConstructor.self
        case "maplike":             type = IDLMapLikeDeclaration.self
        case "setlike":             type = IDLSetLikeDeclaration.self
        case "iterable":            type = IDLIterableDeclaration.self
        case "dictionary":          type = IDLDictionary.self
        case "enum":                type = IDLEnum.self
        case "includes":            type = IDLIncludes.self
        case "interface":           type = IDLInterface.self
        case "interface mixin":     type = IDLInterfaceMixin.self
        case "namespace":           type = IDLNamespace.self
        case "operation":           type = IDLOperation.self
        case "typedef":             type = IDLTypedef.self
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    codingPath: container.codingPath,
                    debugDescription: "Unknown type: \(typeName)"
                )
            )
        }

        node = try type.init(from: decoder)
    }
}
