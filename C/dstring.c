#include "dstring.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

static bool dstr_reserve(DString *s, size_t needed) {
    if (needed <= s->cap) {
        return true;
    }

    size_t new_cap = s->cap ? s->cap : DSTRING_MIN_CAP;

    while (new_cap < needed) {
        if (new_cap > SIZE_MAX / 2) {
            return false;
        }
        new_cap *= 2;
    }

    char *new_data = realloc(s->data, new_cap);
    if (!new_data) {
        return false;
    }

    s->data = new_data;
    s->cap = new_cap;
    return true;
}

void dstr_clear(DString *s) {
    if (s->data != NULL) {
        s->data[0] = '\0';
    }
    s->len = 0;
}

bool dstr_init(DString *s) {
    s->data = NULL;
    s->cap = 0;

    if (!dstr_reserve(s, DSTRING_MIN_CAP)) {
        return false;
    }

    dstr_clear(s);
    return true;
}

void dstr_free(DString *s) {
    free(s->data);
    s->data = NULL;
    s->len = 0;
    s->cap = 0;
}

bool dstr_append_mem(DString *s, const void *data, size_t n) {
    if (n > SIZE_MAX - s->len - 1) {
        return false;
    }

    size_t needed = s->len + n + 1;

    if (!dstr_reserve(s, needed)) {
        return false;
    }

    memcpy(s->data + s->len, data, n);
    s->len += n;
    s->data[s->len] = '\0';

    return true;
}

bool dstr_append_cstr(DString *s, const char *text) {
    return dstr_append_mem(s, text, strlen(text));
}

bool dstr_assign_cstr(DString *s, const char *text) {
    dstr_clear(s);
    return dstr_append_cstr(s, text);
}

bool dstr_push_char(DString *s, char c) {
    return dstr_append_mem(s, &c, 1);
}

bool dstr_insert_mem(DString *s, size_t pos, const void *data, size_t n) {
    if (pos > s->len) {
        return false;
    }

    if (n > SIZE_MAX - s->len - 1) {
        return false;
    }

    size_t needed = s->len + n + 1;

    if (!dstr_reserve(s, needed)) {
        return false;
    }

    memmove(s->data + pos + n, s->data + pos, s->len - pos + 1);
    memcpy(s->data + pos, data, n);

    s->len += n;
    return true;
}

bool dstr_insert_cstr(DString *s, size_t pos, const char *text) {
    return dstr_insert_mem(s, pos, text, strlen(text));
}

bool dstr_erase(DString *s, size_t pos, size_t n) {
    if (pos > s->len) {
        return false;
    }

    if (n > s->len - pos) {
        n = s->len - pos;
    }

    memmove(s->data + pos, s->data + pos + n, s->len - pos - n + 1);
    s->len -= n;

    return true;
}

bool dstr_copy(DString *dest, const DString *src) {
    dstr_clear(dest);
    return dstr_append_mem(dest, src->data, src->len);
}

char *dstr_detach(DString *s) {
    char *result = s->data;

    s->data = NULL;
    s->len = 0;
    s->cap = 0;

    return result;
}

bool dstr_readline(FILE *fp, DString *line)
{
    int ch;

    dstr_clear(line);

    while ((ch = fgetc(fp)) != EOF)
    {
        if (!dstr_push_char(line, (char)ch))
            return false;

        if (ch == '\n')
            break;
    }

    if (ch == EOF && line->len == 0)
        return false;

    return true;
}

int dstr_test(void) {
    DString s;

    if (!dstr_init(&s)) {
        fprintf(stderr, "Failed to initialize string\n");
        return 1;
    }

    dstr_append_cstr(&s, "Hello");
    dstr_push_char(&s, ',');
    dstr_push_char(&s, ' ');
    dstr_append_cstr(&s, "world");

    printf("%s\n", s.data);
    printf("Length: %zu\n", s.len);
    printf("Capacity: %zu\n", s.cap);

    dstr_insert_cstr(&s, 5, " dynamic");
    printf("%s\n", s.data);

    dstr_erase(&s, 5, 8);
    printf("%s\n", s.data);

    dstr_free(&s);
    return 0;
}
