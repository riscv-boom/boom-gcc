(define_automaton "boom")

(define_cpu_unit "boom_alu1" "boom")
(define_cpu_unit "boom_alu2" "boom")
(define_cpu_unit "boom_alu3" "boom")
(define_cpu_unit "boom_alu4" "boom")
(define_cpu_unit "boom_mem" "boom")
(define_cpu_unit "boom_fpu" "boom")

(define_insn_reservation "boom_load" 4
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "load"))
  "boom_mem")

(define_insn_reservation "boom_fpload" 5
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "fpload"))
  "boom_mem")

(define_insn_reservation "boom_store" 1
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "store"))
  "boom_mem")

(define_insn_reservation "boom_fpstore" 1
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "fpstore"))
  "boom_mem + boom_fpu")

(define_insn_reservation "boom_branch" 1
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "branch"))
  "boom_alu1 | boom_alu2 | boom_alu3 | boom_alu4")

(define_insn_reservation "boom_sfb_alu" 1
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "sfb_alu"))
  "boom_alu1 + (boom_alu2 | boom_alu3 | boom_alu4)")

(define_insn_reservation "boom_jump" 1
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "jump,call"))
  "boom_alu1")

(define_insn_reservation "boom_mul" 3
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "imul"))
  "boom_alu2")

(define_insn_reservation "boom_div" 16
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "idiv"))
  "boom_alu3")

(define_insn_reservation "boom_alu" 1
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "unknown,arith,shift,slt,multi,logical,move,nop,const,auipc"))
  "boom_alu1 | boom_alu2 | boom_alu3 | boom_alu4")

(define_insn_reservation "boom_fma" 4
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "fadd,fmul,fmadd,fcvt,fcmp,fmove"))
  "boom_fpu")

(define_insn_reservation "boom_fdiv" 27
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "fdiv,fsqrt"))
  "boom_fpu")

(define_insn_reservation "boom_i2f" 3
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "mtc"))
  "boom_alu4")

(define_insn_reservation "boom_f2i" 3
  (and (eq_attr "tune" "boom")
       (eq_attr "type" "mfc"))
  "boom_fpu")

(define_bypass 1 "boom_load,boom_alu,boom_sfb_alu,boom_jump"
  "boom_alu,boom_branch,boom_sfb_alu,boom_store,boom_load,boom_jump")
