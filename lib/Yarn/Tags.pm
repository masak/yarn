use v6;
module Yarn::Tags;

sub show(&inner) is export {
    # I have no idea what this sub needs to do
    inner();
}

sub enclose($tag, $body, *%attr) {
    my $attr;
    for %attr.kv -> $k, $v {
        $attr ~= " $k=\"$v\"";
    }
    return "<{$tag}{$attr}>{$body}</$tag>";
}

sub html(&inner) is export {
    enclose('html', inner());
}

sub head(&inner) is export {
    enclose('head', inner());
}

sub title(&inner) is export {
    enclose('title', inner());
}

sub body(&inner) is export {
    enclose('body', inner());
}

sub p(&inner) is export {
    enclose('p', inner());
}

sub a(&inner, *%attr) is export {
    enclose('a', inner(), |%attr);
}

sub form(&inner, *%attr) is export {
    enclose('form', inner(), |%attr);
    
}

sub div(&inner, *%attr) is export {
    enclose('div', inner(), |%attr);
}

sub textarea(&inner, *%attr) is export {
    enclose('textarea', inner(), |%attr);
}

sub input(&inner, *%attr) is export {
    enclose('input', inner(), |%attr);
}

sub h1(&inner, *%attr) is export {
    enclose('h1', inner(), |%attr);
}
