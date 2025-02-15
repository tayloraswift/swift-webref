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
        print([_].init(modules.keys))
    }
}

public
enum IDL
{
}
