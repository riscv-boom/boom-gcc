/*  DO NOT EDIT THIS FILE.

    It has been auto-edited by fixincludes from:

	"fixinc/tests/inc/stdio.h"

    This had to be done to correct non-standard usages in the
    original, manufacturer supplied header file.  */

#ifndef FIXINC_WRAP_STDIO_H_STDIO_STDARG_H
#define FIXINC_WRAP_STDIO_H_STDIO_STDARG_H 1

#define __need___va_list
#include <stdarg.h>


#if defined( ALPHA_GETOPT_CHECK )
extern int getopt(int, char *const[], const char *);
#endif  /* ALPHA_GETOPT_CHECK */


#if defined( BSD_STDIO_ATTRS_CONFLICT_CHECK )
#define _BSD_STRING(_BSD_X) _BSD_STRINGX(_BSD_X)
#define _BSD_STRINGX(_BSD_X) #_BSD_X
int vfscanf(FILE *, const char *, __builtin_va_list) __asm__ (_BSD_STRING(__USER_LABEL_PREFIX__) "__svfscanf");
#endif  /* BSD_STDIO_ATTRS_CONFLICT_CHECK */


#if defined( HPUX11_VSNPRINTF_CHECK )
extern int vsnprintf(char *, _hpux_size_t, const char *, __gnuc_va_list);
#endif  /* HPUX11_VSNPRINTF_CHECK */


#if defined( HPUX11_SNPRINTF_CHECK )
extern int snprintf(char *, size_t, const char *, ...);
extern int snprintf(char *, _hpux_size_t, const char *, ...);
extern int snprintf(char *, _hpux_size_t, const char *, ...);
#endif  /* HPUX11_SNPRINTF_CHECK */


#if defined( IRIX_STDIO_DUMMY_VA_LIST_CHECK )
extern int printf( const char *, __gnuc_va_list );
#endif  /* IRIX_STDIO_DUMMY_VA_LIST_CHECK */


#if defined( ISC_OMITS_WITH_STDC_CHECK )
#if !defined(_POSIX_SOURCE) /* ? ! */
int foo;
#endif
#endif  /* ISC_OMITS_WITH_STDC_CHECK */


#if defined( READ_RET_TYPE_CHECK )
extern unsigned int fread(), fwrite();
extern int	fclose(), fflush(), foo();
#endif  /* READ_RET_TYPE_CHECK */


#if defined( RS6000_PARAM_CHECK )
extern int rename(const char *_old, const char *_new);
#endif  /* RS6000_PARAM_CHECK */


#if defined( STDIO_STDARG_H_CHECK )

#endif  /* STDIO_STDARG_H_CHECK */


#if defined( STDIO_DUMMY_VA_LIST_CHECK )
extern void mumble( __gnuc_va_list);
#endif  /* STDIO_DUMMY_VA_LIST_CHECK */


#if defined( ULTRIX_CONST_CHECK )
extern void perror( const char *__s );
extern int fputs( const char *__s, FILE *);
extern size_t fwrite( const void *__ptr, size_t, size_t, FILE *);
extern int fscanf( FILE *__stream, const char *__format, ...);
extern int scanf( const char *__format, ...);

#endif  /* ULTRIX_CONST_CHECK */


#if defined( ULTRIX_CONST2_CHECK )
extern FILE *fopen( const char *__filename, const char *__type );
extern int sscanf( const char *__s, const char *__format, ...);
extern FILE *popen( const char *, const char *);
extern char *tempnam( const char *, const char *);

#endif  /* ULTRIX_CONST2_CHECK */


#if defined( UNICOSMK_RESTRICT_CHECK )
void f (char * __restrict__ x);
#endif  /* UNICOSMK_RESTRICT_CHECK */

#endif  /* FIXINC_WRAP_STDIO_H_STDIO_STDARG_H */
