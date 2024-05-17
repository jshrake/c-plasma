// test.c
#include <stdio.h>
#include <libPlasma/c/slaw.h>

int main() {
    slaw s = slaw_string("hello darkness my old friend");
    char const *o = slaw_string_emit(s);
    printf("%s\n", o);
    return 0;
}