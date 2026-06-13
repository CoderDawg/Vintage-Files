#include "question.h"

#include <ctype.h>
#include <stdlib.h>

static void dstr_reset(DString *s) {
    s->len = 0;
    if (s->data != NULL) {
        s->data[0] = '\0';
    }
}

static const char *csv_skip_spaces(const char *p) {
    while (*p == ' ' || *p == '\t') {
        p++;
    }
    return p;
}

static bool text_is_blank(const char *text) {
    if (text == NULL) {
        return true;
    }

    while (*text != '\0') {
        if (*text != ' ' && *text != '\t' && *text != '\n' && *text != '\r') {
            return false;
        }
        text++;
    }

    return true;
}

static bool csv_parse_unquoted_field(const char **cursor, DString *field) {
    const char *p = *cursor;

    while (*p != '\0' && *p != ',' && *p != '\n' && *p != '\r') {
        if (!dstr_push_char(field, *p)) {
            return false;
        }
        p++;
    }

    p = csv_skip_spaces(p);
    if (*p == ',') {
        p++;
    }
    p = csv_skip_spaces(p);

    *cursor = p;
    return true;
}

static bool csv_parse_quoted_field(const char **cursor, DString *field) {
    const char *p = *cursor + 1; /* Skip opening quote. */

    while (*p != '\0') {
        if (*p == '"') {
            if (p[1] == '"') {
                /* RFC 4180 style escaped quote. */
                if (!dstr_push_char(field, '"')) {
                    return false;
                }
                p += 2;
                continue;
            }

            /* Closing quote. */
            p++;
            p = csv_skip_spaces(p);
            if (*p == ',') {
                p++;
            }
            p = csv_skip_spaces(p);

            *cursor = p;
            return true;
        }

        if (!dstr_push_char(field, *p)) {
            return false;
        }
        p++;
    }

    return false;
}

static bool csv_next_field(const char **cursor, DString *field) {
    const char *p = *cursor;

    p = csv_skip_spaces(p);

    dstr_reset(field);

    if (*p == '\0' || *p == '\n' || *p == '\r') {
        *cursor = p;
        return true;
    }

    if (*p == '"') {
        return csv_parse_quoted_field(cursor, field);
    }

    return csv_parse_unquoted_field(cursor, field);
}

void question_init(Question *q) {
    q->correct = '\0';
    q->question = NULL;
    q->answer_count = 0;
    q->used = 0;
    for (size_t i = 0; i < QUESTION_ANSWER_COUNT; i++) {
        q->answer[i] = NULL;
    }
}

void question_free(Question *q) {
    free(q->question);
    q->question = NULL;

    for (size_t i = 0; i < QUESTION_ANSWER_COUNT; i++) {
        free(q->answer[i]);
        q->answer[i] = NULL;
    }

    q->correct = '\0';
    q->answer_count = 0;
    q->used = 0;
}

bool question_from_line(const DString *line, Question *q) {
    DString field;
    if (!dstr_init(&field)) {
        return false;
    }

    const char *cursor = line->data;
    bool ok = false;

    if (!csv_next_field(&cursor, &field)) {
        goto cleanup;
    }

    if (field.len == 0 || text_is_blank(field.data)) {
        goto cleanup;
    }
    q->correct = (char)toupper((unsigned char)field.data[0]);

    if (!csv_next_field(&cursor, &field)) {
        goto cleanup;
    }
    q->question = dstr_detach(&field);
    if (q->question == NULL || text_is_blank(q->question)) {
        goto cleanup;
    }

    while (true) {
        if (!csv_next_field(&cursor, &field)) {
            goto cleanup;
        }

        if (!text_is_blank(field.data)) {
            if (q->answer_count >= QUESTION_ANSWER_COUNT) {
                goto cleanup;
            }

            q->answer[q->answer_count] = dstr_detach(&field);
            q->answer_count++;
        }

        if (*cursor == '\0' || *cursor == '\n' || *cursor == '\r') {
            break;
        }
    }

    if (q->answer_count < 2) {
        goto cleanup;
    }

    size_t correct_index = (size_t)(q->correct - 'A');
    if (q->correct < 'A' || q->correct >= (char)('A' + q->answer_count) || correct_index >= q->answer_count) {
        goto cleanup;
    }

    ok = true;

cleanup:
    if (!ok) {
        question_free(q);
    }
    dstr_free(&field);
    return ok;
}
