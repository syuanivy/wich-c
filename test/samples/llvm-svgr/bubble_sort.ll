%struct.heap_object = type { %struct._object_metadata*, i32, %struct.heap_object* }
target triple = "x86_64-apple-macosx10.11.0"

; ///////// ///////// D A T A  S T R U C T U R E S ///////// /////////
%struct._object_metadata = type { i8*, i16, [0 x i16] }
%struct.Heap_Info = type { i8*, i8*, i8*, i32, i32, i32, i32, i32, i32, i32 }
%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.PVector_ptr = type { i32, %struct.PVector* }
%struct.PVector = type { %struct.heap_object, i32, i64, [0 x %struct._PVectorFatNode] }
%struct._PVectorFatNode = type { double, %struct._PVectorFatNodeElem* }
%struct._PVectorFatNodeElem = type { %struct.heap_object, i32, double, %struct._PVectorFatNodeElem* }
%struct.string = type { %struct.heap_object, i64, [0 x i8] }

declare %struct.PVector_ptr @PVector_init(double, i64)

declare void @print_pvector(%struct.PVector_ptr)

declare %struct.PVector_ptr @PVector_new(double*, i64)

declare void @set_ith(%struct.PVector_ptr, i32, double)

declare double @ith(%struct.PVector_ptr, i32)

declare i8* @PVector_as_string(%struct.PVector_ptr)

; ///////// ///////// W I C H  R U N T I M E  F U N C T I O N S ///////// /////////
declare %struct.PVector_ptr @Vector_empty(i64)

declare %struct.PVector_ptr @Vector_copy(%struct.PVector_ptr)

declare %struct.PVector_ptr @Vector_new(double*, i64)

declare %struct.PVector_ptr @Vector_from_int(i32, i64)

declare %struct.PVector_ptr @Vector_from_float(double, i64)

declare %struct.PVector_ptr @Vector_add(%struct.PVector_ptr, %struct.PVector_ptr)

declare %struct.PVector_ptr @Vector_sub(%struct.PVector_ptr, %struct.PVector_ptr)

declare %struct.PVector_ptr @Vector_mul(%struct.PVector_ptr, %struct.PVector_ptr)

declare %struct.PVector_ptr @Vector_div(%struct.PVector_ptr, %struct.PVector_ptr)

declare i32 @Vector_len(%struct.PVector_ptr)

declare void @print_vector(%struct.PVector_ptr)

declare %struct.string* @String_new(i8*)

declare %struct.string* @String_from_char(i8 signext)

declare %struct.string* @String_add(%struct.string*, %struct.string*)

declare %struct.string* @String_from_vector(%struct.PVector_ptr)

declare %struct.string* @String_from_int(i32)

declare %struct.string* @String_from_float(double)

declare void @print_string(%struct.string*)

declare zeroext i1 @String_eq(%struct.string*, %struct.string*)

declare zeroext i1 @String_neq(%struct.string*, %struct.string*)

declare zeroext i1 @String_gt(%struct.string*, %struct.string*)

declare zeroext i1 @String_ge(%struct.string*, %struct.string*)

declare zeroext i1 @String_lt(%struct.string*, %struct.string*)

declare zeroext i1 @String_le(%struct.string*, %struct.string*)

declare i32 @String_len(%struct.string*)

declare void (i32)* @signal(i32, void (i32)*)

; ///////// ///////// G C ///////// /////////

declare i32 @gc_num_roots(...)

declare void @gc_set_num_roots(i32)

declare void @gc_add_root(i8**)

declare void @gc(...)

declare void @get_heap_info(%struct.Heap_Info* sret, ...)

declare void @gc_shutdown(...)

; ///////// ///////// S Y S T E M  F U N C T I O N S ///////// /////////
declare i32 @fprintf(%struct.__sFILE*, i8*, ...)

declare void @exit(i32)

declare i32 @printf(i8*, ...)

declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1)

; ///////// ///////// I N L I N E  F U N C T I O N S ///////// /////////
define internal { i32, %struct.PVector* } @PVector_copy(i32 %v.coerce0, %struct.PVector* %v.coerce1) {
%1 = alloca %struct.PVector_ptr, align 8
%v = alloca %struct.PVector_ptr, align 8
%2 = bitcast %struct.PVector_ptr* %v to { i32, %struct.PVector* }*
%3 = getelementptr inbounds { i32, %struct.PVector* }, { i32, %struct.PVector* }* %2, i32 0, i32 0
store i32 %v.coerce0, i32* %3, align 8
%4 = getelementptr inbounds { i32, %struct.PVector* }, { i32, %struct.PVector* }* %2, i32 0, i32 1
store %struct.PVector* %v.coerce1, %struct.PVector** %4, align 8
%5 = getelementptr inbounds %struct.PVector_ptr, %struct.PVector_ptr* %1, i32 0, i32 0
%6 = getelementptr inbounds %struct.PVector_ptr, %struct.PVector_ptr* %v, i32 0, i32 1
%7 = load %struct.PVector*, %struct.PVector** %6, align 8
%8 = getelementptr inbounds %struct.PVector, %struct.PVector* %7, i32 0, i32 1
%9 = load i32, i32* %8, align 8
%10 = add nsw i32 %9, 1
store i32 %10, i32* %8, align 8
store i32 %10, i32* %5, align 8
%11 = getelementptr inbounds %struct.PVector_ptr, %struct.PVector_ptr* %1, i32 0, i32 1
%12 = getelementptr inbounds %struct.PVector_ptr, %struct.PVector_ptr* %v, i32 0, i32 1
%13 = load %struct.PVector*, %struct.PVector** %12, align 8
store %struct.PVector* %13, %struct.PVector** %11, align 8
%14 = bitcast %struct.PVector_ptr* %1 to { i32, %struct.PVector* }*
%15 = load { i32, %struct.PVector* }, { i32, %struct.PVector* }* %14, align 8
ret { i32, %struct.PVector* } %15
}

define internal void @setup_error_handlers() {
%1 = call void (i32)* @signal(i32 11, void (i32)* @handle_sys_errors)
%2 = call void (i32)* @signal(i32 10, void (i32)* @handle_sys_errors)
ret void
}

define internal void @handle_sys_errors(i32 %errno) {
%1 = alloca i32, align 4
%signame = alloca i8*, align 8
store i32 %errno, i32* %1, align 4
store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i32 0, i32 0), i8** %signame, align 8
%2 = load i32, i32* %1, align 4
%3 = icmp eq i32 %2, 11
br i1 %3, label %4, label %5

; label:4                                       ; preds = %0
store i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.3, i32 0, i32 0), i8** %signame, align 8
br label %10

; label:5                                       ; preds = %0
%6 = load i32, i32* %1, align 4
%7 = icmp eq i32 %6, 10
br i1 %7, label %8, label %9

; label:8                                       ; preds = %5
store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.4, i32 0, i32 0), i8** %signame, align 8
br label %9

; label:9                                       ; preds = %8, %5
br label %10

; label:10                                      ; preds = %9, %4
%11 = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8
%12 = load i8*, i8** %signame, align 8
%13 = load i32, i32* %1, align 4
%14 = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %11, i8* getelementptr inbounds ([34 x i8], [34 x i8]* @.str.5, i32 0, i32 0), i8* %12, i32 %13)
%15 = load i32, i32* %1, align 4
call void @exit(i32 %15) #4
unreachable
                                              ; No predecessors!
ret void
}

; ///////// ///////// C O N S T A N T S ///////// /////////
@NIL_VECTOR = internal constant %struct.PVector_ptr { i32 -1, %struct.PVector* null }, align 8
@pf.str = private unnamed_addr constant [7 x i8] c"%1.2f\0A\00", align 1
@pi.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"UNKNOWN\00", align 1
@.str.3 = private unnamed_addr constant [8 x i8] c"SIGSEGV\00", align 1
@.str.4 = private unnamed_addr constant [7 x i8] c"SIGBUS\00", align 1
@__stderrp = external global %struct.__sFILE*, align 8
@.str.5 = private unnamed_addr constant [34 x i8] c"Wich is confused; signal %s (%d)\0A\00", align 1
@.str.6 = private unnamed_addr constant [36 x i8] c"%d objects remain after collection\0A\00", align 1
; ///////// ///////// G E N E R A T E D  C O D E ///////// /////////

define %struct.PVector_ptr @bubbleSort(%struct.PVector_ptr %vec0) {
entry:
%vec0_ = alloca %struct.PVector_ptr
store %struct.PVector_ptr %vec0, %struct.PVector_ptr* %vec0_
%retval_ = alloca %struct.PVector_ptr
%_funcsp = alloca i32, align 4
%____num_roots = call i32 (...) @gc_num_roots()
store i32 %____num_roots, i32* %_funcsp, align 4
%length0_ = alloca i32
%v0_ = alloca %struct.PVector_ptr
%v0_mcp_target_ = bitcast %struct.PVector_ptr* %v0_ to i8*
call void @llvm.memcpy.p0i8.p0i8.i64(i8* %v0_mcp_target_, i8* bitcast (%struct.PVector_ptr* @NIL_VECTOR to i8*), i64 16, i32 8, i1 false)
%v0_inner_ptr_ = getelementptr inbounds %struct.PVector_ptr, %struct.PVector_ptr* %v0_, i32 0, i32 1
%v0_raw_ptr_ = bitcast %struct.PVector** %v0_inner_ptr_ to i8**
call void @gc_add_root(i8** %v0_raw_ptr_)
%i0_ = alloca i32
%j0_ = alloca i32
%0 = load %struct.PVector_ptr, %struct.PVector_ptr* %vec0_
%1 = call i32 @Vector_len(%struct.PVector_ptr %0)
store i32 %1, i32* %length0_
%2 = load %struct.PVector_ptr, %struct.PVector_ptr* %vec0_
%3 = call %struct.PVector_ptr @Vector_copy(%struct.PVector_ptr %2)
store %struct.PVector_ptr %3, %struct.PVector_ptr* %v0_
%4 = add i32 1, 0
store i32 %4, i32* %i0_
%5 = add i32 1, 0
store i32 %5, i32* %j0_
br label %while.block_entry_0
while.block_entry_0:
%6 = load i32, i32* %i0_
%7 = load i32, i32* %length0_
%8 = icmp sle i32 %6, %7
br i1 %8, label %while.block_body_0, label %while.block_exit_0
while.block_body_0:
br label %while.block_entry_1
while.block_entry_1:
%9 = load i32, i32* %j0_
%10 = load i32, i32* %length0_
%11 = load i32, i32* %i0_
%12 = sub i32 %10, %11
%13 = icmp sle i32 %9, %12
br i1 %13, label %while.block_body_1, label %while.block_exit_1
while.block_body_1:
%vec_15 = load %struct.PVector_ptr, %struct.PVector_ptr* %v0_
%14 = load i32, i32* %j0_
%index_14 = sub i32 %14, 1
%15 = call double (%struct.PVector_ptr, i32) @ith(%struct.PVector_ptr %vec_15, i32 %index_14)
%vec_19 = load %struct.PVector_ptr, %struct.PVector_ptr* %v0_
%16 = load i32, i32* %j0_
%17 = add i32 1, 0
%18 = add i32 %16, %17
%index_18 = sub i32 %18, 1
%19 = call double (%struct.PVector_ptr, i32) @ith(%struct.PVector_ptr %vec_19, i32 %index_18)
%20 = fcmp ogt double %15, %19
br i1 %20, label %if.block_true_0, label %if.block_false_0
if.block_true_0:
%swap0_ = alloca double
%vec_22 = load %struct.PVector_ptr, %struct.PVector_ptr* %v0_
%21 = load i32, i32* %j0_
%index_21 = sub i32 %21, 1
%22 = call double (%struct.PVector_ptr, i32) @ith(%struct.PVector_ptr %vec_22, i32 %index_21)
store double %22, double* %swap0_
%23 = load %struct.PVector_ptr, %struct.PVector_ptr* %v0_
%24 = load i32, i32* %j0_
%index_24 = sub i32 %24, 1
%vec_28 = load %struct.PVector_ptr, %struct.PVector_ptr* %v0_
%25 = load i32, i32* %j0_
%26 = add i32 1, 0
%27 = add i32 %25, %26
%index_27 = sub i32 %27, 1
%28 = call double (%struct.PVector_ptr, i32) @ith(%struct.PVector_ptr %vec_28, i32 %index_27)
call void (%struct.PVector_ptr,i32,double) @set_ith(%struct.PVector_ptr %23, i32 %index_24, double %28)
%29 = load %struct.PVector_ptr, %struct.PVector_ptr* %v0_
%30 = load i32, i32* %j0_
%31 = add i32 1, 0
%32 = add i32 %30, %31
%index_32 = sub i32 %32, 1
%33 = load double, double* %swap0_
call void (%struct.PVector_ptr,i32,double) @set_ith(%struct.PVector_ptr %29, i32 %index_32, double %33)

br label %if.block_exit_0
if.block_false_0:
br label %if.block_exit_0
if.block_exit_0:
%34 = load i32, i32* %j0_
%35 = add i32 1, 0
%36 = add i32 %34, %35
store i32 %36, i32* %j0_

br label %while.block_entry_1
while.block_exit_1:
%37 = load i32, i32* %i0_
%38 = add i32 1, 0
%39 = add i32 %37, %38
store i32 %39, i32* %i0_

br label %while.block_entry_0
while.block_exit_0:
%40 = load %struct.PVector_ptr, %struct.PVector_ptr* %v0_
store %struct.PVector_ptr %40, %struct.PVector_ptr* %retval_
br label %ret_
return.exit_0:
br label %ret__
ret__:
br label %ret_

ret_:
%num_roots____ = load i32, i32* %_funcsp, align 4
call void @gc_set_num_roots(i32 %num_roots____)
%retval = load %struct.PVector_ptr, %struct.PVector_ptr* %retval_
ret %struct.PVector_ptr %retval
}


define i32 @main(i32 %argc, i8** %argv) {
entry:
%retval_ = alloca i32
%argc_ = alloca i32
%argv_ = alloca i8**
store i32 0, i32* %retval_
store i32 %argc, i32* %argc_
store i8** %argv, i8*** %argv_
call void () @setup_error_handlers()
%__info__ = alloca %struct.Heap_Info, align 8
%_funcsp = alloca i32, align 4
%____num_roots = call i32 (...) @gc_num_roots()
store i32 %____num_roots, i32* %_funcsp, align 4
%x0_ = alloca %struct.PVector_ptr
%x0_mcp_target_ = bitcast %struct.PVector_ptr* %x0_ to i8*
call void @llvm.memcpy.p0i8.p0i8.i64(i8* %x0_mcp_target_, i8* bitcast (%struct.PVector_ptr* @NIL_VECTOR to i8*), i64 16, i32 8, i1 false)
%x0_inner_ptr_ = getelementptr inbounds %struct.PVector_ptr, %struct.PVector_ptr* %x0_, i32 0, i32 1
%x0_raw_ptr_ = bitcast %struct.PVector** %x0_inner_ptr_ to i8**
call void @gc_add_root(i8** %x0_raw_ptr_)
%0 = alloca [4 x double]
%vpromo0_ = getelementptr [4 x double], [4 x double]* %0, i64 0, i64 0
%1 = add i32 1, 0
%promo0 = sitofp i32 %1 to double
store double %promo0, double* %vpromo0_
%vpromo1_ = getelementptr [4 x double], [4 x double]* %0, i64 0, i64 1
%2 = add i32 4, 0
%promo1 = sitofp i32 %2 to double
store double %promo1, double* %vpromo1_
%vpromo2_ = getelementptr [4 x double], [4 x double]* %0, i64 0, i64 2
%3 = add i32 2, 0
%promo2 = sitofp i32 %3 to double
store double %promo2, double* %vpromo2_
%v4_ = getelementptr [4 x double], [4 x double]* %0, i64 0, i64 3
%4 = fadd double 3.1, 0.00
store double %4, double* %v4_
%vec_ptr_5 = getelementptr [4 x double], [4 x double]* %0, i64 0, i64 0
%5 = call %struct.PVector_ptr @PVector_new(double* %vec_ptr_5, i64 4)
store %struct.PVector_ptr %5, %struct.PVector_ptr* %x0_
%6 = load %struct.PVector_ptr, %struct.PVector_ptr* %x0_
%7 = call %struct.PVector_ptr @Vector_copy(%struct.PVector_ptr %6)
%8 = call %struct.PVector_ptr (%struct.PVector_ptr) @bubbleSort(%struct.PVector_ptr %7)
call void (%struct.PVector_ptr) @print_vector(%struct.PVector_ptr %8)
br label %ret__
ret__:
br label %ret_

ret_:
%num_roots____ = load i32, i32* %_funcsp, align 4
call void @gc_set_num_roots(i32 %num_roots____)
call void (...) @gc()
call void (%struct.Heap_Info*, ...) @get_heap_info(%struct.Heap_Info* sret %__info__)
%info___ = getelementptr inbounds  %struct.Heap_Info, %struct.Heap_Info* %__info__, i32 0, i32 5
%info__ = load i32, i32* %info___, align 4
%heap_dirty__ = icmp ne i32 %info__, 0
br i1 %heap_dirty__, label %gc.heap_dirty____, label %gc.heap_clean____
gc.heap_dirty____:
%__stderr = load %struct.__sFILE*, %struct.__sFILE** @__stderrp, align 8
%remain_num___ = getelementptr inbounds  %struct.Heap_Info, %struct.Heap_Info* %__info__, i32 0, i32 5
%remain_num__ = load i32, i32* %remain_num___, align 4
%__fprintfret = call i32 (%struct.__sFILE*, i8*, ...) @fprintf(%struct.__sFILE* %__stderr, i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.6, i32 0, i32 0), i32 %remain_num__)
br label %gc.heap_clean____
gc.heap_clean____:
call void (...) @gc_shutdown()
%retval = load i32, i32* %retval_
ret i32 %retval
}


