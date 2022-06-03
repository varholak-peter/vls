module analyzer

/*
In V terminology, a "module" is defined as a collection of files in a directory.
However, there are some instances that a directory may mixed "main" and non-"main" files.

In order to fix this confusion, the word "project" is used in VLS as having a
directory which comprises of multiple modules. This also includes subdirectories
named as "submodules".

In a sense, a project may contain multiple modules and modules may contain multiple files.

How about submodules from 2nd-to-n levels? They are still stored in the same project
since Project.module is just a flat list. An identifier is also linked so it does not
have any conflicts with module names that have similar names.
*/

pub struct ProjectStore {
mut:
	module_id_counter  u16 = 1
	file_id_counter    u16 = 1
	project_paths      []string = []string{cap: 65535}
pub mut:
	projects           []&Project = []&Project{cap: 65535}
}

pub fn (mut store ProjectStore) add_file(file_path string, tree C.TSTree) FileLocation {

}

pub fn (mut store ProjectStore) new_project(path string) &Project {
	store.projects << &Project{

	}
}

pub fn (store &ProjectStore) project_by_dir(dir string) ?&Project {
	idx := store.project_paths.index(dir)
	if idx == -1 {
		return none
	}
	return store.projects[idx]
}

[heap]
pub struct Project {
pub mut:
	path         string [required]
	module_names []string = []string{cap: 255}
	modules      []Module = []Module{cap: 255}
}

pub fn (mut prj Project) new_module(path string, name string) {
	
}

pub type ModuleId = u16
pub type FileId = u16

pub struct Module {
pub mut:
	id    ModuleId [required]
	name  string [required]
	path  string [required]
	files []File = []File{cap: 255}
}

pub struct File {
pub mut:
	path        string [required]
	id          FileId
	language    SymbolLanguage
	platform    Platform
	for_define  string
	for_ndefine string
	scopes      []&ScopeTree // TODO: remove later
	symbols     []&Symbol = []&Symbol{cap: 255}
}

pub struct FileLocation {
	module_id ModuleId
	file_id   FileId
}