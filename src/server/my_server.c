#include <fcgi_stdio.h>
#include <stdlib.h>

int main() {
    while (FCGI_Accept() >= 0) {  // <- важно: бесконечный цикл
        printf("Content-type: text/html\r\n\r\n");
        printf("<h1>Hello, my dear world!</h1>\n");
    }
    return 0;
}

