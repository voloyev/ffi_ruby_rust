`$ruby test_file.rb 40`


```
                 user     system      total        real
embbed rust
fib
             0.267198   0.006861   0.274059 (  0.282539)
fib_iter
             0.000010   0.000001   0.000011 (  0.000010)
fac
             0.000007   0.000001   0.000008 (  0.000007)

fac_i
             0.000007   0.000001   0.000008 (  0.000006)

just ruby
fib
             6.882950   0.135102   7.018052 (  7.190768)
fib_iter
             0.000015   0.000005   0.000020 (  0.000027)
fac
             0.000019   0.000014   0.000033 (  0.000037)

fac_i
             0.000013   0.000002   0.000015 (  0.000013)
```


## usage

`$cargo build --release`

then

### RUBY ###

`$ruby benchmark_file.rb 40 # pass any positive mumber default 20`

*note* you have to install ruby to run this examples

### Python ###

``
