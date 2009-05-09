use v6;

use Web::Request;
use Web::Response;

use Tags;

class Yarn {
    method call($env) {
        my Web::Request $req .= new($env);
        my Web::Response $res .= new;

        if $req.request_method eq 'POST' {
            my $fh = open('data/posts', :w) or die $!;
            $fh.print( [ { title => 'test', content => '1, 2, 3' } ].perl );
            $fh.close;
        }

        given $req.GET<mode> // '' {
            when 'write' {
                $res.write(show {
                    html { title { 'Writing a post' } }
                    body {
                        form :action</>, :method<post>, {
                            input :type<submit>, {};
                        }
                    }
                });
            }

            default {
                my @posts =
                    { title => "foo", content => "foo content" },
                    { title => "bar", content => "bar content" };

                $res.write(show {
                    html {
                        head { title { 'Yarn' } }
                        body {
                            p {
                                a :href</?mode=write>, { 'Write a new post' }
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
            }
        }

        $res.finish();
    }
}
