	.file	"test_sin_opt.c"
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.globl	nombre_archivo
	.section	.rodata
.LC0:
	.string	"resultados/DIA-sin-opt.txt"
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
# test_sin_opt.c:19:     if (argc < 2) {
	cmpl	$1, -52(%rbp)	#, argc
	jg	.L2	#,
# test_sin_opt.c:20:         perror("Falta el parámetro N.");
	leaq	.LC1(%rip), %rax	#, tmp147
	movq	%rax, %rdi	# tmp147,
	call	perror@PLT	#
# test_sin_opt.c:21:         return EXIT_FAILURE;
	movl	$1, %eax	#, _67
	jmp	.L3	#
.L2:
# test_sin_opt.c:23:     int N = atoi(argv[1]);
	movq	-64(%rbp), %rax	# argv, tmp148
	addq	$8, %rax	#, _1
# test_sin_opt.c:23:     int N = atoi(argv[1]);
	movq	(%rax), %rax	# *_1, _2
	movq	%rax, %rdi	# _2,
	call	atoi@PLT	#
	movl	%eax, -40(%rbp)	# tmp149, N
# test_sin_opt.c:28:     int ITER = (int)(PRODUCTO / N);
	movabsq	$7000000000, %rax	#, PRODUCTO.0_3
	movl	-40(%rbp), %edx	# N, tmp150
	movslq	%edx, %rcx	# tmp150, _4
	cqto
	idivq	%rcx	# _4
# test_sin_opt.c:28:     int ITER = (int)(PRODUCTO / N);
	movl	%eax, -36(%rbp)	# _5, ITER
# test_sin_opt.c:30:     FILE *file = fopen(nombre_archivo, "a");  // Abrimos el archivo en modo escritura
	movq	nombre_archivo(%rip), %rax	# nombre_archivo, nombre_archivo.1_6
	leaq	.LC2(%rip), %rdx	#, tmp153
	movq	%rdx, %rsi	# tmp153,
	movq	%rax, %rdi	# nombre_archivo.1_6,
	call	fopen@PLT	#
	movq	%rax, -32(%rbp)	# tmp154, file
# test_sin_opt.c:31:     if (!file) {
	cmpq	$0, -32(%rbp)	#, file
	jne	.L4	#,
# test_sin_opt.c:32:         perror("No se pudo abrir el archivo para escribir");
	leaq	.LC3(%rip), %rax	#, tmp155
	movq	%rax, %rdi	# tmp155,
	call	perror@PLT	#
# test_sin_opt.c:33:         return EXIT_FAILURE;
	movl	$1, %eax	#, _67
	jmp	.L3	#
.L4:
# test_sin_opt.c:38:     float *x = malloc(N * sizeof(float));
	movl	-40(%rbp), %eax	# N, tmp156
	cltq
	salq	$2, %rax	#, _8
	movq	%rax, %rdi	# _8,
	call	malloc@PLT	#
	movq	%rax, -24(%rbp)	# tmp157, x
# test_sin_opt.c:39:     float *y = malloc(N * sizeof(float));
	movl	-40(%rbp), %eax	# N, tmp158
	cltq
	salq	$2, %rax	#, _10
	movq	%rax, %rdi	# _10,
	call	malloc@PLT	#
	movq	%rax, -16(%rbp)	# tmp159, y
# test_sin_opt.c:40:     if (!x || !y) {
	cmpq	$0, -24(%rbp)	#, x
	je	.L5	#,
# test_sin_opt.c:40:     if (!x || !y) {
	cmpq	$0, -16(%rbp)	#, y
	jne	.L6	#,
.L5:
# test_sin_opt.c:41:     	perror("No se pudo asignar memoria");
	leaq	.LC4(%rip), %rax	#, tmp160
	movq	%rax, %rdi	# tmp160,
	call	perror@PLT	#
# test_sin_opt.c:42:         return EXIT_FAILURE;
	movl	$1, %eax	#, _67
	jmp	.L3	#
.L6:
# test_sin_opt.c:48:     for (i = 0; i < N; i++) {
	movl	$0, -48(%rbp)	#, i
# test_sin_opt.c:48:     for (i = 0; i < N; i++) {
	jmp	.L7	#
.L8:
# test_sin_opt.c:49:         x[i] = i;
	movl	-48(%rbp), %eax	# i, tmp161
	cltq
	leaq	0(,%rax,4), %rdx	#, _12
	movq	-24(%rbp), %rax	# x, tmp162
	addq	%rdx, %rax	# _12, _13
# test_sin_opt.c:49:         x[i] = i;
	pxor	%xmm0, %xmm0	# _14
	cvtsi2ssl	-48(%rbp), %xmm0	# i, _14
	movss	%xmm0, (%rax)	# _14, *_13
# test_sin_opt.c:50:         y[i] = i;
	movl	-48(%rbp), %eax	# i, tmp163
	cltq
	leaq	0(,%rax,4), %rdx	#, _16
	movq	-16(%rbp), %rax	# y, tmp164
	addq	%rdx, %rax	# _16, _17
# test_sin_opt.c:50:         y[i] = i;
	pxor	%xmm0, %xmm0	# _18
	cvtsi2ssl	-48(%rbp), %xmm0	# i, _18
	movss	%xmm0, (%rax)	# _18, *_17
# test_sin_opt.c:48:     for (i = 0; i < N; i++) {
	addl	$1, -48(%rbp)	#, i
.L7:
# test_sin_opt.c:48:     for (i = 0; i < N; i++) {
	movl	-48(%rbp), %eax	# i, tmp165
	cmpl	-40(%rbp), %eax	# N, tmp165
	jl	.L8	#,
# test_sin_opt.c:56:     gettimeofday(&overhead_start, NULL);
	movl	$0, %esi	#,
	leaq	overhead_start(%rip), %rax	#, tmp166
	movq	%rax, %rdi	# tmp166,
	call	gettimeofday@PLT	#
# test_sin_opt.c:57:     gettimeofday(&overhead_end, NULL);
	movl	$0, %esi	#,
	leaq	overhead_end(%rip), %rax	#, tmp167
	movq	%rax, %rdi	# tmp167,
	call	gettimeofday@PLT	#
# test_sin_opt.c:58:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	movq	overhead_end(%rip), %rax	# overhead_end.tv_sec, _19
# test_sin_opt.c:58:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	movq	overhead_start(%rip), %rdx	# overhead_start.tv_sec, _20
# test_sin_opt.c:58:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	subq	%rdx, %rax	# _20, _21
# test_sin_opt.c:58:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	pxor	%xmm1, %xmm1	# _22
	cvtsi2sdq	%rax, %xmm1	# _21, _22
# test_sin_opt.c:59:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	movq	8+overhead_end(%rip), %rax	# overhead_end.tv_usec, _23
# test_sin_opt.c:59:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	movq	8+overhead_start(%rip), %rdx	# overhead_start.tv_usec, _24
# test_sin_opt.c:59:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	subq	%rdx, %rax	# _24, _25
# test_sin_opt.c:59:                (overhead_end.tv_usec - overhead_start.tv_usec) / 1e6;
	pxor	%xmm0, %xmm0	# _26
	cvtsi2sdq	%rax, %xmm0	# _25, _26
	movsd	.LC5(%rip), %xmm2	#, tmp168
	divsd	%xmm2, %xmm0	# tmp168, _27
# test_sin_opt.c:58:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	addsd	%xmm1, %xmm0	# _22, _28
# test_sin_opt.c:58:     overhead = (overhead_end.tv_sec - overhead_start.tv_sec) +
	movsd	%xmm0, overhead(%rip)	# _28, overhead
# test_sin_opt.c:64:     gettimeofday(&start_time, NULL);
	movl	$0, %esi	#,
	leaq	start_time(%rip), %rax	#, tmp169
	movq	%rax, %rdi	# tmp169,
	call	gettimeofday@PLT	#
# test_sin_opt.c:66:     for(k=0; k<ITER; k++) {
	movl	$0, -44(%rbp)	#, k
# test_sin_opt.c:66:     for(k=0; k<ITER; k++) {
	jmp	.L9	#
.L15:
# test_sin_opt.c:67:         for(i=0; i<N; i++) {
	movl	$0, -48(%rbp)	#, i
# test_sin_opt.c:67:         for(i=0; i<N; i++) {
	jmp	.L10	#
.L14:
# test_sin_opt.c:68:             if(i==N/2) {
	movl	-40(%rbp), %eax	# N, tmp170
	movl	%eax, %edx	# tmp170, tmp171
	shrl	$31, %edx	#, tmp171
	addl	%edx, %eax	# tmp171, tmp172
	sarl	%eax	# tmp173
# test_sin_opt.c:68:             if(i==N/2) {
	cmpl	%eax, -48(%rbp)	# _29, i
	jne	.L11	#,
# test_sin_opt.c:69:                 x[i] = 0;
	movl	-48(%rbp), %eax	# i, tmp174
	cltq
	leaq	0(,%rax,4), %rdx	#, _31
	movq	-24(%rbp), %rax	# x, tmp175
	addq	%rdx, %rax	# _31, _32
# test_sin_opt.c:69:                 x[i] = 0;
	pxor	%xmm0, %xmm0	# tmp176
	movss	%xmm0, (%rax)	# tmp176, *_32
	jmp	.L12	#
.L11:
# test_sin_opt.c:70:             } else if(i==N-1) {
	movl	-40(%rbp), %eax	# N, tmp177
	subl	$1, %eax	#, _33
# test_sin_opt.c:70:             } else if(i==N-1) {
	cmpl	%eax, -48(%rbp)	# _33, i
	jne	.L13	#,
# test_sin_opt.c:71:                 x[i] = N-1;
	movl	-40(%rbp), %eax	# N, tmp178
	leal	-1(%rax), %edx	#, _34
# test_sin_opt.c:71:                 x[i] = N-1;
	movl	-48(%rbp), %eax	# i, tmp179
	cltq
	leaq	0(,%rax,4), %rcx	#, _36
	movq	-24(%rbp), %rax	# x, tmp180
	addq	%rcx, %rax	# _36, _37
# test_sin_opt.c:71:                 x[i] = N-1;
	pxor	%xmm0, %xmm0	# _38
	cvtsi2ssl	%edx, %xmm0	# _34, _38
	movss	%xmm0, (%rax)	# _38, *_37
	jmp	.L12	#
.L13:
# test_sin_opt.c:73:                 x[i] = x[i]+y[i];
	movl	-48(%rbp), %eax	# i, tmp181
	cltq
	leaq	0(,%rax,4), %rdx	#, _40
	movq	-24(%rbp), %rax	# x, tmp182
	addq	%rdx, %rax	# _40, _41
	movss	(%rax), %xmm1	# *_41, _42
# test_sin_opt.c:73:                 x[i] = x[i]+y[i];
	movl	-48(%rbp), %eax	# i, tmp183
	cltq
	leaq	0(,%rax,4), %rdx	#, _44
	movq	-16(%rbp), %rax	# y, tmp184
	addq	%rdx, %rax	# _44, _45
	movss	(%rax), %xmm0	# *_45, _46
# test_sin_opt.c:73:                 x[i] = x[i]+y[i];
	movl	-48(%rbp), %eax	# i, tmp185
	cltq
	leaq	0(,%rax,4), %rdx	#, _48
	movq	-24(%rbp), %rax	# x, tmp186
	addq	%rdx, %rax	# _48, _49
# test_sin_opt.c:73:                 x[i] = x[i]+y[i];
	addss	%xmm1, %xmm0	# _42, _50
# test_sin_opt.c:73:                 x[i] = x[i]+y[i];
	movss	%xmm0, (%rax)	# _50, *_49
.L12:
# test_sin_opt.c:67:         for(i=0; i<N; i++) {
	addl	$1, -48(%rbp)	#, i
.L10:
# test_sin_opt.c:67:         for(i=0; i<N; i++) {
	movl	-48(%rbp), %eax	# i, tmp187
	cmpl	-40(%rbp), %eax	# N, tmp187
	jl	.L14	#,
# test_sin_opt.c:66:     for(k=0; k<ITER; k++) {
	addl	$1, -44(%rbp)	#, k
.L9:
# test_sin_opt.c:66:     for(k=0; k<ITER; k++) {
	movl	-44(%rbp), %eax	# k, tmp188
	cmpl	-36(%rbp), %eax	# ITER, tmp188
	jl	.L15	#,
# test_sin_opt.c:78:     gettimeofday(&end_time, NULL);
	movl	$0, %esi	#,
	leaq	end_time(%rip), %rax	#, tmp189
	movq	%rax, %rdi	# tmp189,
	call	gettimeofday@PLT	#
# test_sin_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	movq	end_time(%rip), %rax	# end_time.tv_sec, _51
# test_sin_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	movq	start_time(%rip), %rdx	# start_time.tv_sec, _52
# test_sin_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	subq	%rdx, %rax	# _52, _53
# test_sin_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	pxor	%xmm1, %xmm1	# _54
	cvtsi2sdq	%rax, %xmm1	# _53, _54
# test_sin_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	movq	8+end_time(%rip), %rax	# end_time.tv_usec, _55
# test_sin_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	movq	8+start_time(%rip), %rdx	# start_time.tv_usec, _56
# test_sin_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	subq	%rdx, %rax	# _56, _57
# test_sin_opt.c:80:              (end_time.tv_usec - start_time.tv_usec)/1.e6)
	pxor	%xmm0, %xmm0	# _58
	cvtsi2sdq	%rax, %xmm0	# _57, _58
	movsd	.LC5(%rip), %xmm2	#, tmp190
	divsd	%xmm2, %xmm0	# tmp190, _59
# test_sin_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	addsd	%xmm1, %xmm0	# _54, _60
# test_sin_opt.c:81:              - overhead)/ITER;
	movsd	overhead(%rip), %xmm1	# overhead, overhead.2_61
	subsd	%xmm1, %xmm0	# overhead.2_61, _62
# test_sin_opt.c:81:              - overhead)/ITER;
	pxor	%xmm1, %xmm1	# _63
	cvtsi2sdl	-36(%rbp), %xmm1	# ITER, _63
# test_sin_opt.c:79:     tiempo = ((end_time.tv_sec - start_time.tv_sec +
	divsd	%xmm1, %xmm0	# _63, tmp191
	movsd	%xmm0, -8(%rbp)	# tmp191, tiempo
# test_sin_opt.c:85:     fprintf(file, "%d\t%.6f\n", N, tiempo);
	movq	-8(%rbp), %rcx	# tiempo, tmp192
	movl	-40(%rbp), %edx	# N, tmp193
	movq	-32(%rbp), %rax	# file, tmp194
	movq	%rcx, %xmm0	# tmp192,
	leaq	.LC7(%rip), %rcx	#, tmp195
	movq	%rcx, %rsi	# tmp195,
	movq	%rax, %rdi	# tmp194,
	movl	$1, %eax	#,
	call	fprintf@PLT	#
# test_sin_opt.c:87:     free(x);
	movq	-24(%rbp), %rax	# x, tmp196
	movq	%rax, %rdi	# tmp196,
	call	free@PLT	#
# test_sin_opt.c:88:     free(y);
	movq	-16(%rbp), %rax	# y, tmp197
	movq	%rax, %rdi	# tmp197,
	call	free@PLT	#
# test_sin_opt.c:90:     fclose(file);  // Cerramos el archivo
	movq	-32(%rbp), %rax	# file, tmp198
	movq	%rax, %rdi	# tmp198,
	call	fclose@PLT	#
# test_sin_opt.c:91:     return 0;
	movl	$0, %eax	#, _67
.L3:
# test_sin_opt.c:92: }
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
