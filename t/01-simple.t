use Example::Hello;
use Test;
plan 3;
my Example::Hello $greeter .= new;
isa_ok( $greeter, 'Example::Hello', 'create object' );
is( $greeter.greet, 'hello', 'greet' );
is( $greeter.place, 'world', 'place' );
