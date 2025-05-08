	.file	"code.c"
# GNU C17 (Ubuntu 11.4.0-1ubuntu1~22.04) version 11.4.0 (x86_64-linux-gnu)
#	compiled by GNU C version 11.4.0, GMP version 6.2.1, MPFR version 4.1.0, MPC version 1.2.1, isl version isl-0.24-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mtune=generic -march=x86-64 -Os -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.globl	producto
	.type	producto, @function
producto:
.LFB13:
	.cfi_startproc
	endbr64	
# code.c:12:     *z=x*y;
	mulss	%xmm1, %xmm0	# tmp88, tmp86
# code.c:12:     *z=x*y;
	movss	%xmm0, (%rdi)	# tmp86, *z_5(D)
# code.c:13: }
	ret	
	.cfi_endproc
.LFE13:
	.size	producto, .-producto
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Debes pasar un nombre de fichero"
.LC1:
	.string	"a"
.LC2:
	.string	"No se pudo abrir el fichero"
.LC4:
	.string	"%d\t%.9f\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB14:
	.cfi_startproc
	endbr64	
# code.c:20:     if (argc < 2) {
	decl	%edi	# tmp136
# code.c:15: int main(int argc, char** argv) {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
# code.c:21:         perror("Debes pasar un nombre de fichero");
	leaq	.LC0(%rip), %rdi	#, tmp106
# code.c:20:     if (argc < 2) {
	jle	.L7	#,
# code.c:24:     nombre_archivo = argv[1];
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_26(D) + 8B], _1
# code.c:25:     FILE* file = fopen(nombre_archivo, "a");
	leaq	.LC1(%rip), %rsi	#, tmp107
# code.c:24:     nombre_archivo = argv[1];
	movq	%rdi, nombre_archivo(%rip)	# _1, nombre_archivo
# code.c:25:     FILE* file = fopen(nombre_archivo, "a");
	call	fopen@PLT	#
	movq	%rax, %rbp	# tmp138, tmp108
# code.c:26:     if (file == NULL) {
	testq	%rax, %rax	# tmp108
	jne	.L5	#,
# code.c:27:         perror("No se pudo abrir el fichero");
	leaq	.LC2(%rip), %rdi	#, tmp109
.L7:
	call	perror@PLT	#
# code.c:28:         return 1;
	movl	$1, %eax	#, <retval>
	jmp	.L2	#
.L5:
# code.c:40:     clock_gettime(CLOCK_MONOTONIC, &overhead);
	leaq	overhead(%rip), %rsi	#, tmp110
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:41:     clock_gettime(CLOCK_MONOTONIC, &inicio);
	leaq	inicio(%rip), %rsi	#, tmp111
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:54:     clock_gettime(CLOCK_MONOTONIC, &final);
	leaq	final(%rip), %rsi	#, tmp112
	movl	$1, %edi	#,
	call	clock_gettime@PLT	#
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	8+inicio(%rip), %rcx	# inicio.tv_nsec, _6
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	$1, %esi	#,
	movq	%rbp, %rdi	# tmp108,
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movsd	.LC3(%rip), %xmm2	#, tmp119
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	inicio(%rip), %rdx	# inicio.tv_sec, _2
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	%rcx, %rax	# _6, tmp116
	subq	8+overhead(%rip), %rax	# overhead.tv_nsec, tmp116
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm1	# tmp116, tmp117
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movq	%rdx, %rax	# _2, tmp121
	subq	overhead(%rip), %rax	# overhead.tv_sec, tmp121
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm0	# tmp121, tmp122
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	8+final(%rip), %rax	# final.tv_nsec, tmp124
	subq	%rcx, %rax	# _6, tmp124
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movl	$500, %ecx	#,
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	divsd	%xmm2, %xmm1	# tmp119, tmp118
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	addsd	%xmm0, %xmm1	# tmp122, _11
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm0	# tmp124, tmp126
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	movq	final(%rip), %rax	# final.tv_sec, tmp130
	subq	%rdx, %rax	# _2, tmp130
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	leaq	.LC4(%rip), %rdx	#, tmp134
# code.c:57:     tiempo_overhead = (inicio.tv_sec - overhead.tv_sec) + (inicio.tv_nsec - overhead.tv_nsec) / 1e9;
	movsd	%xmm1, tiempo_overhead(%rip)	# _11, tiempo_overhead
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	divsd	%xmm2, %xmm0	# tmp119, tmp127
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	cvtsi2sdq	%rax, %xmm2	# tmp130, tmp132
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	movb	$1, %al	#,
# code.c:58:     tiempo = (final.tv_sec - inicio.tv_sec) + (final.tv_nsec - inicio.tv_nsec) / 1e9;
	addsd	%xmm2, %xmm0	# tmp132, tmp133
# code.c:59:     tiempo = tiempo - tiempo_overhead;
	subsd	%xmm1, %xmm0	# _11, _20
# code.c:59:     tiempo = tiempo - tiempo_overhead;
	movsd	%xmm0, tiempo(%rip)	# _20, tiempo
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:105:   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
	call	__fprintf_chk@PLT	#
# code.c:65:     fclose(file);
	movq	%rbp, %rdi	# tmp108,
	call	fclose@PLT	#
# code.c:66:     return 0;
	xorl	%eax, %eax	# <retval>
.L2:
# code.c:67: }
	popq	%rbp	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE14:
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
