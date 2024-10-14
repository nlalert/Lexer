import os
import subprocess

## For printing colorful text on terminal
class bcolors:
    GREEN = '\033[92m'
    RED = '\033[91m'
    GRAY = '\033[90m'
    ENDC = '\033[0m'


## When file name is too long for display
def truncate_string(text, max_length):
    return f"{text[:max_length-3] + '...' if len(text) > max_length else text}"


JAVA_LEXER = 'TermProjectLexer'


## input_path: the path of input file to test
## should_pass: True if expected to pass, False if expected to fail
def run_test(input_path: str, should_pass: bool = True) -> bool:
    command = ['java', JAVA_LEXER, input_path]
    result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    print(open(input_path).read())
    print(result.stdout.decode(), end='')
    print(result.stderr.decode(), end='')
    # print(result.returncode)
    return result.returncode != 0 ^ should_pass


if __name__ == '__main__':
    total_score = 0
    total_files = 0
    for root, dirs, files in os.walk('tests'):
        print(f"{f" {root} ({len(files)} tests) ":=^40}")
        filtered_files = list(filter(lambda x: not x.startswith("."), files))
        filtered_files.sort()
        score = 0
        total_files += len(filtered_files)
        for file in filtered_files:
            input_path = os.path.join(root, file)
            should_pass = not 'fail' in input_path
            print(end=bcolors.GRAY)
            pass_test = run_test(input_path, should_pass)
            print(end=bcolors.ENDC)
            result_str = (bcolors.GREEN + "PASS" if pass_test else bcolors.RED + "FAIL") + bcolors.ENDC
            if pass_test:
                score += 1
            print(f"- {truncate_string(file, 30):<31} {result_str:>10}")
        # Prevent from division by zero
        if len(files) == 0:
            continue
        total_score += score
        print(f"> Score: {score}/{len(files)} ({f"{score / len(files):.0%}"})\n")
    print(f"Total score: {total_score}/{total_files} ({f"{total_score / total_files:.0%}"})")