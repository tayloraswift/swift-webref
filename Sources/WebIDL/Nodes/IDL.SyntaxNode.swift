import JSON

extension IDL
{
    public
    protocol SyntaxNode:JSONObjectDecodable
    {
        static var type:NodeType { get }

        var extAttrs:[ExtendedAttribute] { get }
    }
}
