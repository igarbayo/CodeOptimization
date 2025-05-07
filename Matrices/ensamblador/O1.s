	.file	"code.c"
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -O1 -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.globl	producto
	.type	producto, @function
producto:
.LFB23:
	.cfi_startproc
	endbr64	
# code.c:12:     *z=x*y;
	mulss	%xmm1, %xmm0	# tmp88, tmp86
# code.c:12:     *z=x*y;
	movss	%xmm0, (%rdi)	# tmp86, *z_5(D)
# code.c:13: }
	ret	
	.cfi_endproc
.LFE23:
	.size	producto, .-producto
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"Debes pasar un nombre de fichero"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"a"
.LC2:
	.string	"No se pudo abrir el fichero"
.LC4:
	.string	"%d\t%.9f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64	
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# code.c:20:     if (argc < 2) {
	cmpl	$1, %edi	#, tmp140
	jle	.L17	#,
# code.c:24:     nombre_archivo = argv[1];
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_47(D) + 8B], _1
	movq	%rdi, nombre_archivo(%rip)	# _1, nombre_archivo
# code.c:25:     FILE* file = fopen(nombre_archivo, "a");
	leaq	.LC1(%rip), %rsi	#, tmp111
	call	fopen@PLT	#
	movq	%rax, %rbx	# tmp142, file
# code.c:26:     if (file == NULL) {
	testq	%rax, %rax	# file
	je	.L18	#,
	movl	$700, %edx	#, ivtmp_7
.L5:
# code.c:15: int main(int argc, char** argv) {
	movl	$700, %eax	#, ivtmp_8
.L6:
# code.c:33:         for(j=0;j<Nmax;j++) {
	subl	$1, %eax	#, ivtmp_8
	jne	.L6	#,
# code.c:32:     for(i=0;i<Nmax;i++) { /* Valores de las matrices */
	subl	$1, %edx	#, ivtmp_7
	jne	.L5	#,
# code.c:40:     clock_gettime(CLOCK_MONOTONIC, &overhead);
	leaq	overhead(%rip), %rsi	#, tmp114
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:41:     clock_gettime(CLOCK_MONOTONIC, &inicio);
	leaq	inicio(%rip), %rsi	#, tmp115
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
	movl	$700, %ecx	#, ivtmp_69
	jmp	.L8	#
.L17:
# code.c:21:         perror("Debes pasar un nombre de fichero");
	leaq	.LC0(%rip), %rdi	#, tmp110
	call	perror@PLT	#
# code.c:22:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L2	#
.L18:
# code.c:27:         perror("No se pudo abrir el fichero");
	leaq	.LC2(%rip), %rdi	#, tmp113
	call	perror@PLT	#
# code.c:28:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L2	#
.L19:
# code.c:44:         for(i=0;i<Nmax;i++) {
	subl	$1, %edx	#, ivtmp_59
	je	.L10	#,
.L12:
	movl	$700, %eax	#, ivtmp_76
.L9:
# code.c:46:             for (k=0;k<Nmax;k++) {
	subl	$1, %eax	#, ivtmp_76
	jne	.L9	#,
	jmp	.L19	#
.L10:
# code.c:43:     for(j=0;j<Nmax;j++) { /* Producto matricial */
	subl	$1, %ecx	#, ivtmp_69
	je	.L11	#,
.L8:
	movl	$700, %edx	#, ivtmp_59
	jmp	.L12	#
.L11:
# code.c:54:     clock_gettime(CLOCK_MONOTONIC, &final);
	leaq	final(%rip), %rsi	#, tmp116
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	inicio(%rip), %rdx	# inicio.tv_sec, _15
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	8+inicio(%rip), %rcx	# inicio.tv_nsec, _19
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	%rcx, %rax	# _19, tmp120
	subq	8+overhead(%rip), %rax	# overhead.tv_nsec, tmp120
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# tmp121
	cvtsi2sdq	%rax, %xmm0	# tmp120, tmp121
	movsd	.LC3(%rip), %xmm1	#, tmp123
	divsd	%xmm1, %xmm0	# tmp123, tmp122
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	%rdx, %rax	# _15, tmp125
	subq	overhead(%rip), %rax	# overhead.tv_sec, tmp125
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	pxor	%xmm2, %xmm2	# tmp126
	cvtsi2sdq	%rax, %xmm2	# tmp125, tmp126
	addsd	%xmm2, %xmm0	# tmp126, tmp127
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movsd	%xmm0, tiempo_overhead(%rip)	# tmp127, tiempo_overhead
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	8+final(%rip), %rax	# final.tv_nsec, tmp129
	subq	%rcx, %rax	# _19, tmp129
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	pxor	%xmm0, %xmm0	# tmp131
	cvtsi2sdq	%rax, %xmm0	# tmp129, tmp131
	divsd	%xmm1, %xmm0	# tmp123, tmp132
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	final(%rip), %rax	# final.tv_sec, tmp135
	subq	%rdx, %rax	# _15, tmp135
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	pxor	%xmm1, %xmm1	# tmp137
	cvtsi2sdq	%rax, %xmm1	# tmp135, tmp137
	addsd	%xmm1, %xmm0	# tmp137, _32
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movsd	%xmm0, tiempo(%rip)	# _32, tiempo
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	$700, %ecx	#,
	leaq	.LC4(%rip), %rdx	#, tmp138
	movl	$1, %esi	#,
	movq	%rbx, %rdi	# file,
	movl	$1, %eax	#,
	call	__fprintf_chk@PLT	#
# code.c:64:     fclose(file);
	movq	%rbx, %rdi	# file,
	call	fclose@PLT	#
# code.c:65:     return 0;
	movl	$0, %eax	#, <retval>
.L2:
# code.c:66: }
	popq	%rbx	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.globl	nombre_archivo
	.bss
	.align 8
	.type	nombre_archivo, @object
	.size	nombre_archivo, 8
nombre_archivo:
	.zero	8
	.globl	tiempo_overhead
	.align 8
	.type	tiempo_overhead, @object
	.size	tiempo_overhead, 8
tiempo_overhead:
	.zero	8
	.globl	tiempo
	.align 8
	.type	tiempo, @object
	.size	tiempo, 8
tiempo:
	.zero	8
	.globl	overhead
	.align 16
	.type	overhead, @object
	.size	overhead, 16
overhead:
	.zero	16
	.globl	final
	.align 16
	.type	final, @object
	.size	final, 16
final:
	.zero	16
	.globl	inicio
	.align 16
	.type	inicio, @object
	.size	inicio, 16
inicio:
	.zero	16
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC3:
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
