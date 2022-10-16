#!/usr/bin/env bash
set -e

if [ -z "$1" ]; then

	me="$(realpath "$0")"

	cd "$(dirname "$0")"/tests

	rm -rf .testResults
	mkdir .testResults
	testResultsDir="$(realpath ".testResults/")"

	find . -maxdepth 1 -mindepth 1 -type d -not -name ".*" -exec "$me" "{}" "$testResultsDir" \;

	find "$testResultsDir" -type f -name "*.stderr" -empty -delete
	echo
	test -f "$testResultsDir/ERROR" && {
		echo "ERROR: Some tests failed"
		exit 1
	}

	echo All is fine

else

	testResultsDir="$2"
	testName="$(basename "$1")"
	pad=" -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - "
	text="Running test $testName "
	echo -n "${text}${pad:${#text}}"
	cd "$testName"
	test -f input.bas || {
		echo "No input.bas file found in $testName" >"$testResultsDir/$testName.error"
		echo "❌ No input file"
		touch "$testResultsDir/ERROR"
		exit 1
	}
	test -f output.bas || {
		echo "  No output.bas file found in $testName" >"$testResultsDir/$testName.error"
		echo "❌ No output file"
		touch "$testResultsDir/ERROR"
		exit 1
	}

	../../baspp input.bas >"$testResultsDir/$testName.output" 2>"$testResultsDir/$testName.stderr"

	diff -u output.bas "$testResultsDir/$testName.output" >"$testResultsDir/$testName.diff" || {
		echo "  Test $testName failed" >"$testResultsDir/$testName.error"
		echo "❌ Failed"
		diff-so-fancy <"$testResultsDir/$testName.diff" | tail -n-2 | sed 's/^/  /'
		touch "$testResultsDir/ERROR"
		exit 1
	}

	echo "️️️✅"
fi
