target triple = "x86_64-apple-macosx10.11.0"
%PVector = type { %heap_object, i32, i64, [0 x %_PVectorFatNode] }
%heap_object = type {}
%_PVectorFatNode = type { double, %_PVectorFatNodeElem* }
%_PVectorFatNodeElem = type { %heap_object, i32, double, %_PVectorFatNodeElem* }
%PVector_ptr = type { i32, %PVector* }


define void @bar(%PVector_ptr* %x) {
entry:
	%0 = load %PVector_ptr, %PVector_ptr* %x
	call void (%PVector_ptr, i32, double) @set_ith(%PVector_ptr %0, i32 0, double 100.00e+00)
	call void (%PVector_ptr) @print_vector(%PVector_ptr %0)
	ret void
}

define i32 @main(i32 %argc, i8** %argv) {
entry:
	; declare variable
	%x = alloca %PVector_ptr

	; expression double[]{1,2,3}
	%0 = alloca [3 x double]
	%1 = getelementptr [3 x double], [3 x double]* %0, i64 0, i64 0
	store double 1.00e+00, double* %1
	%2 = getelementptr double, double* %1, i64 1
	store double 2.00e+00, double* %2
	%3 = getelementptr double, double* %2, i64 1
	store double 3.00e+00, double* %3
	%4 = getelementptr [3 x double], [3 x double]* %0, i64 0, i64 0

	; x = Vector_new(...);
	%5 = call %PVector_ptr (double*, i32) @PVector_new(double* %4, i32 3)
	store %PVector_ptr %5, %PVector_ptr* %x

	%local_str = getelementptr [4 x i8], [4 x i8]* @str, i32 0, i32 0
	%version = getelementptr %PVector_ptr, %PVector_ptr* %x, i32 0, i32 0
	%num = load i32, i32* %version
	call i32 (i8*, ...) @printf(i8* %local_str, i32 %num)

	; bar(x)
	call void @bar(%PVector_ptr* %x)

	%7 = load %PVector_ptr, %PVector_ptr* %x
	; set_ith(x, 1-1, 99)

	call void (%PVector_ptr, i32, double) @set_ith(%PVector_ptr %7, i32 0, double 99.00e+00)

	; print_vector(x)
	call void (%PVector_ptr) @print_vector(%PVector_ptr %7)

	ret i32 0
}

declare i32 @printf(i8*, ...)

; Wich builtin functions
declare void @print_vector(%PVector_ptr)
declare void @set_ith(%PVector_ptr, i32, double)
declare %PVector_ptr @PVector_new(double*, i32)

@str = private unnamed_addr constant[4 x i8] c "%d\0A\00", align 1