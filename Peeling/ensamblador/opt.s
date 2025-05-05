	.file	"test_opt.c"
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.globl	nombre_archivo
	.section	.rodata
.LC0:
	.string	"resultados/DIA-opt.txt"
	.section	.data.rel.local,"aw"
	.align 8
	.type	nombre_archivo, @object
	.size	nombre_archivo, 8
nombre_archivo:
	.quad	.LC0
	.globl	PRODUCTO
	.section	.rodata
	.align 8
	.type	PRODUCTO, @object
	.size	PRODUCTO, 8
PRODUCTO:
	.quad	7000000000
	.globl	start_time
	.bss
	.align 16
	.type	start_time, @object
	.size	start_time, 16
start_time:
	.zero	16
	.globl	end_time
	.align 16
	.type	end_time, @object
	.size	end_time, 16
end_time:
	.zero	16
	.globl	overhead_start
	.align 16
	.type	overhead_start, @object
	.size	overhead_start, 16
overhead_start:
	.zero	16
	.globl	overhead_end
	.align 16
	.type	overhead_end, @object
	.size	overhead_end, 16
overhead_end:
	.zero	16
	.globl	overhead
	.align 8
	.type	overhead, @object
	.size	overhead, 8
overhead:
	.zero	8
	.section	.rodata
.LC1:
	.string	"Falta el par\303\241metro N."
.LC2:
	.string	"a"
	.align 8
.LC3:
	.string	"No se pudo abrir el archivo para escribir"
.LC4:
	.string	"No se pudo asignar memoria"
.LC7:
	.string	"%d\t%.6f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$64, %rsp	#,
	movl	%edi, -52(%rbp)	# argc, argc
	movq	%rsi, -64(%rbp)	# argv, argv
# test_opt.c:20:     if (argc < 2) {
	cmpl	$1, -52(%rbp)	#, argc
	jg	.L2	#,
# test_opt.c:21:         perror("Falta el parámetro N.");
	leaq	.LC1(%rip), %rax	#, tmp162
	movq	%rax, %rdi	# tmp162,
	call	perror@PLT	#
# test_opt.c:22:         return EXIT_FAILURE;
	movl	$1, %eax	#, _83
	jmp	.L3	#
.L2:
# test_opt.c:24:     int N = atoi(argv[1]);
	movq	-64(%rbp), %rax	# argv, tmp163
	addq	$8, %rax	#, _1
# test_opt.c:24:     int N = atoi(argv[1]);
	movq	(%rax), %rax	# *_1, _2
	movq	%rax, %rdi	# _2,
	call	atoi@PLT	#
	movl	%eax, -40(%rbp)	# tmp164, N
# test_opt.c:29:     int ITER = (int)(PRODUCTO / N);
	movabsq	$7000000000, %rax	#, PRODUCTO.0_3
	movl	-40(%rbp), %edx	# N, tmp165
	movslq	%edx, %rcx	# tmp165, _4
	cqto
	idivq	%rcx	# _4
# test_opt.c:29:     int ITER = (int)(PRODUCTO / N);
	movl	%eax, -36(%rbp)	# _5, ITER
# test_opt.c:31:     FILE *file = fopen(nombre_archivo, "a");  // Abrimos el archivo en modo escritura
	movq	nombre_archivo(%rip), %rax	# nombre_archivo, nombre_archivo.1_6
	leaq	.LC2(%rip), %rdx	#, tmp168
	movq	%rdx, %rsi	# tmp168,
	movq	%rax, %rdi	# nombre_archivo.1_6,
	call	fopen@PLT	#
	movq	%rax, -32(%rbp)	# tmp169, file
# test_opt.c:32:     if (!file) {
	cmpq	$0, -32(%rbp)	#, file
	jne	.L4	#,
# test_opt.c:33:         perror("No se pudo abrir el archivo para escribir");
	leaq	.LC3(%rip), %rax	#, tmp170
	movq	%rax, %rdi	# tmp170,
	call	perror@PLT	#
# test_opt.c:34:         return EXIT_FAILURE;
	movl	$1, %eax	#, _83
	jmp	.L3	#
.L4:
# test_opt.c:39:     float *x = malloc(N * sizeof(float));
	movl	-40(%rbp), %eax	# N, tmp171
	cltq
	salq	$2, %rax	#, _8
	movq	%rax, %rdi	# _8,
	call	malloc@PLT	#
	movq	%rax, -24(%rbp)	# tmp172, x
# test_opt.c:40:     float *y = malloc(N * sizeof(float));
	movl	-40(%rbp), %eax	# N, tmp173
	cltq
	salq	$2, %rax	#, _10
	movq	%rax, %rdi	# _10,
	call	malloc@PLT	#
	movq	%rax, -16(%rbp)	# tmp174, y
# test_opt.c:41:     if (!x || !y) {
	cmpq	$0, -24(%rbp)	#, x
	je	.L5	#,
# test_opt.c:41:     if (!x || !y) {
	cmpq	$0, -16(%rbp)	#, y
	jne	.L6	#,
.L5:
# test_opt.c:42:         perror("No se pudo asignar memoria");
	leaq	.LC4(%rip), %rax	#, tmp175
	movq	%rax, %rdi	# tmp175,
	call	perror@PLT	#
# test_opt.c:43:         return EXIT_FAILURE;
	movl	$1, %eax	#, _83
	jmp	.L3	#
.L6:
# test_opt.c:49:     for (i = 0; i < N; i++) {
	movl	$0, -48(%rbp)	#, i
# test_opt.c:49:     for (i = 0; i < N; i++) {
	jmp	.L7	#
.L8:
# test_opt.c:50:         x[i] = i;
	movl	-48(%rbp), %eax	# i, tmp176
	cltq
	leaq	0(,%rax,4), %rdx	#, _12
	movq	-24(%rbp), %rax	# x, tmp177
	addq	%rdx, %rax	# _12, _13
# test_opt.c:50:         x[i] = i;
	pxor	%xmm0, %xmm0	# _14
	cvtsi2ssl	-48(%rbp), %xmm0	# i, _14
	movss	%xmm0, (%rax)	# _14, *_13
# test_opt.c:51:         y[i] = i;
	movl	-48(%rbp), %eax	# i, tmp178
	cltq
	leaq	0(,%rax,4), %rdx	#, _16
	movq	-16(%rbp), %rax	# y, tmp179
	addq	%rdx, %rax	# _16, _17
# test_opt.c:51:         y[i] = i;
	pxor	%xmm0, %xmm0	# _18
	cvtsi2ssl	-48(%rbp), %xmm0	# i, _18
	movss	%xmm0, (%rax)	# _18, *_17
# test_opt.c:49:     for (i = 0; i < N; i++) {
	addl	$1, -48(%rbp)	#, i
.L7:
# test_opt.c:49:     for (i = 0; i < N; i++) {
	movl	-48(%rbp), %eax	# i, tmp180
	cmpl	-40(%rbp), %eax	# N, tmp180
	jl	.L8	#,
# test_opt.c:57:     gettimeofday(&overhead_start, NULL);
	movl	$0, %esi	#,
	leaq	overhead_start(%rip), %rax	#, tmp181
	movq	%rax, %rdi	# tmp181,
	call	gettimeofday@PLT	#
# test_opt.c:58:     gettimeofday(&overhead_end, NULL);
	movl	$0, %esi	#,
	leaq	overhead_end(%rip), %rax	#, tmp182
	movq	%rax, %rdi	# tmp182,
	call	gettimeofday@PLT	#
# test_opt.c:59:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	movq	overhead_end(%rip), %rax	# overhead_end.tv_sec, _19
# test_opt.c:59:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	movq	overhead_start(%rip), %rdx	# overhead_start.tv_sec, _20
# test_opt.c:59:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	subq	%rdx, %rax	# _20, _21
# test_opt.c:59:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	pxor	%xmm1, %xmm1	# _22
	cvtsi2sdq	%rax, %xmm1	# _21, _22
# test_opt.c:60:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	movq	8+overhead_end(%rip), %rax	# overhead_end.tv_usec, _23
# test_opt.c:60:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	movq	8+overhead_start(%rip), %rdx	# overhead_start.tv_usec, _24
# test_opt.c:60:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	subq	%rdx, %rax	# _24, _25
# test_opt.c:60:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	pxor	%xmm0, %xmm0	# _26
	cvtsi2sdq	%rax, %xmm0	# _25, _26
	movsd	.LC5(%rip), %xmm2	#, tmp183
	divsd	%xmm2, %xmm0	# tmp183, _27
# test_opt.c:59:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	addsd	%xmm1, %xmm0	# _22, _28
# test_opt.c:59:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	movsd	%xmm0, overhead(%rip)	# _28, overhead
# test_opt.c:65:     gettimeofday(&start_time, NULL);
	movl	$0, %esi	#,
	leaq	start_time(%rip), %rax	#, tmp184
	movq	%rax, %rdi	# tmp184,
	call	gettimeofday@PLT	#
# test_opt.c:67:     for(k = 0; k<ITER; k++) {
	movl	$0, -44(%rbp)	#, k
# test_opt.c:67:     for(k = 0; k<ITER; k++) {
	jmp	.L9	#
.L14:
# test_opt.c:68:         for(i = 0; i<N/2; i++) {
	movl	$0, -48(%rbp)	#, i
# test_opt.c:68:         for(i = 0; i<N/2; i++) {
	jmp	.L10	#
.L11:
# test_opt.c:69:             x[i] = x[i] + y[i];
	movl	-48(%rbp), %eax	# i, tmp185
	cltq
	leaq	0(,%rax,4), %rdx	#, _30
	movq	-24(%rbp), %rax	# x, tmp186
	addq	%rdx, %rax	# _30, _31
	movss	(%rax), %xmm1	# *_31, _32
# test_opt.c:69:             x[i] = x[i] + y[i];
	movl	-48(%rbp), %eax	# i, tmp187
	cltq
	leaq	0(,%rax,4), %rdx	#, _34
	movq	-16(%rbp), %rax	# y, tmp188
	addq	%rdx, %rax	# _34, _35
	movss	(%rax), %xmm0	# *_35, _36
# test_opt.c:69:             x[i] = x[i] + y[i];
	movl	-48(%rbp), %eax	# i, tmp189
	cltq
	leaq	0(,%rax,4), %rdx	#, _38
	movq	-24(%rbp), %rax	# x, tmp190
	addq	%rdx, %rax	# _38, _39
# test_opt.c:69:             x[i] = x[i] + y[i];
	addss	%xmm1, %xmm0	# _32, _40
# test_opt.c:69:             x[i] = x[i] + y[i];
	movss	%xmm0, (%rax)	# _40, *_39
# test_opt.c:68:         for(i = 0; i<N/2; i++) {
	addl	$1, -48(%rbp)	#, i
.L10:
# test_opt.c:68:         for(i = 0; i<N/2; i++) {
	movl	-40(%rbp), %eax	# N, tmp191
	movl	%eax, %edx	# tmp191, tmp192
	shrl	$31, %edx	#, tmp192
	addl	%edx, %eax	# tmp192, tmp193
	sarl	%eax	# tmp194
# test_opt.c:68:         for(i = 0; i<N/2; i++) {
	cmpl	%eax, -48(%rbp)	# _41, i
	jl	.L11	#,
# test_opt.c:71:         x[N/2]=0;
	movl	-40(%rbp), %eax	# N, tmp195
	movl	%eax, %edx	# tmp195, tmp196
	shrl	$31, %edx	#, tmp196
	addl	%edx, %eax	# tmp196, tmp197
	sarl	%eax	# tmp198
	cltq
# test_opt.c:71:         x[N/2]=0;
	leaq	0(,%rax,4), %rdx	#, _44
	movq	-24(%rbp), %rax	# x, tmp199
	addq	%rdx, %rax	# _44, _45
# test_opt.c:71:         x[N/2]=0;
	pxor	%xmm0, %xmm0	# tmp200
	movss	%xmm0, (%rax)	# tmp200, *_45
# test_opt.c:72:         for(i = N/2 + 1; i<N - 1; i++) {
	movl	-40(%rbp), %eax	# N, tmp201
	movl	%eax, %edx	# tmp201, tmp202
	shrl	$31, %edx	#, tmp202
	addl	%edx, %eax	# tmp202, tmp203
	sarl	%eax	# tmp204
# test_opt.c:72:         for(i = N/2 + 1; i<N - 1; i++) {
	addl	$1, %eax	#, tmp205
	movl	%eax, -48(%rbp)	# tmp205, i
# test_opt.c:72:         for(i = N/2 + 1; i<N - 1; i++) {
	jmp	.L12	#
.L13:
# test_opt.c:73:             x[i] = x[i] + y[i];
	movl	-48(%rbp), %eax	# i, tmp206
	cltq
	leaq	0(,%rax,4), %rdx	#, _48
	movq	-24(%rbp), %rax	# x, tmp207
	addq	%rdx, %rax	# _48, _49
	movss	(%rax), %xmm1	# *_49, _50
# test_opt.c:73:             x[i] = x[i] + y[i];
	movl	-48(%rbp), %eax	# i, tmp208
	cltq
	leaq	0(,%rax,4), %rdx	#, _52
	movq	-16(%rbp), %rax	# y, tmp209
	addq	%rdx, %rax	# _52, _53
	movss	(%rax), %xmm0	# *_53, _54
# test_opt.c:73:             x[i] = x[i] + y[i];
	movl	-48(%rbp), %eax	# i, tmp210
	cltq
	leaq	0(,%rax,4), %rdx	#, _56
	movq	-24(%rbp), %rax	# x, tmp211
	addq	%rdx, %rax	# _56, _57
# test_opt.c:73:             x[i] = x[i] + y[i];
	addss	%xmm1, %xmm0	# _50, _58
# test_opt.c:73:             x[i] = x[i] + y[i];
	movss	%xmm0, (%rax)	# _58, *_57
# test_opt.c:72:         for(i = N/2 + 1; i<N - 1; i++) {
	addl	$1, -48(%rbp)	#, i
.L12:
# test_opt.c:72:         for(i = N/2 + 1; i<N - 1; i++) {
	movl	-40(%rbp), %eax	# N, tmp212
	subl	$1, %eax	#, _59
# test_opt.c:72:         for(i = N/2 + 1; i<N - 1; i++) {
	cmpl	%eax, -48(%rbp)	# _59, i
	jl	.L13	#,
# test_opt.c:75:         x[N - 1] = N - 1;
	movl	-40(%rbp), %eax	# N, tmp213
	leal	-1(%rax), %edx	#, _60
# test_opt.c:75:         x[N - 1] = N - 1;
	movl	-40(%rbp), %eax	# N, tmp214
	cltq
	salq	$2, %rax	#, _62
	leaq	-4(%rax), %rcx	#, _63
	movq	-24(%rbp), %rax	# x, tmp215
	addq	%rcx, %rax	# _63, _64
# test_opt.c:75:         x[N - 1] = N - 1;
	pxor	%xmm0, %xmm0	# _65
	cvtsi2ssl	%edx, %xmm0	# _60, _65
	movss	%xmm0, (%rax)	# _65, *_64
# test_opt.c:67:     for(k = 0; k<ITER; k++) {
	addl	$1, -44(%rbp)	#, k
.L9:
# test_opt.c:67:     for(k = 0; k<ITER; k++) {
	movl	-44(%rbp), %eax	# k, tmp216
	cmpl	-36(%rbp), %eax	# ITER, tmp216
	jl	.L14	#,
# test_opt.c:78:     gettimeofday(&end_time, NULL);
	movl	$0, %esi	#,
	leaq	end_time(%rip), %rax	#, tmp217
	movq	%rax, %rdi	# tmp217,
	call	gettimeofday@PLT	#
# test_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	movq	end_time(%rip), %rax	# end_time.tv_sec, _66
# test_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	movq	start_time(%rip), %rdx	# start_time.tv_sec, _67
# test_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	subq	%rdx, %rax	# _67, _68
# test_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	pxor	%xmm1, %xmm1	# _69
	cvtsi2sdq	%rax, %xmm1	# _68, _69
# test_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	movq	8+end_time(%rip), %rax	# end_time.tv_usec, _70
# test_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	movq	8+start_time(%rip), %rdx	# start_time.tv_usec, _71
# test_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	subq	%rdx, %rax	# _71, _72
# test_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	pxor	%xmm0, %xmm0	# _73
	cvtsi2sdq	%rax, %xmm0	# _72, _73
	movsd	.LC5(%rip), %xmm2	#, tmp218
	divsd	%xmm2, %xmm0	# tmp218, _74
# test_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	addsd	%xmm1, %xmm0	# _69, _75
# test_opt.c:81:              - overhead)/ITER;
	movsd	overhead(%rip), %xmm1	# overhead, overhead.2_76
	subsd	%xmm1, %xmm0	# overhead.2_76, _77
# test_opt.c:81:              - overhead)/ITER;
	pxor	%xmm1, %xmm1	# _78
	cvtsi2sdl	-36(%rbp), %xmm1	# ITER, _78
# test_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	divsd	%xmm1, %xmm0	# _78, tmp219
	movsd	%xmm0, -8(%rbp)	# tmp219, tiempo
# test_opt.c:85:     fprintf(file, "%d\t%.6f\n", N, tiempo);
	movq	-8(%rbp), %rcx	# tiempo, tmp220
	movl	-40(%rbp), %edx	# N, tmp221
	movq	-32(%rbp), %rax	# file, tmp222
	movq	%rcx, %xmm0	# tmp220,
	leaq	.LC7(%rip), %rcx	#, tmp223
	movq	%rcx, %rsi	# tmp223,
	movq	%rax, %rdi	# tmp222,
	movl	$1, %eax	#,
	call	fprintf@PLT	#
# test_opt.c:87:     free(x);
	movq	-24(%rbp), %rax	# x, tmp224
	movq	%rax, %rdi	# tmp224,
	call	free@PLT	#
# test_opt.c:88:     free(y);
	movq	-16(%rbp), %rax	# y, tmp225
	movq	%rax, %rdi	# tmp225,
	call	free@PLT	#
# test_opt.c:90:     fclose(file);  // Cerramos el archivo
	movq	-32(%rbp), %rax	# file, tmp226
	movq	%rax, %rdi	# tmp226,
	call	fclose@PLT	#
# test_opt.c:91:     return 0;
	movl	$0, %eax	#, _83
.L3:
# test_opt.c:92: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC5:
	.long	0
	.long	1093567616
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
