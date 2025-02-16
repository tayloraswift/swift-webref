import WebIDL

extension IDL.SwiftModule
{
    struct Toplevel
    {
        var callbacks:[IDL.Callback]
        var callbackInterfaces:[IDL.CallbackInterface]
        var dictionaries:[IDL.Dictionary]
        var enums:[IDL.Enum]
        var includes:[IDL.Includes]
        var interfaces:[IDL.Interface]
        var interfaceMixins:[IDL.InterfaceMixin]
        var namespaces:[IDL.Namespace]
        var typedefs:[IDL.Typedef]

        init()
        {
            self.callbacks = []
            self.callbackInterfaces = []
            self.dictionaries = []
            self.enums = []
            self.includes = []
            self.interfaces = []
            self.interfaceMixins = []
            self.namespaces = []
            self.typedefs = []
        }
    }
}
