use v6;

use Web::Request;
use Web::Response;

use Tags;

class Yarn {
    method call($env) {
        my Web::Request $req .= new($env);
        my Web::Response $res .= new;

        given $req.GET<mode> // '' {
            # XXX: Workaround. Want POST here.
            when $req.GET<title> ne '' {
                my $p = $req.GET;
                unless 'data' ~~ :d {
                    run('mkdir data');
                }
                my @posts = get-posts();
                @posts.unshift( { title => $p<title>,
                               content => $p<content> } );
                my $fh = open('data/posts', :w) or die $!;
                $fh.print( @posts.perl );
                $fh.close;
            }

            when 'write' {
                $res.write(show {
                    html { title { 'Writing a post' } }
                    body {
                        form :action</?mode=create>, :method<get>, {
                            p { input :name<title>, { '' } }
                            p { textarea :name<content>, { '' } }
                            p { input :type<submit>, { '' } }
                        }
                    }
                });
            }

            default {
                my @posts = get-posts();

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

    sub get-posts() {
        'data/posts' ~~ :f
            ?? eval(slurp('data/posts')).list
            !! ()
    }
}
