use v5.36;
use Test2::V0;
use Test2::Tools::Subtest qw(subtest_buffered);

my $module = 'MyToDoApp::Domain::HTTPDomain';
use ok 'MyToDoApp::Domain::HTTPDomain';

subtest_buffered invalid_request => sub {
  my $res = [$module->invalid_request()];
  is($res, [json => {message => "invalid request"}, status => 400], 'invalid request');
};

subtest_buffered resource_not_found => sub {
  my $res = [$module->resource_not_found()];
  is($res, [json => {message => "resource not found"}, status => 400], 'resource not found');
};

subtest_buffered internal_server_error => sub {
  my $res = [$module->internal_server_error()];
  is($res, [json => {message => "internal server error : unknown error"}, status => 500], 'internal server error');
};

subtest_buffered internal_server_error_with_message => sub {
  my $res = [$module->internal_server_error('message')];
  is($res, [json => {message => "internal server error : message"}, status => 500], 'internal server error with message');
};

done_testing;