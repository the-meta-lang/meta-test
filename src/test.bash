#!/usr/bin/bash
suites=0
cases=0
cases_failed=0
suites_failed=0
start_time=$(date +%s%N | cut -b1-13)
bold_green=$(tput bold; tput setaf 2)
bold_red=$(tput bold; tput setaf 1)
reset=$(tput sgr0)
gray=$(tput setaf 8)

generate_postamble() {
	echo ""
	if [ $suites_failed -eq 0 ]; then
		echo "Test Suites: ${bold_green}${suites} passed${reset}, $suites Total"
	else
		echo "Test Suites: ${bold_red}${suites_failed} failed${reset}, $suites Total"
	fi

	if [ $cases_failed -eq 0 ]; then
		echo "Tests:       ${bold_green}${cases} passed${reset}, $cases Total"
	else
		echo "Tests:       ${bold_red}${cases_failed} failed${reset}, $cases Total"
	fi

	# Show execution time
	end_time=$(date +%s%N | cut -b1-13)
	echo "Time:        $(($end_time - $start_time))ms"

	if [ $suites_failed -eq 0 ] && [ $cases_failed -eq 0 ]; then
		exit 0
	else
		exit 1
	fi
}

execute() {
	# Display a placeholder spinner while we're waiting for the test
	spin='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
	(output=$($1)) &
	pid=$!
	while kill -0 $pid 2>/dev/null
	do
			i=$(( (i+1) %4 ))
			printf "\r\t${spin:$i:1} Running $1..."
			sleep .1
	done
	echo -e '\033[2K'
	# Return the exit code of the test
	wait $pid
	return $output
}

# Suite META
suites=$((suites+1))
echo -e '\x1b[37;46;1m[SUITE]\x1b[0m META - A language that can do almost anything.'
echo -e '\x1b[37;43;1m[TEST]\x1b[0m Addition'
stdout=$(execute "./bash-test/sleep.bash")
exit_code=$?
cases=$((cases+1))
if ! [ $exit_code -eq 00 ]; then
    echo -e '\r\t❌ expected return code to be zero'
    cases_failed=$(($cases_failed+1))
else
    echo -e '\r\t✔ expect return code to be zero'
fi
stdout=$(execute "./bash-test/sleep.bash")
exit_code=$?
cases=$((cases+1))
if ! [ $exit_code -eq 00 ]; then
    echo -e '\r\t❌ expected return code to be zero'
    cases_failed=$(($cases_failed+1))
else
    echo -e '\r\t✔ expect return code to be zero'
fi
generate_postamble
