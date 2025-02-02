module analyzer

import tree_sitter
import tree_sitter_v as v

struct TreeWalker {
mut:
	already_visited_children bool
	cursor                   tree_sitter.TreeCursor<v.NodeType> [required]
}

pub fn (mut tw TreeWalker) next() ?tree_sitter.Node<v.NodeType> {
	if !tw.already_visited_children {
		if tw.cursor.to_first_child() {
			tw.already_visited_children = false
		} else if tw.cursor.next() {
			tw.already_visited_children = false
		} else {
			if !tw.cursor.to_parent() {
				return error('')
			}
			tw.already_visited_children = true
			return tw.next()
		}
	} else {
		if tw.cursor.next() {
			tw.already_visited_children = false
		} else {
			if !tw.cursor.to_parent() {
				return error('')
			}
			return tw.next()
		}
	}
	return tw.cursor.current_node()
}

pub fn new_tree_walker(root_node tree_sitter.Node<v.NodeType>) TreeWalker {
	return TreeWalker{
		cursor: root_node.tree_cursor()
	}
}
