#include <stdio.h>
#include "wich.h"

PVector_ptr foo(int x);

PVector_ptr foo(int x)
{
    PVector_ptr y;
    PVector_ptr z;
    y = Vector_new((double []){2,4,6}, 3);
    z = Vector_div(y,Vector_from_int(x,(y).vector->length));
    return z;

}


int main(int ____c, char *____v[])
{
	setup_error_handlers();
	double f;
	PVector_ptr v;
	f = 5.00;
	v = Vector_mul(foo(2),Vector_from_float(f,(foo(2)).vector->length));
	print_vector(v);
	return 0;
}

