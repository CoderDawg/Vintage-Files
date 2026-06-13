#include "quiz_internal.h"

#include <ctype.h>
#include <stdlib.h>

static bool line_is_comment(const DString *line) {
    size_t i = 0;

    while (line->data[i] != '\0' && isspace((unsigned char)line->data[i])) {
        i++;
    }

    return line->data[i] == '#';
}

static bool question_push(Question **questions, size_t *count, size_t *capacity, Question q) {
    if (*count >= *capacity) {
        size_t next_capacity = (*capacity == 0) ? 16 : (*capacity * 2);
        Question *grown = realloc(*questions, next_capacity * sizeof(*grown));
        if (grown == NULL) {
            return false;
        }
        *questions = grown;
        *capacity = next_capacity;
    }

    (*questions)[*count] = q;
    (*count)++;
    return true;
}

FILE *quiz_open_input(const char *filename) {
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        fprintf(stderr, "Error opening file '%s': ", filename);
        perror(NULL);
        exit(EXIT_FAILURE);
    }
    return file;
}

bool quiz_load_questions(const char *quiz_file, Question **questions_out, size_t *count_out) {
    FILE *fp = quiz_open_input(quiz_file);

    printf("Loading questions from %s...\n", quiz_file);

    DString line;
    if (!dstr_init(&line)) {
        fprintf(stderr, "Failed to allocate line buffer\n");
        fclose(fp);
        return false;
    }

    Question *questions = NULL;
    size_t count = 0;
    size_t capacity = 0;

    while (dstr_readline(fp, &line)) {
        if (line_is_comment(&line)) {
            continue;
        }

        Question q;
        question_init(&q);

        if (!question_from_line(&line, &q)) {
            fprintf(stderr, "Skipping malformed line: %s", line.data);
            continue;
        }

        if (!question_push(&questions, &count, &capacity, q)) {
            fprintf(stderr, "Out of memory while storing questions\n");
            question_free(&q);
            break;
        }
    }

    fclose(fp);
    dstr_free(&line);

    printf("Loaded %zu question%s.\n", count, (count == 1) ? "" : "s");

    if (count == 0) {
        fprintf(stderr, "No quiz questions were loaded.\n");
        for (size_t i = 0; i < count; i++) {
            question_free(&questions[i]);
        }
        free(questions);
        return false;
    }

    *questions_out = questions;
    *count_out = count;
    return true;
}

void quiz_free_questions(Question *questions, size_t count) {
    if (questions == NULL) {
        return;
    }

    for (size_t i = 0; i < count; i++) {
        question_free(&questions[i]);
    }
    free(questions);
}
