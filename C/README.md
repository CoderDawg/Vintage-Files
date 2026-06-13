# QuizMaster

QuizMaster is a C-based multiple-choice quiz app that loads questions from a CSV file, shuffles the quiz, and supports learning and test modes.

This is an updated version of an old vintage GW-BASIC program, recreated in C with a few minor upgrades and quality-of-life improvements.

## Build

The project uses the provided `Makefile`:

```sh
make
```

Useful targets:

```sh
make run
make debug
make release
make clean
```

## Usage

```sh
./QuizMaster [quiz-file]
```

Use `-?`, `-h`, `-help`, or `--help` to print the built-in help text.

## CSV Format

Each question row uses this shape:

```text
Correct_Answer,Question,Answer1,...,AnswerN
```

- Empty answer fields are ignored.
- Each row must contain at least 2 non-empty answers and no more than 26.
- Lines with leading spaces followed by `#` are treated as comments.

## Supported Build Outputs

The repository ignores the most common generated files across platforms:

- macOS and Linux: the `QuizMaster` executable, `*.o`, `*.d`, coverage files, and sanitizer logs.
- Windows: `QuizMaster.exe`, `*.obj`, `*.pdb`, `*.ilk`, `*.lib`, `*.exp`, and Visual Studio metadata like `.vs/`.

That keeps the workspace clean whether you build locally on macOS, Linux, or Windows.
