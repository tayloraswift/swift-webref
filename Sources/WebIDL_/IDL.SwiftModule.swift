import WebIDL

extension IDL
{
    struct SwiftModule
    {
        /// The name of the Swift module.
        let name:String
        /// The Swift modules that this Swift module depends on.
        let dependencies:[String]
        /// The IDL modules that this Swift module is generated from.
        let constituents:[String]
    }
}
extension IDL.SwiftModule
{
    func constituents(in modules:[String: [IDL.AnyNode]]) throws -> Toplevel
    {
        try self.constituents.reduce(into: .init())
        {
            guard let nodes:[IDL.AnyNode] = modules[$1]
            else
            {
                throw IDL.SwiftModuleError.constituentMissing($1)
            }

            for node:IDL.AnyNode in nodes
            {
                switch node.cast
                {
                case let node as IDL.Callback:
                    $0.callbacks.append(node)

                case let node as IDL.CallbackInterface:
                    $0.callbackInterfaces.append(node)

                case let node as IDL.Dictionary:
                    $0.dictionaries.append(node)

                case let node as IDL.Enum:
                    $0.enums.append(node)

                case let node as IDL.Includes:
                    $0.includes.append(node)

                case let node as IDL.Interface:
                    $0.interfaces.append(node)

                case let node as IDL.InterfaceMixin:
                    $0.interfaceMixins.append(node)

                case let node as IDL.Namespace:
                    $0.namespaces.append(node)

                case let node as IDL.Typedef:
                    $0.typedefs.append(node)

                default:
                    throw ToplevelNodeError.unexpected(node)
                }
            }
        }
    }
}
extension IDL.SwiftModule
{
    static var JavaScriptInterop:Self
    {
        .init(name: "JavaScriptInterop",
            dependencies: [],
            constituents: ["console", "webidl", "url"])
    }
    static var JavaScriptDOM:Self
    {
        .init(name: "JavaScriptDOM",
            dependencies: ["JavaScriptInterop"],
            constituents: [
                "dom",
                "html",
                "wai-aria",
                "uievents",
                "css-pseudo",
                "geometry",
                "cssom-view",
                "hr-time",
                "FileAPI",
                "xhr",
                "referrer-policy",
                "fetch",
                "streams",
                "mediacapture-streams",
                "mediastream-recording",
                "webcodecs",
                "service-workers",
                "touch-events",
                "media-source",
                "performance-timeline",
                "permissions",
                "mathml-core",
            ])
    }

    static var JavaScriptWebSockets:Self
    {
        .init(name: "JavaScriptWebSockets",
            dependencies: ["JavaScriptInterop", "JavaScriptDOM"],
            constituents: ["websockets"])
    }

    static var JavaScriptWebAudio:Self
    {
        .init(name: "JavaScriptWebAudio",
            dependencies: ["JavaScriptInterop", "JavaScriptDOM"],
            constituents: ["webaudio"])
    }

    static var JavaScriptWebAnimations:Self
    {
        .init(name: "JavaScriptWebAnimations",
            dependencies: ["JavaScriptInterop", "JavaScriptDOM", "JavaScriptWebAudio"],
            constituents: ["web-animations"])
    }

    static var JavaScriptWebGL1:Self
    {
        .init(name: "JavaScriptWebGL1",
            dependencies: [
                "JavaScriptInterop",
                "JavaScriptDOM",
                "JavaScriptWebAudio",
                "JavaScriptWebAnimations"
            ],
            constituents: ["webgl1"])
    }

    static var JavaScriptWebGL2:Self
    {
        .init(name: "JavaScriptWebGL2",
            dependencies: [
                "JavaScriptInterop",
                "JavaScriptDOM",
                "JavaScriptWebAudio",
                "JavaScriptWebAnimations",
                "JavaScriptWebGL1"
            ],
            constituents: ["webgl2"])
    }

    static var JavaScriptWebGPU:Self
    {
        .init(name: "JavaScriptWebGPU",
            dependencies: [
                "JavaScriptInterop",
                "JavaScriptDOM",
                "JavaScriptWebAudio",
                "JavaScriptWebAnimations",
                "JavaScriptWebGL1"
            ],
            constituents: ["webgpu"])
    }

    static var JavaScriptGamepad:Self
    {
        .init(name: "JavaScriptGamepad",
            dependencies: ["JavaScriptInterop", "JavaScriptDOM"],
            constituents: ["gamepad", "gamepad-extensions"])
    }

    static var JavaScriptCSSOM:Self
    {
        .init(name: "JavaScriptCSSOM",
            dependencies: ["JavaScriptInterop", "JavaScriptDOM", "JavaScriptSVG"],
            constituents: ["cssom", "cssom-view", "css-typed-om"])
    }

    static var JavaScriptSVG:Self
    {
        .init(name: "JavaScriptSVG",
            dependencies: ["JavaScriptInterop", "JavaScriptDOM"],
            constituents: ["SVG", "css-masking", "svg-animations"])
    }

    static var JavaScriptFileSystem:Self
    {
        .init(name: "JavaScriptFileSystem",
            dependencies: ["JavaScriptInterop", "JavaScriptDOM"],
            constituents: ["fs", "storage", "file-system-access"])
    }
}
