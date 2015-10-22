#include <stdio.h>
#include "wich.h"
#include "refcounting.h"
double f(int x);

double
f(int x)
{
    ENTER();
    double y;

    y = 1.0;
    {
        EXIT();
        return (x + -y);
    }
    EXIT();
}

int
main(int argc, char *argv[])
{
    setup_error_handlers();
    ENTER();
    double z;

    z = f(2);
    if (!z) {
        MARK();
        print_string(String_new("z==0"));
        RELEASE();
    }
    else {
        MARK();
        print_string(String_new("z!=0"));
        RELEASE();
    }
    EXIT();
    return 0;
}
