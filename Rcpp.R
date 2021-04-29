# Rcpp tutorial: https://teuder.github.io/rcpp4everyone_en/index.html
library(Rcpp)
library(microbenchmark)

cppFunction('
            double cpp_med2(Rcpp::NumericVector xx) {
            Rcpp::NumericVector x = Rcpp::clone(xx);
            std::size_t n = x.size() / 2;
            std::nth_element(x.begin(), x.begin() + n, x.end());
            
            // Rcout << "Median of {" << xx << "} is:" << std::endl;
            // std::cout << "Median of {" << xx << "} is:" << std::endl;

            if (x.size() % 2) return x[n]; 
            return (x[n] + *std::max_element(x.begin(), x.begin() + n)) / 2.;
            }
            ')


# Check equality and performance
set.seed(123)
x=rnorm(1e6)
all.equal(median(x), cpp_med2(x))  # equality
microbenchmark::microbenchmark(median(x), cpp_med2(x), times=20L)  # perform


a=c(10, 1, 4, 5)
cpp_med2(a)
