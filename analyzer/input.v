module analyzer

// import tree_sitter

pub interface Input {
	node_text(node C.TSNode) string
	is_empty() bool
	len() int
}

[heap]
pub struct AnalyzerInput {
mut:
	src []byte
	cursor TreeCursor
}

pub fn (i &AnalyzerInput) node_text(node C.TSNode) string {
	return node.code(i.src)
}

pub fn (i &AnalyzerInput) is_empty() bool {
	return i.src.len == 0
}

pub fn (i &AnalyzerInput) len() int {
	return i.src.len
}

[unsafe]
pub fn (i &AnalyzerInput) free() {
	unsafe {
		// i.src.free()
	}
}

pub type ByteArrayInput = []byte

pub fn (i ByteArrayInput) node_text(node C.TSNode) string {
	return node.code(i)
}

pub fn (i ByteArrayInput) is_empty() bool {
	return i.len() == 0
}

pub fn (i ByteArrayInput) len() int {
	return i.len
}