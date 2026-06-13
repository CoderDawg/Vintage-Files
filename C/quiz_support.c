#include "quiz_internal.h"

#include <ctype.h>
#include <stdlib.h>

void quiz_shuffle_size_t(size_t *values, size_t count) {
    if (count < 2) {
        return;
    }

    for (size_t i = count - 1; i > 0; i--) {
        size_t j = (size_t)(rand() % (int)(i + 1));
        size_t tmp = values[i];
        values[i] = values[j];
        values[j] = tmp;
    }
}

static void shuffle_choices(ChoiceRef *choices, size_t count) {
    if (count < 2) {
        return;
    }

    for (size_t i = count - 1; i > 0; i--) {
        size_t j = (size_t)(rand() % (int)(i + 1));
        ChoiceRef tmp = choices[i];
        choices[i] = choices[j];
        choices[j] = tmp;
    }
}

size_t quiz_question_correct_index(const Question *q) {
    size_t correct_index = (size_t)(unsigned char)q->correct;

    if (correct_index >= (size_t)'A' && correct_index < ((size_t)'A' + q->answer_count)) {
        return correct_index - (size_t)'A';
    }

    return q->answer_count;
}

void quiz_build_shuffled_choices(const Question *q, ChoiceRef *choices, size_t *choice_count) {
    size_t count = 0;

    for (size_t i = 0; i < q->answer_count; i++) {
        if (q->answer[i] != NULL && q->answer[i][0] != '\0') {
            choices[count].source_index = i;
            count++;
        }
    }

    shuffle_choices(choices, count);
    *choice_count = count;
}

char quiz_letter_for_index(size_t index) {
    return (char)('A' + (int)index);
}

void clear_screen(void) {
    printf("\033[2J\033[1;1H");
    fflush(stdout);
}

char quiz_read_first_non_space_char(DString *line) {
    if (!dstr_readline(stdin, line)) {
        return '\0';
    }

    size_t i = 0;
    while (line->data[i] != '\0' && isspace((unsigned char)line->data[i])) {
        i++;
    }

    if (line->data[i] == '\0') {
        return '\0';
    }

    return (char)toupper((unsigned char)line->data[i]);
}

QuizMode quiz_prompt_for_mode(DString *line) {
    for (;;) {
        puts("Select a mode:");
        puts("  L - Learning mode");
        puts("  T - Test mode");
        puts("  Q - Quit");
        printf("> ");
        fflush(stdout);

        char choice = quiz_read_first_non_space_char(line);
        if (choice == '\0' || choice == 'Q') {
            return (QuizMode)-1;
        }
        if (choice == 'L') {
            return MODE_LEARNING;
        }
        if (choice == 'T') {
            return MODE_TEST;
        }

        puts("Please choose L, T, or Q.\n");
    }
}

char quiz_prompt_for_answer(DString *line, size_t choice_count) {
    for (;;) {
        if (choice_count == 1) {
            printf("Your answer (A, or Q to quit): ");
        } else {
            printf("Your answer (A-%c, or Q to quit): ", quiz_letter_for_index(choice_count - 1));
        }
        fflush(stdout);

        char choice = quiz_read_first_non_space_char(line);
        if (choice == '\0' || choice == 'Q') {
            return 'Q';
        }

        if (choice >= 'A' && choice < (char)('A' + (int)choice_count)) {
            return choice;
        }

        if (choice_count == 1) {
            puts("Please choose A or Q.");
        } else {
            printf("Please choose A-%c or Q.\n", quiz_letter_for_index(choice_count - 1));
        }
    }
}

void quiz_print_choice_block(const Question *q, const ChoiceRef *choices, size_t choice_count) {
    for (size_t i = 0; i < choice_count; i++) {
        size_t source_index = choices[i].source_index;
        printf("   %c. %s\n", quiz_letter_for_index(i), q->answer[source_index]);
    }
}

void quiz_print_question_feedback(const Question *q, const ChoiceRef *choices, size_t choice_count, size_t chosen_index) {
    size_t correct_index = quiz_question_correct_index(q);
    size_t correct_display_index = choice_count;

    for (size_t i = 0; i < choice_count; i++) {
        if (choices[i].source_index == correct_index) {
            correct_display_index = i;
            break;
        }
    }

    if (chosen_index == correct_display_index) {
        puts("Correct.");
        return;
    }

    printf("Wrong. You chose %c. %s\n", quiz_letter_for_index(chosen_index), q->answer[choices[chosen_index].source_index]);
    if (correct_display_index < choice_count) {
        printf("Correct answer: %c. %s\n", quiz_letter_for_index(correct_display_index), q->answer[choices[correct_display_index].source_index]);
    } else if (correct_index < QUESTION_ANSWER_COUNT && q->answer[correct_index] != NULL) {
        printf("Correct answer: %c. %s\n", q->correct, q->answer[correct_index]);
    } else {
        printf("Correct answer: %c\n", q->correct);
    }
}
