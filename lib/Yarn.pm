use v6;

use Web::Request;
use Web::Response;

class Yarn {
    method call($env) {
        my Web::Request $req .= new($env);
        
        my Web::Response $res .= new;
        $res.write('<html><p>OH HAI</p></html>');
        $res.finish();
    }
}
