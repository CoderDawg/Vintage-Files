#ifndef QUIZ_INTERNAL_H
#define QUIZ_INTERNAL_H

#include <stdbool.h>
#include <stddef.h>
#include <stdio.h>

#include "dstring.h"
#include "question.h"

typedef enum {
    MODE_LEARNING,
    MODE_TEST
} QuizMode;

typedef struct {
    size_t source_index;
} ChoiceRef;

typedef struct {
    size_t question_index;
    size_t chosen_index;
    size_t correct_index;
    size_t choice_count;
    size_t choice_order[QUESTION_ANSWER_COUNT];
    bool answered;
    bool correct;
} Attempt;

FILE *quiz_open_input(const char *filename);
bool quiz_load_questions(const char *quiz_file, Question **questions_out, size_t *count_out);
void quiz_free_questions(Question *questions, size_t count);

void quiz_shuffle_size_t(size_t *values, size_t count);
size_t quiz_question_correct_index(const Question *q);
void quiz_build_shuffled_choices(const Question *q, ChoiceRef *choices, size_t *choice_count);
char quiz_letter_for_index(size_t index);
void clear_screen(void);

char quiz_read_first_non_space_char(DString *line);
QuizMode quiz_prompt_for_mode(DString *line);
char quiz_prompt_for_answer(DString *line, size_t choice_count);
void quiz_print_choice_block(const Question *q, const ChoiceRef *choices, size_t choice_count);
void quiz_print_question_feedback(const Question *q, const ChoiceRef *choices, size_t choice_count, size_t chosen_index);

void quiz_print_answer_key(const Question *q, const Attempt *attempt);
void quiz_print_question_snippet(const char *text, char *buffer, size_t buffer_size);
void quiz_print_summary(const Question *questions, const Attempt *attempts, size_t attempt_count, size_t total_questions, QuizMode mode);

#endif // QUIZ_INTERNAL_H
