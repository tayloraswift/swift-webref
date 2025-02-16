extension IDL
{
    @frozen public
    struct NodeCastError:Error
    {
        public
        let type:NodeType
        public
        let cast:Any.Type

        @inlinable public
        init(type:NodeType, cast:Any.Type)
        {
            self.type = type
            self.cast = cast
        }
    }
}
