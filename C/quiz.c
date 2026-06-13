#include "quiz_internal.h"

#include <stdlib.h>
#include <time.h>

static void quiz_run_attempts(Question *questions, size_t count, QuizMode mode, DString *line) {
    size_t *order = malloc(count * sizeof(*order));
    Attempt *attempts = calloc(count, sizeof(*attempts));
    ChoiceRef *choices = malloc(QUESTION_ANSWER_COUNT * sizeof(*choices));

    if (order == NULL || attempts == NULL || choices == NULL) {
        fprintf(stderr, "Out of memory while preparing the quiz\n");
        free(order);
        free(attempts);
        free(choices);
        quiz_free_questions(questions, count);
        dstr_free(line);
        exit(EXIT_FAILURE);
    }

    for (size_t i = 0; i < count; i++) {
        order[i] = i;
    }
    quiz_shuffle_size_t(order, count);

    size_t attempt_count = 0;

    for (size_t i = 0; i < count; i++) {
        size_t q_index = order[i];
        Question *q = &questions[q_index];
        q->used = 1;

        size_t choice_count = 0;
        quiz_build_shuffled_choices(q, choices, &choice_count);

        if (choice_count == 0) {
            fprintf(stderr, "Skipping question with too few choices: %s\n", q->question);
            continue;
        }

        printf("\n=== Question %zu of %zu ===\n", attempt_count + 1, count);
        printf("%s\n", q->question);
        quiz_print_choice_block(q, choices, choice_count);

        char answer = quiz_prompt_for_answer(line, choice_count);
        if (answer == 'Q') {
            break;
        }

        size_t chosen_index = (size_t)(answer - 'A');
        size_t correct_index = quiz_question_correct_index(q);
        bool is_correct = (choices[chosen_index].source_index == correct_index);

        attempts[attempt_count].question_index = q_index;
        attempts[attempt_count].chosen_index = chosen_index;
        attempts[attempt_count].correct_index = correct_index;
        attempts[attempt_count].choice_count = choice_count;
        for (size_t j = 0; j < choice_count; j++) {
            attempts[attempt_count].choice_order[j] = choices[j].source_index;
        }
        attempts[attempt_count].answered = true;
        attempts[attempt_count].correct = is_correct;
        attempt_count++;

        if (mode == MODE_LEARNING) {
            quiz_print_question_feedback(q, choices, choice_count, chosen_index);
        }
    }

    quiz_print_summary(questions, attempts, attempt_count, count, mode);

    free(order);
    free(attempts);
    free(choices);
}

int quiz_run(const char *quiz_file) {
    srand((unsigned)time(NULL));

    DString line;
    if (!dstr_init(&line)) {
        fprintf(stderr, "Failed to allocate line buffer\n");
        return EXIT_FAILURE;
    }

    // Prompt the user to select a mode
    QuizMode mode = quiz_prompt_for_mode(&line);
    if (mode == (QuizMode)-1) {
        dstr_free(&line);
        return EXIT_SUCCESS;
    }

    // Clear the screen before starting the quiz
    clear_screen();

    // Load questions from the specified file
    Question *questions = NULL;
    size_t count = 0;

    if (!quiz_load_questions(quiz_file, &questions, &count)) {
        dstr_free(&line);
        return EXIT_FAILURE;
    }

    quiz_run_attempts(questions, count, mode, &line);

    quiz_free_questions(questions, count);
    dstr_free(&line);
    return EXIT_SUCCESS;
}
