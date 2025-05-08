	.file	"code.c"
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O0 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.globl	inicio
	.bss
	.align 16
	.type	inicio, @object
	.size	inicio, 16
inicio:
	.zero	16
	.globl	final
	.align 16
	.type	final, @object
	.size	final, 16
final:
	.zero	16
	.globl	overhead
	.align 16
	.type	overhead, @object
	.size	overhead, 16
overhead:
	.zero	16
	.globl	tiempo
	.align 8
	.type	tiempo, @object
	.size	tiempo, 8
tiempo:
	.zero	8
	.globl	tiempo_overhead
	.align 8
	.type	tiempo_overhead, @object
	.size	tiempo_overhead, 8
tiempo_overhead:
	.zero	8
	.globl	nombre_archivo
	.align 8
	.type	nombre_archivo, @object
	.size	nombre_archivo, 8
nombre_archivo:
	.zero	8
	.text
	.globl	producto
	.type	producto, @function
producto:
.LFB0:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movss	%xmm0, -4(%rbp)	# x, x
	movss	%xmm1, -8(%rbp)	# y, y
	movq	%rdi, -16(%rbp)	# z, z
# code.c:12:     *z=x*y;
	movss	-4(%rbp), %xmm0	# x, tmp83
	mulss	-8(%rbp), %xmm0	# y, _1
# code.c:12:     *z=x*y;
	movq	-16(%rbp), %rax	# z, tmp84
	movss	%xmm0, (%rax)	# _1, *z_5(D)
# code.c:13: }
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE0:
	.size	producto, .-producto
	.section	.rodata
	.align 8
.LC0:
	.string	"Debes pasar un nombre de fichero"
.LC1:
	.string	"a"
.LC2:
	.string	"No se pudo abrir el fichero"
.LC7:
	.string	"%d\t%.9f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB1:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	leaq	-2998272(%rsp), %r11	#,
.LPSRL0:
	subq	$4096, %rsp	#,
	orq	$0, (%rsp)	#,
	cmpq	%r11, %rsp	#,
	jne	.LPSRL0
	subq	$1792, %rsp	#,
	movl	%edi, -3000052(%rbp)	# argc, argc
	movq	%rsi, -3000064(%rbp)	# argv, argv
# code.c:15: int main(int argc, char** argv) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp179
	movq	%rax, -8(%rbp)	# tmp179, D.2524
	xorl	%eax, %eax	# tmp179
# code.c:20:     if (argc < 2) {
	cmpl	$1, -3000052(%rbp)	#, argc
	jg	.L3	#,
# code.c:21:         perror("Debes pasar un nombre de fichero");
	leaq	.LC0(%rip), %rax	#, tmp125
	movq	%rax, %rdi	# tmp125,
	call	perror@PLT	#
# code.c:22:         return 1;
	movl	$1, %eax	#, _48
	jmp	.L16	#
.L3:
# code.c:24:     nombre_archivo = argv[1];
	movq	-3000064(%rbp), %rax	# argv, tmp126
	movq	8(%rax), %rax	# MEM[(char * *)argv_57(D) + 8B], _1
	movq	%rax, nombre_archivo(%rip)	# _1, nombre_archivo
# code.c:25:     FILE* file = fopen(nombre_archivo, "a");
	movq	nombre_archivo(%rip), %rax	# nombre_archivo, nombre_archivo.0_2
	leaq	.LC1(%rip), %rdx	#, tmp127
	movq	%rdx, %rsi	# tmp127,
	movq	%rax, %rdi	# nombre_archivo.0_2,
	call	fopen@PLT	#
	movq	%rax, -3000024(%rbp)	# tmp128, file
# code.c:26:     if (file == NULL) {
	cmpq	$0, -3000024(%rbp)	#, file
	jne	.L5	#,
# code.c:27:         perror("No se pudo abrir el fichero");
	leaq	.LC2(%rip), %rax	#, tmp129
	movq	%rax, %rdi	# tmp129,
	call	perror@PLT	#
# code.c:28:         return 1;
	movl	$1, %eax	#, _48
	jmp	.L16	#
.L5:
# code.c:32:     for(i=0;i<Nmax;i++) { /* Valores de las matrices */
	movl	$0, -3000036(%rbp)	#, i
# code.c:32:     for(i=0;i<Nmax;i++) { /* Valores de las matrices */
	jmp	.L6	#
.L9:
# code.c:33:         for(j=0;j<Nmax;j++) {
	movl	$0, -3000032(%rbp)	#, j
# code.c:33:         for(j=0;j<Nmax;j++) {
	jmp	.L7	#
.L8:
# code.c:34:             A[i][j]=(i+j)/(j+1.1);
	movl	-3000036(%rbp), %edx	# i, tmp130
	movl	-3000032(%rbp), %eax	# j, tmp131
	addl	%edx, %eax	# tmp130, _3
# code.c:34:             A[i][j]=(i+j)/(j+1.1);
	pxor	%xmm0, %xmm0	# _4
	cvtsi2sdl	%eax, %xmm0	# _3, _4
# code.c:34:             A[i][j]=(i+j)/(j+1.1);
	pxor	%xmm2, %xmm2	# _5
	cvtsi2sdl	-3000032(%rbp), %xmm2	# j, _5
	movsd	.LC3(%rip), %xmm1	#, tmp132
	addsd	%xmm2, %xmm1	# _5, _6
# code.c:34:             A[i][j]=(i+j)/(j+1.1);
	divsd	%xmm1, %xmm0	# _6, _7
	cvtsd2ss	%xmm0, %xmm0	# _7, _8
# code.c:34:             A[i][j]=(i+j)/(j+1.1);
	movl	-3000032(%rbp), %eax	# j, tmp134
	movslq	%eax, %rdx	# tmp134, tmp133
	movl	-3000036(%rbp), %eax	# i, tmp136
	cltq
	imulq	$500, %rax, %rax	#, tmp135, tmp137
	addq	%rdx, %rax	# tmp133, tmp138
	movss	%xmm0, -3000016(%rbp,%rax,4)	# _8, A[i_43][j_45]
# code.c:35:             B[i][j]=(i-j)/(j+2.1);
	movl	-3000036(%rbp), %eax	# i, tmp139
	subl	-3000032(%rbp), %eax	# j, _9
# code.c:35:             B[i][j]=(i-j)/(j+2.1);
	pxor	%xmm0, %xmm0	# _10
	cvtsi2sdl	%eax, %xmm0	# _9, _10
# code.c:35:             B[i][j]=(i-j)/(j+2.1);
	pxor	%xmm2, %xmm2	# _11
	cvtsi2sdl	-3000032(%rbp), %xmm2	# j, _11
	movsd	.LC4(%rip), %xmm1	#, tmp140
	addsd	%xmm2, %xmm1	# _11, _12
# code.c:35:             B[i][j]=(i-j)/(j+2.1);
	divsd	%xmm1, %xmm0	# _12, _13
	cvtsd2ss	%xmm0, %xmm0	# _13, _14
# code.c:35:             B[i][j]=(i-j)/(j+2.1);
	movl	-3000032(%rbp), %eax	# j, tmp142
	movslq	%eax, %rdx	# tmp142, tmp141
	movl	-3000036(%rbp), %eax	# i, tmp144
	cltq
	imulq	$500, %rax, %rax	#, tmp143, tmp145
	addq	%rdx, %rax	# tmp141, tmp146
	movss	%xmm0, -2000016(%rbp,%rax,4)	# _14, B[i_43][j_45]
# code.c:33:         for(j=0;j<Nmax;j++) {
	addl	$1, -3000032(%rbp)	#, j
.L7:
# code.c:33:         for(j=0;j<Nmax;j++) {
	cmpl	$499, -3000032(%rbp)	#, j
	jle	.L8	#,
# code.c:32:     for(i=0;i<Nmax;i++) { /* Valores de las matrices */
	addl	$1, -3000036(%rbp)	#, i
.L6:
# code.c:32:     for(i=0;i<Nmax;i++) { /* Valores de las matrices */
	cmpl	$499, -3000036(%rbp)	#, i
	jle	.L9	#,
# code.c:40:     clock_gettime(CLOCK_MONOTONIC, &overhead);
	leaq	overhead(%rip), %rax	#, tmp147
	movq	%rax, %rsi	# tmp147,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:41:     clock_gettime(CLOCK_MONOTONIC, &inicio);
	leaq	inicio(%rip), %rax	#, tmp148
	movq	%rax, %rsi	# tmp148,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:43:     for(j=0;j<Nmax;j++) { /* Producto matricial */
	movl	$0, -3000032(%rbp)	#, j
# code.c:43:     for(j=0;j<Nmax;j++) { /* Producto matricial */
	jmp	.L10	#
.L15:
# code.c:44:         for(i=0;i<Nmax;i++) {
	movl	$0, -3000036(%rbp)	#, i
# code.c:44:         for(i=0;i<Nmax;i++) {
	jmp	.L11	#
.L14:
# code.c:45:             t=0;
	pxor	%xmm0, %xmm0	# tmp149
	movss	%xmm0, -3000040(%rbp)	# tmp149, t
# code.c:46:             for (k=0;k<Nmax;k++) {
	movl	$0, -3000028(%rbp)	#, k
# code.c:46:             for (k=0;k<Nmax;k++) {
	jmp	.L12	#
.L13:
# code.c:47:                 producto(A[i][k],B[k][j],&r);
	movl	-3000032(%rbp), %eax	# j, tmp151
	movslq	%eax, %rdx	# tmp151, tmp150
	movl	-3000028(%rbp), %eax	# k, tmp153
	cltq
	imulq	$500, %rax, %rax	#, tmp152, tmp154
	addq	%rdx, %rax	# tmp150, tmp155
	movss	-2000016(%rbp,%rax,4), %xmm0	# B[k_47][j_46], _15
	movl	-3000028(%rbp), %eax	# k, tmp157
	movslq	%eax, %rdx	# tmp157, tmp156
	movl	-3000036(%rbp), %eax	# i, tmp159
	cltq
	imulq	$500, %rax, %rax	#, tmp158, tmp160
	addq	%rdx, %rax	# tmp156, tmp161
	movl	-3000016(%rbp,%rax,4), %eax	# A[i_44][k_47], _16
	leaq	-3000044(%rbp), %rdx	#, tmp162
	movq	%rdx, %rdi	# tmp162,
	movaps	%xmm0, %xmm1	# _15,
	movd	%eax, %xmm0	# _16,
	call	producto	#
# code.c:48:                 t+=r; 
	movss	-3000044(%rbp), %xmm0	# r, r.1_17
	movss	-3000040(%rbp), %xmm1	# t, tmp164
	addss	%xmm1, %xmm0	# tmp164, tmp163
	movss	%xmm0, -3000040(%rbp)	# tmp163, t
# code.c:46:             for (k=0;k<Nmax;k++) {
	addl	$1, -3000028(%rbp)	#, k
.L12:
# code.c:46:             for (k=0;k<Nmax;k++) {
	cmpl	$499, -3000028(%rbp)	#, k
	jle	.L13	#,
# code.c:50:             C[i][j]=t; 
	movl	-3000032(%rbp), %eax	# j, tmp166
	movslq	%eax, %rdx	# tmp166, tmp165
	movl	-3000036(%rbp), %eax	# i, tmp168
	cltq
	imulq	$500, %rax, %rax	#, tmp167, tmp169
	addq	%rdx, %rax	# tmp165, tmp170
	movss	-3000040(%rbp), %xmm0	# t, tmp171
	movss	%xmm0, -1000016(%rbp,%rax,4)	# tmp171, C[i_44][j_46]
# code.c:44:         for(i=0;i<Nmax;i++) {
	addl	$1, -3000036(%rbp)	#, i
.L11:
# code.c:44:         for(i=0;i<Nmax;i++) {
	cmpl	$499, -3000036(%rbp)	#, i
	jle	.L14	#,
# code.c:43:     for(j=0;j<Nmax;j++) { /* Producto matricial */
	addl	$1, -3000032(%rbp)	#, j
.L10:
# code.c:43:     for(j=0;j<Nmax;j++) { /* Producto matricial */
	cmpl	$499, -3000032(%rbp)	#, j
	jle	.L15	#,
# code.c:54:     clock_gettime(CLOCK_MONOTONIC, &final);
	leaq	final(%rip), %rax	#, tmp172
	movq	%rax, %rsi	# tmp172,
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	inicio(%rip), %rax	# inicio.tv_sec, _18
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	overhead(%rip), %rdx	# overhead.tv_sec, _19
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	subq	%rdx, %rax	# _19, _20
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _21
	cvtsi2sdq	%rax, %xmm1	# _20, _21
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	8+inicio(%rip), %rax	# inicio.tv_nsec, _22
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	8+overhead(%rip), %rdx	# overhead.tv_nsec, _23
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	subq	%rdx, %rax	# _23, _24
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _25
	cvtsi2sdq	%rax, %xmm0	# _24, _25
	movsd	.LC6(%rip), %xmm2	#, tmp173
	divsd	%xmm2, %xmm0	# tmp173, _26
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	addsd	%xmm1, %xmm0	# _21, _27
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movsd	%xmm0, tiempo_overhead(%rip)	# _27, tiempo_overhead
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	final(%rip), %rax	# final.tv_sec, _28
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	inicio(%rip), %rdx	# inicio.tv_sec, _29
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	subq	%rdx, %rax	# _29, _30
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# _31
	cvtsi2sdq	%rax, %xmm1	# _30, _31
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	8+final(%rip), %rax	# final.tv_nsec, _32
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	8+inicio(%rip), %rdx	# inicio.tv_nsec, _33
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	subq	%rdx, %rax	# _33, _34
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# _35
	cvtsi2sdq	%rax, %xmm0	# _34, _35
	movsd	.LC6(%rip), %xmm2	#, tmp174
	divsd	%xmm2, %xmm0	# tmp174, _36
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	addsd	%xmm1, %xmm0	# _31, _37
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movsd	%xmm0, tiempo(%rip)	# _37, tiempo
# code.c:59:     tiempo = tiempo - tiempo_overhead;
	movsd	tiempo(%rip), %xmm0	# tiempo, tiempo.2_38
	movsd	tiempo_overhead(%rip), %xmm1	# tiempo_overhead, tiempo_overhead.3_39
	subsd	%xmm1, %xmm0	# tiempo_overhead.3_39, _40
# code.c:59:     tiempo = tiempo - tiempo_overhead;
	movsd	%xmm0, tiempo(%rip)	# _40, tiempo
# code.c:62:     fprintf(file, "%d\t%.9f\n", Nmax, tiempo);
	movq	tiempo(%rip), %rdx	# tiempo, tiempo.4_41
	movq	-3000024(%rbp), %rax	# file, tmp175
	movq	%rdx, %xmm0	# tiempo.4_41,
	movl	$500, %edx	#,
	leaq	.LC7(%rip), %rcx	#, tmp176
	movq	%rcx, %rsi	# tmp176,
	movq	%rax, %rdi	# tmp175,
	movl	$1, %eax	#,
	call	fprintf@PLT	#
# code.c:65:     fclose(file);
	movq	-3000024(%rbp), %rax	# file, tmp177
	movq	%rax, %rdi	# tmp177,
	call	fclose@PLT	#
# code.c:66:     return 0;
	movl	$0, %eax	#, _48
.L16:
# code.c:67: }
	movq	-8(%rbp), %rdx	# D.2524, tmp180
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp180
	je	.L17	#,
# code.c:67: }
	call	__stack_chk_fail@PLT	#
.L17:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE1:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC3:
	.long	-1717986918
	.long	1072798105
	.align 8
.LC4:
	.long	-858993459
	.long	1073794252
	.align 8
.LC6:
	.long	0
	.long	1104006501
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
