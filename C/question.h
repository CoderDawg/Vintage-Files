#ifndef QUESTION_H
#define QUESTION_H

#include <stdbool.h>
#include <stddef.h>

#include "dstring.h"

#define QUESTION_ANSWER_COUNT 26

typedef struct {
    char correct;
    char *question;
    char *answer[QUESTION_ANSWER_COUNT];
    size_t answer_count;
    int used;
} Question;

void question_init(Question *q);
void question_free(Question *q);
bool question_from_line(const DString *line, Question *q);

#endif // QUESTION_H
