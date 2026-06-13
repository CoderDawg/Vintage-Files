#include "quiz_internal.h"

static void print_answer_key(const Question *q, const Attempt *attempt) {
    printf("  Answer key:\n");
    for (size_t i = 0; i < attempt->choice_count; i++) {
        size_t source_index = attempt->choice_order[i];
        printf("    %c. %s", quiz_letter_for_index(i), q->answer[source_index]);
        if (source_index == attempt->correct_index) {
            printf("  <-- correct");
        }
        if (attempt->answered && i == attempt->chosen_index) {
            printf("  <-- your answer");
        }
        putchar('\n');
    }
}

void quiz_print_answer_key(const Question *q, const Attempt *attempt) {
    print_answer_key(q, attempt);
}

void quiz_print_question_snippet(const char *text, char *buffer, size_t buffer_size) {
    const size_t max_chars = 56;
    size_t i = 0;

    if (buffer_size == 0) {
        return;
    }

    while (text[i] != '\0' && text[i] != '\n' && text[i] != '\r' && i + 1 < buffer_size) {
        if (i >= max_chars) {
            break;
        }
        buffer[i] = text[i];
        i++;
    }

    if (text[i] != '\0' && text[i] != '\n' && text[i] != '\r' && i + 4 < buffer_size) {
        buffer[i++] = '.';
        buffer[i++] = '.';
        buffer[i++] = '.';
    }

    buffer[i] = '\0';
}

void quiz_print_summary(const Question *questions, const Attempt *attempts, size_t attempt_count, size_t total_questions, QuizMode mode) {
    size_t right = 0;
    size_t wrong = 0;

    for (size_t i = 0; i < attempt_count; i++) {
        if (attempts[i].correct) {
            right++;
        } else {
            wrong++;
        }
    }

    printf("\nResults (%s mode)\n", mode == MODE_LEARNING ? "learning" : "test");
    printf("Answered: %zu of %zu\n", attempt_count, total_questions);
    printf("Right: %zu\n", right);
    printf("Wrong: %zu\n", wrong);

    if (attempt_count > 0) {
        double right_pct = (100.0 * (double)right) / (double)attempt_count;
        double wrong_pct = (100.0 * (double)wrong) / (double)attempt_count;
        printf("Right %%: %.1f%%\n", right_pct);
        printf("Wrong %%: %.1f%%\n", wrong_pct);
    } else {
        puts("Right %: 0.0%");
        puts("Wrong %: 0.0%");
    }

    puts("\nAttempt summary:");
    if (attempt_count == 0) {
        puts("No questions attempted.");
    } else {
        puts(" #   Status  Choice  Correct  Question");
        puts("---  ------  ------  -------  ------------------------------");

        for (size_t i = 0; i < attempt_count; i++) {
            const Question *q = &questions[attempts[i].question_index];
            char snippet[61];
            quiz_print_question_snippet(q->question, snippet, sizeof(snippet));

            const char *status = attempts[i].correct ? "right" : "wrong";
            char chosen_label = '?';
            if (attempts[i].chosen_index < attempts[i].choice_count) {
                chosen_label = quiz_letter_for_index(attempts[i].chosen_index);
            }

            size_t correct_display_index = attempts[i].choice_count;
            for (size_t j = 0; j < attempts[i].choice_count; j++) {
                if (attempts[i].choice_order[j] == attempts[i].correct_index) {
                    correct_display_index = j;
                    break;
                }
            }

            char correct_buf[2] = { '?', '\0' };
            if (correct_display_index < attempts[i].choice_count) {
                correct_buf[0] = quiz_letter_for_index(correct_display_index);
            } else if (attempts[i].correct_index < q->answer_count) {
                correct_buf[0] = q->correct;
            }

            printf("%2zu   %-6s  %c       %c       %s\n",
                   i + 1,
                   status,
                   chosen_label,
                   correct_buf[0],
                   snippet);
        }
    }

    if (wrong > 0) {
        puts("\nMissed questions:");
        for (size_t i = 0; i < attempt_count; i++) {
            if (attempts[i].correct) {
                continue;
            }

            const Question *q = &questions[attempts[i].question_index];
            printf("- %s\n", q->question);
            if (attempts[i].chosen_index < attempts[i].choice_count) {
                size_t chosen_source = attempts[i].choice_order[attempts[i].chosen_index];
                printf("  Your answer: %c. %s\n",
                       quiz_letter_for_index(attempts[i].chosen_index),
                       q->answer[chosen_source]);
            } else {
                printf("  Your answer: %c\n", quiz_letter_for_index(attempts[i].chosen_index));
            }

            size_t correct_display_index = attempts[i].choice_count;
            size_t correct_source_index = QUESTION_ANSWER_COUNT;
            for (size_t j = 0; j < attempts[i].choice_count; j++) {
                if (attempts[i].choice_order[j] == attempts[i].correct_index) {
                    correct_display_index = j;
                    correct_source_index = attempts[i].choice_order[j];
                    break;
                }
            }

            if (correct_display_index < attempts[i].choice_count && correct_source_index < q->answer_count && q->answer[correct_source_index] != NULL) {
                printf("  Correct: %c. %s\n",
                       quiz_letter_for_index(correct_display_index),
                       q->answer[correct_source_index]);
            } else {
                printf("  Correct: %c\n", q->correct);
            }

            quiz_print_answer_key(q, &attempts[i]);
        }
    }

    if (attempt_count < total_questions) {
        printf("\nQuiz ended early. %zu question(s) were not attempted.\n", total_questions - attempt_count);
    }
}
