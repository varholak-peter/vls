module analyzer

pub struct AnalyzerError {
	Error
	msg   string
	range C.TSRange
}

pub fn (err AnalyzerError) msg() string {
	start := '{$err.range.start_point.row:$err.range.start_point.column}'
	end := '{$err.range.end_point.row:$err.range.end_point.column}'
	return '[$start -> $end] $err.msg'
}

pub fn (err AnalyzerError) str() string {
	return err.msg()
}

fn report_error(msg string, range C.TSRange) IError {
	return AnalyzerError{
		msg: msg
		range: range
	}
}

// report_error reports the AnalyzerError to the messages array
pub fn (mut ss Store) report_error(err IError) {
	if err is AnalyzerError {
		ss.report(
			kind: .error
			message: err.msg
			range: err.range
			file_path: ss.cur_file_path
		)
	}
}
