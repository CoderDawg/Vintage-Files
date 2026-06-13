#ifndef DSTRING_H
#define DSTRING_H

#include <stdio.h>
#include <stdbool.h>
#include <stddef.h>

typedef struct {
    char *data;
    size_t len;
    size_t cap;
} DString;

#define DSTRING_MIN_CAP 16

bool dstr_init(DString *s);
void dstr_free(DString *s);
void dstr_clear(DString *s);
bool dstr_append_mem(DString *s, const void *data, size_t n);
bool dstr_append_cstr(DString *s, const char *text);
bool dstr_assign_cstr(DString *s, const char *text);
bool dstr_push_char(DString *s, char c);
bool dstr_insert_mem(DString *s, size_t pos, const void *data, size_t n);
bool dstr_insert_cstr(DString *s, size_t pos, const char *text);
bool dstr_erase(DString *s, size_t pos, size_t n);
bool dstr_copy(DString *dest, const DString *src);
char *dstr_detach(DString *s);
bool dstr_readline(FILE *fp, DString *line);
int dstr_test(void);
#endif // DSTRING_H
