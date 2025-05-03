	.file	"test_opt_old.c"
	.text
	.globl	nombre_archivo
	.section	.rodata
	.align 8
.LC0:
	.string	"resultados/NOCHE-res_OPT_OLD.txt"
	.section	.data.rel.local,"aw"
	.align 8
	.type	nombre_archivo, @object
	.size	nombre_archivo, 8
nombre_archivo:
	.quad	.LC0
	.globl	N
	.data
	.align 32
	.type	N, @object
	.size	N, 160
N:
	.long	3000
	.long	4500
	.long	7000
	.long	9500
	.long	12000
	.long	17000
	.long	25000
	.long	34000
	.long	40000
	.long	56000
	.long	78000
	.long	95000
	.long	110000
	.long	160000
	.long	250000
	.long	320000
	.long	390000
	.long	570000
	.long	820000
	.long	1000000
	.long	1190000
	.long	1500000
	.long	1750000
	.long	1990000
	.long	2550000
	.long	3190000
	.long	4200000
	.long	5100000
	.long	5900000
	.long	7800000
	.long	9500000
	.long	11800000
	.long	15900000
	.long	23900000
	.long	53000000
	.long	95000000
	.long	199000000
	.long	383000000
	.long	959000000
	.long	1910000000
	.section	.rodata
.LC1:
	.string	"%d = %d\n"
	.text
	.globl	generar_ITER
	.type	generar_ITER, @function
generar_ITER:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movabsq	$6400000000, %rax
	movq	%rax, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L2
.L3:
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	N(%rip), %rax
	movl	(%rdx,%rax), %eax
	movslq	%eax, %rsi
	movq	-8(%rbp), %rax
	cqto
	idivq	%rsi
	movq	%rax, %rdx
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rcx
	movq	-24(%rbp), %rax
	addq	%rcx, %rax
	movl	%edx, (%rax)
	movl	-12(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	movq	-24(%rbp), %rax
	addq	%rdx, %rax
	movl	(%rax), %edx
	movl	-12(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	addl	$1, -12(%rbp)
.L2:
	movl	-12(%rbp), %eax
	cmpl	$39, %eax
	jbe	.L3
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	generar_ITER, .-generar_ITER
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
.LC2:
	.string	"w"
	.align 8
.LC3:
	.string	"No se pudo abrir el archivo para escribir"
.LC4:
	.string	"N\tOPT_OLD\n"
.LC6:
	.string	"Overhead: %lf\n"
.LC7:
	.string	"%d\t%.6f\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$384, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-336(%rbp), %rax
	movq	%rax, %rdi
	call	generar_ITER
	movq	nombre_archivo(%rip), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -344(%rbp)
	cmpq	$0, -344(%rbp)
	jne	.L5
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L15
.L5:
	movq	-344(%rbp), %rax
	movq	%rax, %rcx
	movl	$10, %edx
	movl	$1, %esi
	leaq	.LC4(%rip), %rax
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
	movsd	.LC5(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, overhead(%rip)
	movq	overhead(%rip), %rax
	movq	%rax, %xmm0
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, -356(%rbp)
	movl	$0, -368(%rbp)
	movl	$0, -364(%rbp)
	jmp	.L7
.L14:
	movl	-364(%rbp), %eax
	cltq
	leaq	0(,%rax,4), %rdx
	leaq	N(%rip), %rax
	movl	(%rdx,%rax), %eax
	movl	%eax, -352(%rbp)
	movl	-364(%rbp), %eax
	cltq
	movl	-336(%rbp,%rax,4), %eax
	movl	%eax, -348(%rbp)
	movl	$0, -360(%rbp)
	jmp	.L8
.L13:
	movl	$0, -368(%rbp)
	movl	$0, %esi
	leaq	start_time(%rip), %rax
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movl	$0, -372(%rbp)
	jmp	.L9
.L12:
	movl	$0, -376(%rbp)
	jmp	.L10
.L11:
	movl	-376(%rbp), %eax
	sarl	$2, %eax
	addl	%eax, -368(%rbp)
	addl	$1, -376(%rbp)
.L10:
	movl	-376(%rbp), %eax
	cmpl	-352(%rbp), %eax
	jl	.L11
	movl	-352(%rbp), %eax
	subl	$1, %eax
	sall	$3, %eax
	movl	%eax, -356(%rbp)
	addl	$1, -372(%rbp)
.L9:
	movl	-372(%rbp), %eax
	cmpl	-348(%rbp), %eax
	jl	.L12
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
	movsd	.LC5(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	overhead(%rip), %xmm1
	subsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	-348(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movl	-360(%rbp), %eax
	cltq
	movsd	%xmm0, -176(%rbp,%rax,8)
	movl	-360(%rbp), %eax
	cltq
	movq	-176(%rbp,%rax,8), %rcx
	movl	-352(%rbp), %edx
	movq	-344(%rbp), %rax
	movq	%rcx, %xmm0
	leaq	.LC7(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf@PLT
	addl	$1, -360(%rbp)
.L8:
	cmpl	$19, -360(%rbp)
	jle	.L13
	addl	$1, -364(%rbp)
.L7:
	movl	-364(%rbp), %eax
	cmpl	$39, %eax
	jbe	.L14
	movq	-344(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L15:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L16
	call	__stack_chk_fail@PLT
.L16:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
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
