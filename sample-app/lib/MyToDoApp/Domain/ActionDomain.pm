package MyToDoApp::Domain::ActionDomain;

use v5.36;
use Types::Standard -types;
use Function::Parameters;

use MyToDoApp::Types qw(CreateActionParams);

fun build_action ($class, Int $task_id, Str $description, Int $created_at, Int $updated_at) {
  my $action = {
    task_id     => $task_id,
    description => $description,
    created_at  => $created_at,
    updated_at  => $updated_at,
  };
  return $action;
}

fun insert_query ($class, CreateActionParams $action) {
  return ('insert', 'action', $action);
}

fun get_by_id_query ($class, Int $id) {
  return ('single', 'action', {id => $id});
}

fun select_by_task_id_query ($class, Int $task_id) {
  return ('select', 'action', {task_id => $task_id});
}

1;