	.file	"minj.c"
	.text
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
	.string	"%d\t%d\t%.9f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	cmpl	$1, %edi
	jle	.L43
	movq	8(%rsi), %rdi
	movq	%rdi, nombre_archivo(%rip)
	leaq	.LC1(%rip), %rsi
	call	fopen@PLT
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L44
	movl	$600, %edx
	jmp	.L4
.L43:
	leaq	.LC0(%rip), %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L1
.L44:
	leaq	.LC2(%rip), %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L1
.L46:
	subl	$1, %edx
	je	.L45
.L4:
	movl	$600, %ecx
.L5:
	subl	$8, %ecx
	jne	.L5
	jmp	.L46
.L45:
	leaq	overhead(%rip), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	leaq	inicio(%rip), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movl	$5, %esi
	jmp	.L7
.L47:
	subl	$1, %r8d
	je	.L9
.L11:
	movl	$600, %r9d
.L8:
	subl	$8, %r9d
	jne	.L8
	jmp	.L47
.L9:
	subl	$1, %edi
	je	.L10
.L13:
	movl	$5, %r8d
	jmp	.L11
.L10:
	subl	$1, %esi
	je	.L17
.L7:
	movl	$600, %edi
	jmp	.L13
.L49:
	subl	$1, %r10d
	je	.L48
.L12:
	movl	$600, %r11d
.L14:
	subl	$8, %r11d
	jne	.L14
	jmp	.L49
.L17:
	movl	$600, %r10d
	jmp	.L12
.L48:
	leaq	final(%rip), %rsi
	movl	$1, %edi
	call	clock_gettime@PLT
	movq	inicio(%rip), %rdx
	movq	8+inicio(%rip), %rcx
	movq	%rcx, %rax
	subq	8+overhead(%rip), %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movsd	.LC3(%rip), %xmm2
	divsd	%xmm2, %xmm1
	movq	%rdx, %rdi
	subq	overhead(%rip), %rdi
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rdi, %xmm0
	addsd	%xmm0, %xmm1
	movsd	%xmm1, tiempo_overhead(%rip)
	movq	8+final(%rip), %r8
	subq	%rcx, %r8
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%r8, %xmm0
	divsd	%xmm2, %xmm0
	movq	final(%rip), %r9
	subq	%rdx, %r9
	pxor	%xmm3, %xmm3
	cvtsi2sdq	%r9, %xmm3
	addsd	%xmm3, %xmm0
	subsd	%xmm1, %xmm0
	movsd	%xmm0, tiempo(%rip)
	movl	$600, %r8d
	movl	$600, %ecx
	leaq	.LC4(%rip), %rdx
	movl	$1, %esi
	movq	%rbx, %rdi
	movl	$1, %eax
	call	__fprintf_chk@PLT
	movq	%rbx, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L1:
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE35:
	.size	main, .-main
	.globl	guardar_imagen
	.type	guardar_imagen, @function
guardar_imagen:
.LFB36:
	.cfi_startproc
	endbr64
	ret
	.cfi_endproc
.LFE36:
	.size	guardar_imagen, .-guardar_imagen
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
