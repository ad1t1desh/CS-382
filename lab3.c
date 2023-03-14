#include <stdio.h>
#include <math.h>
#include <stdlib.h>

void calc(double a, double b, int n){ //lower bound, upper bound, initial number of rectangles 
    if (b>a){
        double deltx = (b-a)/n; 
        double approx1 = 0;  
        double approx2 = 0; 
        double midpt = a + deltx/2;
        double sum = 0; 
        for (int i = 0; i<n; i++){ 
            sum = sum + 2.5* pow(midpt, 3) - 15.5 * pow(midpt, 2) + 20*midpt + 15; 
            midpt = midpt + deltx; 
        }
        approx1 = sum * deltx;
        n *= 2;
        sum = 0;
        deltx = (b-a)/n; 
        midpt = a + deltx/2;
        for (int i = 0; i<n; i++){ 
            sum = sum + 2.5* pow(midpt, 3) - 15.5 * pow(midpt, 2) + 20*midpt + 15; 
            midpt = midpt + deltx;
        } 
        approx2 = sum * deltx;            
        while(fabs(approx1-approx2) > 0.0001){
        approx1 = approx2;
        n *= 2;
        sum = 0;
        deltx = (b-a)/n; 
        midpt = a + deltx/2;
        for (int i = 0; i<n; i++){ 
            sum = sum + 2.5* pow(midpt, 3) - 15.5 * pow(midpt, 2) + 20*midpt + 15; 
            midpt = midpt + deltx; 
            approx2 = sum * deltx;

            }
        }
        printf("final number of rectangles %d\n", n);//reset for an int 
        printf("most recent guess: %lf\n", approx1);
        printf("%lf\n", approx2); 
    }

}  




int main(int argc, char const *argv[]) {
    double a = atof(argv[1]);
    double b = atof(argv[2]);
    int n = atoi(argv[3]);
    calc(a,b,n); 
}