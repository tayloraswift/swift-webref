import JSON

extension IDL
{
    public
    protocol SyntaxNode:JSONObjectDecodable, Sendable
    {
        static var type:NodeType { get }

        var extAttrs:[ExtendedAttribute] { get }
    }
}
