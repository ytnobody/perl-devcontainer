package MyToDoApp::Domain::HTTPDomain;
use v5.36;
use Function::Parameters;

fun invalid_request($class) {
  return (json => {message => "invalid request"}, status => 400);
}

fun resource_not_found($class) {
  return (json => {message => "resource not found"}, status => 400);
}

fun internal_server_error($class, $message = "unknown error") {
  return (json => {message => "internal server error : $message"}, status => 500);
}

1;
