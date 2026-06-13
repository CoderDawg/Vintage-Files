#include "quiz.h"

#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static bool is_help_arg(const char *arg) {
    return arg != NULL &&
           (strcmp(arg, "-?") == 0 ||
            strcmp(arg, "-h") == 0 ||
            strcmp(arg, "-help") == 0 ||
            strcmp(arg, "--help") == 0);
}

static void print_usage(const char *program_name) {
    const char *name = (program_name != NULL && program_name[0] != '\0') ? program_name : "QuizMaster";

    printf("Usage: %s [quiz-file]\n", name);
    puts("");
    puts("Arguments:");
    puts("  quiz-file   Optional CSV file to load quiz questions from.");
    puts("              Defaults to data.csv when omitted.");
    puts("  CSV rows use: Correct_Answer,Question,Answer1,...,AnswerN");
    puts("              Empty answer fields are ignored; each row needs 2-26 answers.");
    puts("              Lines with leading spaces followed by '#' are comments.");
    puts("");
    puts("Help flags:");
    puts("  -?  -h  -help  --help");
}

int main(int argc, char *argv[]) {
    for (int i = 1; i < argc; i++) {
        if (is_help_arg(argv[i])) {
            print_usage(argv[0]);
            return EXIT_SUCCESS;
        }
    }

    const char *quiz_file = (argc > 1 && argv[1] != NULL && argv[1][0] != '\0') ? argv[1] : "data.csv";
    return quiz_run(quiz_file);
}
