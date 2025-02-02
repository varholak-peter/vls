module parser

import tree_sitter
import tree_sitter_v as v

pub fn new() &tree_sitter.Parser<v.NodeType> {
	return tree_sitter.new_parser<v.NodeType>(v.language, v.type_factory)
}