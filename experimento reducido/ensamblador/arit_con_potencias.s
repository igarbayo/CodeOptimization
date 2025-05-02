	.file	"arit_con_potencias.c"
	.text
	.globl	nombre_archivo
	.section	.rodata
	.align 8
.LC0:
	.string	"resultados/aritmeticas_con.txt"
	.section	.data.rel.local,"aw"
	.align 8
	.type	nombre_archivo, @object
	.size	nombre_archivo, 8
nombre_archivo:
	.quad	.LC0
	.globl	N
	.data
	.align 4
	.type	N, @object
	.size	N, 4
N:
	.long	95000
	.globl	ITER
	.align 4
	.type	ITER, @object
	.size	ITER, 4
ITER:
	.long	67368
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
	.string	"w"
	.align 8
.LC2:
	.string	"No se pudo abrir el archivo para escribir"
.LC3:
	.string	"N\tARIT_CON\n"
.LC5:
	.string	"Overhead: %lf\n"
.LC6:
	.string	"%d\t%.6f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	addq	$-128, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$16, -116(%rbp)
	movl	$33, -112(%rbp)
	movl	$0, -108(%rbp)
	movl	$0, -128(%rbp)
	movl	$0, -124(%rbp)
	movq	nombre_archivo(%rip), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -104(%rbp)
	cmpq	$0, -104(%rbp)
	jne	.L2
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L10
.L2:
	movq	-104(%rbp), %rax
	movq	%rax, %rcx
	movl	$11, %edx
	movl	$1, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	$0, %esi
	leaq	overhead_start(%rip), %rax
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movl	$0, %esi
	leaq	overhead_end(%rip), %rax
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movq	overhead_end(%rip), %rax
	movq	overhead_start(%rip), %rdx
	subq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	8+overhead_end(%rip), %rax
	movq	8+overhead_start(%rip), %rdx
	subq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC4(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, overhead(%rip)
	movq	overhead(%rip), %rax
	movq	%rax, %xmm0
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, -120(%rbp)
	jmp	.L4
.L9:
	movl	$0, %esi
	leaq	start_time(%rip), %rax
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movl	$0, -124(%rbp)
	jmp	.L5
.L8:
	movl	$0, -128(%rbp)
	jmp	.L6
.L7:
	movl	-112(%rbp), %eax
	imull	-116(%rbp), %eax
	movl	%eax, -108(%rbp)
	addl	$1, -128(%rbp)
.L6:
	movl	N(%rip), %eax
	cmpl	%eax, -128(%rbp)
	jl	.L7
	addl	$1, -124(%rbp)
.L5:
	movl	ITER(%rip), %eax
	cmpl	%eax, -124(%rbp)
	jl	.L8
	movl	$0, %esi
	leaq	end_time(%rip), %rax
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movq	end_time(%rip), %rax
	movq	start_time(%rip), %rdx
	subq	%rdx, %rax
	pxor	%xmm1, %xmm1
	cvtsi2sdq	%rax, %xmm1
	movq	8+end_time(%rip), %rax
	movq	8+start_time(%rip), %rdx
	subq	%rdx, %rax
	pxor	%xmm0, %xmm0
	cvtsi2sdq	%rax, %xmm0
	movsd	.LC4(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	overhead(%rip), %xmm1
	subsd	%xmm1, %xmm0
	movl	ITER(%rip), %eax
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	divsd	%xmm1, %xmm0
	movl	-120(%rbp), %eax
	cltq
	movsd	%xmm0, -96(%rbp,%rax,8)
	movl	-120(%rbp), %eax
	cltq
	movq	-96(%rbp,%rax,8), %rcx
	movl	N(%rip), %edx
	movq	-104(%rbp), %rax
	movq	%rcx, %xmm0
	leaq	.LC6(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf@PLT
	addl	$1, -120(%rbp)
.L4:
	cmpl	$9, -120(%rbp)
	jle	.L9
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L10:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC4:
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
