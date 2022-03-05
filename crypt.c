#include <shadow.h>
#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/time.h>
#include <unistd.h>
#include <stdlib.h>
#include <pwd.h>
#include <grp.h>
#include <time.h>

char *
crypt_make_salt()
{
	struct timeval tv;
	static char result[40];

	result[0] = '\0';
	strcpy(result, "$1$"); 

	gettimeofday(&tv, (struct timezone *) 0);
	strcat(result, l64a(tv.tv_usec));
	strcat(result, l64a(tv.tv_sec + getpid() + clock()));

	if (strlen(result) > 3 + 8)  
		result[11] = '\0';

	return result;
}

int 
main(int argc, char **argv)
{
int	fd;
const struct passwd *pwd;
struct group *gr;
uid_t uid_min, uid_max;
/* static uid_t	user_id; */
long int user_id, dias; 
char	*crypt_pass;
char	userid[256], groupid[256], *caca;
struct passwd *pw;
struct spwd *sp;
char	*crypt ();
char 	linea[256], path[256];
time_t	segundos;

if (argc<2) {
   puts("Uso: crypt password_sin_encriptar");
   exit(1);
}

crypt_pass = crypt(argv[1],crypt_make_salt()); 
printf("%s", crypt_pass);
exit(0); 
}
