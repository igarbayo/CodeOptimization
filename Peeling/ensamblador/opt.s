	.file	"test_opt.c"
	.text
	.globl	nombre_archivo
	.section	.rodata
.LC0:
	.string	"resultados/NOCHE-opt.txt"
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
	.quad	6400000000
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
	.string	"N recibido: %d\n"
.LC3:
	.string	"w"
	.align 8
.LC4:
	.string	"No se pudo abrir el archivo para escribir"
.LC5:
	.string	"N\tOPT\n"
.LC7:
	.string	"Overhead: %lf\n"
.LC9:
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
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$136, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movl	%edi, -132(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	movq	%rsp, %rax
	movq	%rax, %rbx
	cmpl	$1, -132(%rbp)
	jg	.L2
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L3
.L2:
	movq	-144(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	atoi@PLT
	movl	%eax, -112(%rbp)
	movl	-112(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movabsq	$6400000000, %rax
	movl	-112(%rbp), %edx
	movslq	%edx, %rsi
	cqto
	idivq	%rsi
	movl	%eax, -108(%rbp)
	movq	nombre_archivo(%rip), %rax
	leaq	.LC3(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -104(%rbp)
	cmpq	$0, -104(%rbp)
	jne	.L4
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %eax
	jmp	.L3
.L4:
	movq	-104(%rbp), %rax
	movq	%rax, %rcx
	movl	$6, %edx
	movl	$1, %esi
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	fwrite@PLT
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -96(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, -160(%rbp)
	movq	$0, -152(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, -176(%rbp)
	movq	$0, -168(%rbp)
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %esi
	movl	$0, %edx
	divq	%rsi
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L5:
	cmpq	%rdx, %rsp
	je	.L6
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L5
.L6:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L7
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L7:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -88(%rbp)
	movl	-112(%rbp), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -80(%rbp)
	movslq	%eax, %rdx
	movq	%rdx, %r14
	movl	$0, %r15d
	movslq	%eax, %rdx
	movq	%rdx, %r12
	movl	$0, %r13d
	cltq
	leaq	0(,%rax,4), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %esi
	movl	$0, %edx
	divq	%rsi
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L8:
	cmpq	%rdx, %rsp
	je	.L9
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L8
.L9:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L10
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L10:
	movq	%rsp, %rax
	addq	$3, %rax
	shrq	$2, %rax
	salq	$2, %rax
	movq	%rax, -72(%rbp)
	movl	$0, -120(%rbp)
	jmp	.L11
.L12:
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-120(%rbp), %xmm0
	movq	-88(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	%xmm0, (%rax,%rdx,4)
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-120(%rbp), %xmm0
	movq	-72(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	%xmm0, (%rax,%rdx,4)
	addl	$1, -120(%rbp)
.L11:
	movl	-120(%rbp), %eax
	cmpl	-112(%rbp), %eax
	jl	.L12
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
	movsd	.LC6(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, overhead(%rip)
	movq	overhead(%rip), %rax
	movq	%rax, %xmm0
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	printf@PLT
	movl	$0, %esi
	leaq	start_time(%rip), %rax
	movq	%rax, %rdi
	call	gettimeofday@PLT
	movl	$0, -116(%rbp)
	jmp	.L13
.L18:
	movl	$0, -120(%rbp)
	jmp	.L14
.L15:
	movq	-88(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	(%rax,%rdx,4), %xmm1
	movq	-72(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	(%rax,%rdx,4), %xmm0
	addss	%xmm1, %xmm0
	movq	-88(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	%xmm0, (%rax,%rdx,4)
	addl	$1, -120(%rbp)
.L14:
	movl	-112(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	cmpl	%eax, -120(%rbp)
	jl	.L15
	movl	-112(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	movl	%eax, %edx
	movq	-88(%rbp), %rax
	movslq	%edx, %rdx
	pxor	%xmm0, %xmm0
	movss	%xmm0, (%rax,%rdx,4)
	movl	-112(%rbp), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	addl	$1, %eax
	movl	%eax, -120(%rbp)
	jmp	.L16
.L17:
	movq	-88(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	(%rax,%rdx,4), %xmm1
	movq	-72(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	(%rax,%rdx,4), %xmm0
	addss	%xmm1, %xmm0
	movq	-88(%rbp), %rax
	movl	-120(%rbp), %edx
	movslq	%edx, %rdx
	movss	%xmm0, (%rax,%rdx,4)
	addl	$1, -120(%rbp)
.L16:
	movl	-112(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, -120(%rbp)
	jl	.L17
	movl	-112(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	-112(%rbp), %eax
	leal	-1(%rax), %edx
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%ecx, %xmm0
	movq	-88(%rbp), %rax
	movslq	%edx, %rdx
	movss	%xmm0, (%rax,%rdx,4)
	addl	$1, -116(%rbp)
.L13:
	movl	-116(%rbp), %eax
	cmpl	-108(%rbp), %eax
	jl	.L18
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
	movsd	.LC6(%rip), %xmm2
	divsd	%xmm2, %xmm0
	addsd	%xmm1, %xmm0
	movsd	overhead(%rip), %xmm1
	subsd	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	-108(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -64(%rbp)
	movq	-64(%rbp), %rcx
	movl	-112(%rbp), %edx
	movq	-104(%rbp), %rax
	movq	%rcx, %xmm0
	leaq	.LC9(%rip), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	movl	$1, %eax
	call	fprintf@PLT
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L3:
	movq	%rbx, %rsp
	movq	-56(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L20
	call	__stack_chk_fail@PLT
.L20:
	leaq	-40(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
	.align 8
.LC6:
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
