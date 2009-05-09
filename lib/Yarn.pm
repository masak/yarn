use v6;

use Web::Request;
use Web::Response;

use Tags;

class Yarn {
    method call($env) {
        my Web::Request $req .= new($env);
        
        my Web::Response $res .= new;

        my @posts =
            { title => "foo", content => "foo content" },
            { title => "bar", content => "bar content" };

        $res.write(show {
            html {
                head { title { 'Yarn' } }
                body {
                    p {
                        a :href</create>, { 'Create new post' }
                    }
                    for @posts -> $post {
                        div :class<post>, {
                            h1 { $post<title> };
                            div { $post<content> };
                        }
                    }
                }
            }
        });
        $res.finish();
    }
}
